package;

import flixel.animation.FlxAnimation;
import Section.SwagSection;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import animate.FlxAnimate;
import animate.FlxAnimateFrames;
import flixel.util.FlxSort;
import haxe.io.Path;
import hscript.Parser;
import hscript.Interp;
import openfl.utils.Assets;

using StringTools;

@:keep
class Character extends FlxAnimate
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';

	public var idleSuffix:String = '';

	public var holdTimer:Float = 0;
	public var holdTime:Float = 6.1;

	public var animationNotes:Array<Dynamic> = [];

	public var isAdobeCharacter:Bool = false;

	public var healthIcon:String = null;

	var pendingLoop:String = null;

	public var specialAnim:Bool = false;

	public var danceSides:Bool = false;

	public var noDance:Bool = false;

	public var noDanceOverAnim:String = null;

	public static inline var HOLD_SUFFIX:String = '-hold';
	public static inline var END_SUFFIX:String = '-end';

	var scriptInterp:Interp;
	var onUpdateFunc:Dynamic = null;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		antialiasing = true;

		loadCharacterScript(curCharacter);

		if (healthIcon == null)
			healthIcon = curCharacter;

		dance();

		if (!isAdobeCharacter)
			animation.finish();

		if (isPlayer)
		{
			if (curCharacter != 'bf')
				flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf') && !isAdobeCharacter)
			{
				for (suffix in ['', 'miss', HOLD_SUFFIX, 'miss' + HOLD_SUFFIX, END_SUFFIX])
				{
					var r = animation.getByName('singRIGHT' + suffix);
					var l = animation.getByName('singLEFT' + suffix);
					if (r != null && l != null)
					{
						var tmp = r.frames;
						r.frames = l.frames;
						l.frames = tmp;
					}
				}
			}
		}
	}

	public static inline var SCRIPT_DIR:String = 'data/characters/';

	public static function getCharacterList():Array<String>
	{
		var result:Array<String> = [];

		for (path in Assets.list())
		{
			if (path.contains(SCRIPT_DIR) && path.endsWith(".hx"))
			{
				var name:String = Path.withoutExtension(Path.withoutDirectory(path));

				if (name != "" && result.indexOf(name) == -1)
					result.push(name);
			}
		}

		result.sort(function(a, b) return (a < b) ? -1 : (a > b) ? 1 : 0);
		return result;
	}

	function loadCharacterScript(name:String, ?isFallback:Bool = false):Void
	{
		var path:String = Paths.file(SCRIPT_DIR + name + '.hx');
		var code:String = Assets.exists(path) ? Assets.getText(path) : null;

		if (code == null)
		{
			trace('Character script not found: ' + path);
			if (!isFallback)
			{
				loadCharacterScript('bf', true);
				flipX = !flipX;
			}
			return;
		}

		var parser = new Parser();
		var interp = new Interp();

		interp.variables.set('char', this);
		interp.variables.set('Paths', Paths);
		interp.variables.set('FlxG', FlxG);
		interp.variables.set('Conductor', Conductor);
		interp.variables.set('PlayState', PlayState);
		interp.variables.set('FlxAnimate', FlxAnimate);
		interp.variables.set('FlxAnimateFrames', FlxAnimateFrames);
		interp.variables.set('Std', Std);
		interp.variables.set('Math', Math);

		try
		{
			interp.execute(parser.parseString(code));
		}
		catch (e:Dynamic)
		{
			trace('Error in character script ' + path + ': ' + e);
			if (!isFallback)
			{
				loadCharacterScript('bf', true);
				flipX = !flipX;
			}
			return;
		}

		scriptInterp = interp;
		onUpdateFunc = interp.variables.get('onUpdate');
	}

	public function loadMappedAnims()
	{
		var swagshit = Song.loadFromJson('picospeaker', 'stress');

		var notes = swagshit.notes;

		for (section in notes)
		{
			for (idk in section.sectionNotes)
			{
				animationNotes.push(idk);
			}
		}

		TankmenBG.animationNotes = animationNotes;
		animationNotes.sort(sortAnims);
	}

	function sortAnims(val1:Array<Dynamic>, val2:Array<Dynamic>):Int
	{
		return FlxSort.byValues(FlxSort.ASCENDING, val1[0], val2[0]);
	}

	public function quickAnimAdd(name:String, prefix:String)
	{
		animation.addByPrefix(name, prefix, 24, false);
	}

	public function loopAnimAdd(name:String, prefix:String)
	{
		animation.addByPrefix(name, prefix, 24, true);
	}

	public function loopAnimFromEnd(name:String, baseName:String, lastFrames:Int = 2, fps:Float = 12)
	{
		var base = animation.getByName(baseName);
		if (base == null)
			return;

		var f:Array<Int> = base.frames;
		var start:Int = Std.int(Math.max(0, f.length - lastFrames));
		animation.add(name, f.slice(start), fps, true);
	}

	public function loadOffsetFile(offsetCharacter:String)
	{
		var daFile:Array<String> = CoolUtil.coolTextFile(Paths.file("images/characters/" + offsetCharacter + "Offsets.txt"));

		for (i in daFile)
		{
			var splitWords:Array<String> = i.split(" ");
			addOffset(splitWords[0], Std.parseInt(splitWords[1]), Std.parseInt(splitWords[2]));
		}
	}

	override function update(elapsed:Float)
	{
		var cur = animation.curAnim;

		if (specialAnim && cur != null && cur.finished)
		{
			specialAnim = false;
			dance();
			cur = animation.curAnim;
		}

		if (cur != null)
		{
			var name:String = cur.name;

			if (cur.finished && !name.endsWith(HOLD_SUFFIX) && !name.endsWith(END_SUFFIX) && animation.exists(name + HOLD_SUFFIX))
				playAnim(name + HOLD_SUFFIX, true);
			else if (cur.finished && name.endsWith(END_SUFFIX) && name.startsWith('sing'))
				dance();
		}

		if (isSinging())
		{
			holdTimer += elapsed;

			var base:String = animation.curAnim.name;
			if (base.endsWith(HOLD_SUFFIX))
				base = base.substr(0, base.length - HOLD_SUFFIX.length);

			var singTimeSec:Float = holdTime * Conductor.stepCrochet * 0.001;
			if (base.endsWith('miss'))
				singTimeSec *= 2;

			if (holdTimer > singTimeSec)
			{
				holdTimer = 0;
				if (animation.exists(base + END_SUFFIX))
					playAnim(base + END_SUFFIX, true);
				else
					dance();
			}
		}
		else
			holdTimer = 0;

		if (curCharacter.endsWith('-car'))
		{
			if (!animation.curAnim.name.startsWith('sing') && animation.curAnim.finished)
				playAnim('idleHair');
		}

		if (onUpdateFunc != null)
			onUpdateFunc(elapsed);

		super.update(elapsed);
	}

	public function isSinging():Bool
	{
		var cur = animation.curAnim;
		return cur != null && cur.name.startsWith('sing') && !cur.name.endsWith(END_SUFFIX);
	}

	function withIdleSuffix(base:String):String
	{
		var name = base + idleSuffix;
		return animation.exists(name) ? name : base;
	}

	public var danced:Bool = false;

	/**
	 * FOR GF DANCING SHIT
	 */
	public function dance()
	{
		if (specialAnim)
			return;

		if (!debugMode)
		{
			if (noDance)
				return;

			if (noDanceOverAnim != null && animation.curAnim != null && animation.curAnim.name.endsWith(noDanceOverAnim))
				return;

			if (danceSides)
			{
				if (animation.curAnim != null && !animation.curAnim.name.startsWith('hair'))
				{
					danced = !danced;

					if (danced)
						playAnim(withIdleSuffix('danceRight'));
					else
						playAnim(withIdleSuffix('danceLeft'));
				}
			}
			else
				playAnim(withIdleSuffix('idle'));
		}
	}

	public function playSpecialAnim(AnimName:String, Force:Bool = true):Void
	{
		specialAnim = false;
		playAnim(AnimName, Force);
		specialAnim = true;
		holdTimer = 0;
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		if (specialAnim)
		{
			if (AnimName.startsWith('idle') || AnimName.startsWith('danceLeft') || AnimName.startsWith('danceRight'))
				return;

			if (AnimName.startsWith('sing'))
				specialAnim = false;
		}

		animation.play(AnimName, Force, Reversed, Frame);

		var offsetName = AnimName;
		if (!animOffsets.exists(offsetName))
		{
			for (s in [HOLD_SUFFIX, END_SUFFIX])
			{
				if (AnimName.endsWith(s))
				{
					offsetName = AnimName.substr(0, AnimName.length - s.length);
					break;
				}
			}
		}

		var daOffset = animOffsets.get(offsetName);
		if (daOffset != null)
			offset.set(daOffset[0], daOffset[1]);
		else
			offset.set(0, 0);

		if (curCharacter == 'gf')
		{
			if (AnimName == 'singLEFT')
			{
				danced = true;
			}
			else if (AnimName == 'singRIGHT')
			{
				danced = false;
			}

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
			{
				danced = !danced;
			}
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
