package;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import animate.FlxAnimate;
import animate.FlxAnimateFrames;
import flixel.FlxState;
import flixel.FlxCamera;
import flixel.addons.effects.FlxTrail;
import flixel.addons.display.FlxTiledSprite;
import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.sound.FlxSound;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxAxes;
import flixel.util.FlxGradient;
import flixel.util.FlxTimer;
import flixel.math.FlxPoint;
import haxe.Json;
import hscript.Interp;
import hscript.Parser;
import openfl.display.BlendMode;
import openfl.filters.ShaderFilter;
import openfl.utils.Assets;
import shaderslmfao.AdjustColorShader;
import shaderslmfao.BuildingShaders;
import shaderslmfao.MissMeShader;
import shaderslmfao.RainShader;
import shaderslmfao.Vinegar;
import shaderslmfao.GausianBlur;
import shaderslmfao.WarpShader;
#if (VIDEOS_ALLOWED && !html5)
import hxcodec.VideoSprite;
#end
#if sys
import sys.FileSystem;
import sys.io.File;
#end

class Stage
{
	public static inline var STAGE_DIR:String = 'data/stages/';

	var state:FlxState;

	public var curStage:String = 'stage';
	public var defaultCamZoom:Float = 1.05;
	public var gfVersion:String = 'gf';

	public var cameraOffsetDadX:Int = 0;
	public var cameraOffsetDadY:Int = 0;
	public var cameraOffsetbfX:Int = 0;
	public var cameraOffsetbfY:Int = 0;

	public var camGame:FlxCamera;
	public var camHUD:FlxCamera;

	var dad:Character;
	var gf:Character;
	var boyfriend:Boyfriend;

	public var extraBoyfriends:Array<Character> = [];
	public var extraDads:Array<Character> = [];

	var placeholders:Map<String, FlxSprite> = new Map();

	public var foregroundSprites:FlxTypedGroup<BGSprite>;

	public var trainSound:FlxSound;
	public var trainMoving:Bool = false;

	public var limo:FlxSprite;

	public var tankmanRun:FlxTypedGroup<TankmenBG>;

	public var rainColor:Int = 0xFF6680cc;
	public var rainTimeScale:Float = 1.0;

	var interp:Interp;
	var songName:String = '';
	var reportedErrors:Map<String, Bool> = new Map();

	public function new(state:FlxState)
	{
		this.state = state;
	}

	function add<T:FlxBasic>(object:T):T
	{
		state.add(object);
		return object;
	}

	public function build(song:String, ?stageName:String):Void
	{
		foregroundSprites = new FlxTypedGroup<BGSprite>();
		songName = song.toLowerCase();

		if (stageName != null && stageName != '' && readText(STAGE_DIR + stageName + '.hx') != null)
			curStage = stageName;
		else
			curStage = findStageForSong(songName);

		loadScript(curStage);
		callScript('create');
	}

	static function readText(rel:String):Null<String>
	{
		var p:String = Paths.file(rel);
		return Assets.exists(p) ? Assets.getText(p) : null;
	}

	static function findStageForSong(songName:String):String
	{
		var fallback:String = 'stage';
		var found:Null<String> = null;
		var sources:Array<String> = [];

		var basePath:String = 'assets/' + STAGE_DIR + 'fallback/stages.json';
		if (Assets.exists(basePath))
			sources.push(Assets.getText(basePath));

		for (t in ModManager.readAll(STAGE_DIR + 'fallback/stages.json'))
			sources.push(t);

		for (txt in sources)
		{
			try
			{
				var data:Dynamic = Json.parse(txt);
				if (data.defaultStage != null)
					fallback = data.defaultStage;

				if (data.songs != null && Reflect.hasField(data.songs, songName))
					found = Reflect.field(data.songs, songName);
			}
			catch (e:Dynamic)
			{
				trace('stages.json konnte nicht gelesen werden: ' + e);
			}
		}

		return found != null ? found : fallback;
	}

	function loadScript(name:String):Void
	{
		var path:String = STAGE_DIR + name + '.hx';
		var code:Null<String> = readText(path);

		if (code == null)
		{
			trace('Stage-Script nicht gefunden: ' + path);
			if (name != 'stage')
			{
				curStage = 'stage';
				loadScript('stage');
			}
			return;
		}

		var parser = new Parser();
		parser.allowTypes = true;
		parser.allowJSON = true;
		parser.allowMetadata = true;

		interp = new Interp();
		exposeToScript();

		try
		{
			interp.execute(parser.parseString(code, path));
		}
		catch (e:Dynamic)
		{
			trace('Stage-Script Fehler in ' + path + ': ' + e);
		}
	}

	function exposeToScript():Void
	{
		var v = interp.variables;

		for (n in ['gf', 'dad', 'boyfriend'])
		{
			var p = new FlxSprite();
			p.visible = false;
			p.active = false;
			placeholders.set(n, p);
			v.set(n, p);
		}

		v.set('stage', this);
		v.set('state', state);
		v.set('songName', songName);
		v.set('camGame', camGame);
		v.set('camHUD', camHUD);
		v.set('foregroundSprites', foregroundSprites);
		v.set('daPixelZoom', PlayState.daPixelZoom);
		v.set('VIDEOS_ALLOWED', #if (VIDEOS_ALLOWED && !html5) true #else false #end);

		v.set('add', function(o:FlxBasic):FlxBasic
		{
			state.add(o);
			return o;
		});
		v.set('remove', function(o:FlxBasic):FlxBasic
		{
			state.remove(o, true);
			return o;
		});

		v.set('insertBefore', function(reference:FlxBasic, object:FlxBasic):FlxBasic
		{
			var index = state.members.indexOf(reference);

			if (index == -1)
				state.add(object);
			else
				state.insert(index, object);

			return object;
		});

		v.set('insertAfter', function(reference:FlxBasic, object:FlxBasic):FlxBasic
		{
			var index = state.members.indexOf(reference);

			if (index == -1)
				state.add(object);
			else
				state.insert(index + 1, object);

			return object;
		});
		v.set('setCamPos', function(x:Float, y:Float, snap:Bool = false)
		{
			var ps = PlayState.instance;
			ps.isForcedCam = true;
			ps.camFollow.setPosition(x, y);
			if (snap)
				FlxG.camera.focusOn(ps.camFollow.getPosition());
		});
		v.set('releaseCam', function()
		{
			PlayState.instance.isForcedCam = false;
		});
		v.set('Std', Std);
		v.set('Math', Math);
		v.set('fpsLerp', CoolUtil.fpsLerp);
		v.set('Reflect', Reflect);
		v.set('Paths', Paths);
		v.set('FlxG', FlxG);
		v.set('FlxSprite', FlxSprite);
		v.set('FlxAnimate', FlxAnimate);
		v.set('FlxAnimateFrames', FlxAnimateFrames);
		v.set('FlxTypedGroup', FlxTypedGroup);
		v.set('FlxSound', FlxSound);
		v.set('FlxTrail', FlxTrail);
		v.set('FlxTiledSprite', FlxTiledSprite);
		v.set('FlxBackdrop', FlxBackdrop);
		v.set('FlxTween', FlxTween);
		v.set('FlxTimer', FlxTimer);
		v.set('PlayState', PlayState);
		v.set('FlxPoint', {get: FlxPoint.get});
		v.set('FlxGradient', FlxGradient);
		v.set('BGSprite', BGSprite);
		v.set('Character', Character);
		v.set('Boyfriend', Boyfriend);
		v.set('BackgroundDancer', BackgroundDancer);
		v.set('BackgroundGirls', BackgroundGirls);
		v.set('TankmenBG', TankmenBG);
		v.set('ShaderFilter', ShaderFilter);
		v.set('AdjustColorShader', AdjustColorShader);
		v.set('BuildingShaders', BuildingShaders);
		v.set('RainShader', RainShader);
		v.set('MissMeShader', MissMeShader);
		v.set('Vinegar', Vinegar);
		v.set('GausianBlur', GausianBlur);
		v.set('WarpShader', WarpShader);
		#if (VIDEOS_ALLOWED && !html5)
		v.set('VideoSprite', VideoSprite);
		#end

		v.set('BlendMode', {
			ADD: BlendMode.ADD,
			MULTIPLY: BlendMode.MULTIPLY,
			SCREEN: BlendMode.SCREEN,
			NORMAL: BlendMode.NORMAL
		});
		v.set('FlxAxes', {X: FlxAxes.X, Y: FlxAxes.Y, XY: FlxAxes.XY});
		v.set('FlxColor', {WHITE: 0xFFFFFFFF, BLACK: 0xFF000000});
		v.set('FlxEase', {
			cubeIn: FlxEase.cubeIn,
			cubeOut: FlxEase.cubeOut,
			cubeInOut: FlxEase.cubeInOut,
			quadIn: FlxEase.quadIn,
			quadOut: FlxEase.quadOut,
			quadInOut: FlxEase.quadInOut,
			sineIn: FlxEase.sineIn,
			sineOut: FlxEase.sineOut,
			sineInOut: FlxEase.sineInOut,
			linear: FlxEase.linear
		});
	}

	public function callScript(name:String, ?args:Array<Dynamic>):Dynamic
	{
		if (interp == null)
			return null;

		var fn:Dynamic = interp.variables.get(name);
		if (fn == null || !Reflect.isFunction(fn))
			return null;

		interp.variables.set('songPosition', Conductor.songPosition);
		interp.variables.set('crochet', Conductor.crochet);
		interp.variables.set('stepCrochet', Conductor.stepCrochet);

		try
		{
			return Reflect.callMethod(null, fn, args == null ? [] : args);
		}
		catch (e:Dynamic)
		{
			var msg:String = curStage + '.hx -> ' + name + '(): ' + e;
			if (!reportedErrors.exists(msg))
			{
				reportedErrors.set(msg, true);
				trace('Stage-Script Fehler: ' + msg);
			}
			return null;
		}
	}

	public function setupPicoSpeakerTankmen():Void
	{
		if (tankmanRun == null)
			return;

		var tempTankman:TankmenBG = new TankmenBG(20, 500, true);
		tempTankman.strumTime = 10;
		tempTankman.resetShit(20, 600, true);
		tankmanRun.add(tempTankman);

		for (i in 0...TankmenBG.animationNotes.length)
		{
			if (FlxG.random.bool(16))
			{
				var tankman:TankmenBG = tankmanRun.recycle(TankmenBG);
				tankman.strumTime = TankmenBG.animationNotes[i][0];
				tankman.resetShit(500, 200 + FlxG.random.int(50, 100), TankmenBG.animationNotes[i][1] < 2);
				tankmanRun.add(tankman);
			}
		}
	}

	public function positionCharacters(dad:Character, gf:Character, boyfriend:Boyfriend, gfName:String):Void
	{
		this.dad = dad;
		this.gf = gf;
		this.boyfriend = boyfriend;

		if (interp != null)
		{
			interp.variables.set('dad', dad);
			interp.variables.set('gf', gf);
			interp.variables.set('boyfriend', boyfriend);
		}

		callScript('positionCharacters', [dad, gf, boyfriend, gfName]);
	}

	public function placeCharacter(c:Character, name:String):Bool
	{
		var p = placeholders.get(name);
		if (c == null || p == null)
			return false;

		var idx:Int = state.members.indexOf(p);
		if (idx == -1)
			return false;

		state.remove(p, true);
		state.insert(idx, c);

		return true;
	}

	public function addNew(character:FlxBasic):Void
	{
		state.add(character);
	}

	public function addNewAfter(sprite:FlxBasic, character:FlxBasic):Void
	{
		if (sprite == null || character == null)
			return;

		state.remove(character, false);

		var index:Int = state.members.indexOf(sprite);

		if (index == -1)
			state.add(character);
		else
			state.insert(index + 1, character);
	}

	public function finishSetup(gf:Character, dad:Character, boyfriend:Boyfriend):Void
	{
		callScript('finishSetup', [gf, dad, boyfriend]);
	}

	public function update(elapsed:Float, inCutscene:Bool = false):Void
	{
		callScript('update', [elapsed, inCutscene]);
	}

	public function onSongStart(song:String):Void
	{
		callScript('onSongStart', [song]);
	}

	public function postUpdate(elapsed:Float):Void
	{
		callScript('postUpdate', [elapsed]);
	}

	public function stepHit(curStep:Int):Void
	{
		callScript('stepHit', [curStep]);
	}

	public function noteHit(note:Note, isPlayer:Bool):Void
	{
		callScript('onNoteHit', [note, isPlayer]);
	}

	public function beatHit(curBeat:Int):Void
	{
		foregroundSprites.forEach(function(spr:BGSprite)
		{
			spr.dance();
		});

		callScript('beatHit', [curBeat]);
	}

	public function moveTank(inCutscene:Bool = false):Void
	{
		callScript('moveTank', [inCutscene]);
	}

	public function pauseTrainSound():Void
	{
		if (trainSound != null && trainMoving)
			trainSound.pause();
	}

	public function resumeTrainSound():Void
	{
		if (trainSound != null && trainMoving)
			trainSound.resume();
	}
}
