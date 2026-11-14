package;

import Song.SwagSong;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.sound.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.tweens.misc.NumTween;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import flixel.util.FlxSort;
import flixel.util.FlxStringUtil;
import flixel.util.FlxTimer;
import ui.PreferencesMenu;
import ResultsState.ResultsStats;

using StringTools;

class PlayState extends MusicBeatState
{
	public static var curStage:String = '';
	public static var SONG:SwagSong;
	public static var isStoryMode:Bool = false;
	public static var storyWeek:Int = 0;
	public static var storyPlaylist:Array<String> = [];
	public static var difficulty:String = 'normal';
	public static var deathCounter:Int = 0;
	public static var practiceMode:Bool = false;
	public static var instance:PlayState;

	var scripts:ScriptHandler = new ScriptHandler();

	private var vocals:FlxSound;
	private var playerVocals:FlxSound;
	private var vocalsFinished:Bool = false;

	private var dad:Character;
	private var gf:Character;
	private var boyfriend:Boyfriend;

	private var notes:FlxTypedGroup<Note>;
	private var sustainTrails:FlxTypedGroup<SustainTrail>;
	private var unspawnNotes:Array<Note> = [];

	public var cpuControlled:Bool = false;

	private var strumLine:FlxSprite;

	public var camFollow:FlxObject;

	private static var prevCamFollow:FlxObject;

	private var strums:Strums;
	private var input:NoteInput;

	private var camZooming:Bool = false;

	var camZoomInterval:Int = 4;
	var camZoomAmount:Float = 0.015;
	var camHUDZoomAmount:Float = 0.03;

	private var curSong:String = "";

	var stage:Stage;

	private var gfSpeed:Int = 1;

	public var health:Float = 1;

	private var combo:Int = 0;

	var sickCount:Int = 0;
	var goodCount:Int = 0;
	var badCount:Int = 0;
	var shitCount:Int = 0;
	var maxCombo:Int = 0;

	static var campaignStats:ResultsStats = null;

	public static function resetCampaignStats():Void
	{
		campaignStats = null;
	}

	private var healthBarBG:FlxSprite;
	private var healthBar:FlxBar;
	var lerpHealth:Float = 50;
	var startLerpHealth:Bool = false;

	private var generatedMusic:Bool = false;
	private var startingSong:Bool = false;

	private var iconP1:HealthIcon;
	private var iconP2:HealthIcon;
	private var camHUD:FlxCamera;
	private var camGame:FlxCamera;

	public var skipCountdown:Bool = false;

	var dialogue:Array<String> = ['blah blah blah', 'coolswag'];

	public static var seenCutscene:Bool = false;

	var comboGroup:ComboGroup;

	var restartTimer:FlxTimer = new FlxTimer();
	var vwooshNotes:FlxTypedGroup<Note>;
	var vwooshTrails:FlxTypedGroup<SustainTrail>;
	var strumsGenerated:Bool = false;

	static inline var VWOOSH_TIME:Float = 0.5;

	var gfCutsceneLayer:FlxGroup;
	var bfTankCutsceneLayer:FlxGroup;

	var songScore:Int = 0;
	var scoreTxt:FlxText;

	var lastScore:Int = -999999;
	var lastMisses:Int = -1;
	var lastNotesPlayed:Int = -1;
	var lastRemainingSec:Int = -1;

	public static var startPosition:Float = 0;

	var startOffset:Float = 0;

	var songMisses:Int = 0;

	var totalNotesHit:Float = 0;
	var totalNotesPlayed:Int = 0;
	var accuracy:Float = 0;

	var grpNoteSplashes:FlxTypedGroup<NoteSplash>;

	public static var campaignScore:Int = 0;

	var defaultCamZoom:Float = 1.05;
	var cameraZoomTarget:{zoom:Float} = {zoom: 1.05};
	var cameraBopZoom:Float = 0;

	public static var daPixelZoom:Float = 6;

	var inCutscene:Bool = false;

	var camPos:FlxPoint;

	var downscrollPref:Bool = false;
	var middlescrollPref:Bool = false;
	var camMovementPref:Bool = false;
	var camZoomPref:Bool = true;
	var testModchartPref:Bool = false;

	public var isPixelStage:Bool = false;

	var splitVocals:Bool = false;
	var noteScrollSpeed:Float = 0.45;
	var unspawnIndex:Int = 0;
	var tmpMid:FlxPoint = new FlxPoint();
	var scriptArgs:Array<Dynamic> = [0.0];

	var holdCovers:HoldCovers;

	var showRating:Bool = true;
	var showCombo:Bool = true;
	var hideOpponentStrums:Bool = false;
	var hideOpponentNotes:Bool = false;

	override public function create()
	{
		FlxG.sound.cache(Paths.sound('scrollMenu'));
		FlxG.sound.cache(Paths.music('breakfast'));
		FlxG.sound.cache(Paths.sound('hitSound')); // hab ich von codename engine gestohlen lol. muss ich noch ersetzen
		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();

		FlxG.sound.cache(Paths.inst(PlayState.SONG.song));
		for (v in Paths.voicesFiles(PlayState.SONG.song))
			FlxG.sound.cache(v);

		startOffset = startPosition;
		startPosition = 0;

		cpuControlled = PreferencesMenu.getPref('botplay'); // ich hab den scheiss lowkey irgendwo reingequetscht
		downscrollPref = PreferencesMenu.getPref('downscroll');
		middlescrollPref = PreferencesMenu.getPref('middlescroll');
		camMovementPref = PreferencesMenu.getPref('camMovement');
		camZoomPref = PreferencesMenu.getPref('camera-zoom');
		testModchartPref = PreferencesMenu.getPref('Test Modchart');

		camGame = new SwagCamera();
		camHUD = new FlxCamera();
		camHUD.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camHUD, false);

		persistentUpdate = true;
		persistentDraw = true;

		if (SONG == null)
			SONG = Song.loadFromJson('tutorial');

		Conductor.mapBPMChanges(SONG);
		Conductor.changeBPM(SONG.bpm);

		Song.migrateCameraEvents(SONG);
		camEvents = SONG.cameraEvents.copy();
		camEvents.sort(function(a, b) return Std.int(a.time - b.time));
		camEventIdx = -1;

		switch (SONG.song.toLowerCase())
		{
			case 'tutorial':
				dialogue = ["Hey you're pretty cute.", 'Use the arrow keys to keep up \nwith me singing.'];
			case 'bopeebo':
				dialogue = [
					'HEY!',
					"You think you can just sing\nwith my daughter like that?",
					"If you want to date her...",
					"You're going to have to go \nthrough ME first!"
				];
			case 'fresh':
				dialogue = ["Not too shabby boy.", ""];
			case 'dadbattle':
				dialogue = [
					"gah you think you're hot stuff?",
					"If you can beat me here...",
					"Only then I will even CONSIDER letting you\ndate my daughter!"
				];
			case 'senpai':
				dialogue = CoolUtil.coolTextFile(Paths.txt('senpai/senpaiDialogue'));
			case 'roses':
				dialogue = CoolUtil.coolTextFile(Paths.txt('roses/rosesDialogue'));
			case 'thorns':
				dialogue = CoolUtil.coolTextFile(Paths.txt('thorns/thornsDialogue')); // ss
		}

		stage = new Stage(this);
		stage.camGame = camGame;
		stage.camHUD = camHUD;
		stage.build(SONG.song);

		curStage = stage.curStage;
		NoteSkin.select(SONG.song, curStage);
		isPixelStage = curStage.startsWith('school');
		defaultCamZoom = stage.defaultCamZoom;
		cameraZoomTarget.zoom = defaultCamZoom;

		var gfVersion:String = stage.gfVersion;

		if (SONG.song.toLowerCase() == 'stress')
			gfVersion = 'pico-speaker';

		gf = new Character(400, 130, gfVersion);
		gf.scrollFactor.set(0.95, 0.95);

		switch (gfVersion)
		{
			case 'pico-speaker':
				gf.x -= 50;
				gf.y -= 200;
				stage.setupPicoSpeakerTankmen();
		}

		dad = new Character(100, 100, SONG.player2);

		camPos = new FlxPoint(dad.getGraphicMidpoint().x, dad.getGraphicMidpoint().y);

		switch (SONG.player2)
		{
			case 'gf':
				dad.setPosition(gf.x, gf.y);
				gf.visible = false;
				if (isStoryMode)
				{
					camPos.x += 600;
					tweenCamIn();
				}
			case "spooky":
				dad.y += 200;
			case "monster":
				dad.y += 100;
			case 'monster-christmas':
				dad.y += 130;
			case 'dad':
				camPos.x += 400;
			case 'pico':
				camPos.x += 600;
				dad.y += 300;
			case 'parents-christmas':
				dad.x -= 500;
			case 'senpai' | 'senpai-angry':
				dad.x += 150;
				dad.y += 360;
				camPos.set(dad.getGraphicMidpoint().x + 300, dad.getGraphicMidpoint().y);
			case 'spirit':
				dad.x -= 150;
				dad.y += 100;
				camPos.set(dad.getGraphicMidpoint().x + 300, dad.getGraphicMidpoint().y);
			case 'tankman':
				dad.y += 180;
		}

		boyfriend = new Boyfriend(770, 450, SONG.player1);

		stage.positionCharacters(dad, gf, boyfriend, gfVersion);
		cameraOffsetDadX = stage.cameraOffsetDadX;
		cameraOffsetDadY = stage.cameraOffsetDadY;
		cameraOffsetbfX = stage.cameraOffsetbfX;
		cameraOffsetbfY = stage.cameraOffsetbfY;

		placeChar(gf, 'gf');

		gfCutsceneLayer = new FlxGroup();
		add(gfCutsceneLayer);

		bfTankCutsceneLayer = new FlxGroup();
		add(bfTankCutsceneLayer);

		if (stage.limo != null)
			add(stage.limo);

		placeChar(dad, 'dad');
		placeChar(boyfriend, 'boyfriend');

		stage.finishSetup(gf, dad, boyfriend);

		add(stage.foregroundSprites);

		var doof:DialogueBox = new DialogueBox(false, dialogue);
		doof.scrollFactor.set();
		doof.finishThing = startCountdown;

		Conductor.songPosition = -5000;

		strumLine = new FlxSprite(0, 50).makeGraphic(FlxG.width, 10);

		if (downscrollPref)
			strumLine.y = FlxG.height - 150;

		strumLine.scrollFactor.set();

		strums = new Strums();
		add(strums);

		if (startOffset > 0)
			strums.skipIntroTween = true;

		input = new NoteInput(controls, goodNoteHit, noteMiss);

		grpNoteSplashes = new FlxTypedGroup<NoteSplash>();
		var splash:NoteSplash = new NoteSplash(100, 100, 0);
		grpNoteSplashes.add(splash);
		splash.alpha = 0.0;

		generateSong();

		holdCovers = new HoldCovers(function(mustPress:Bool, lane:Int) return strums.getStrum(lane, mustPress), camHUD);
		add(holdCovers);
		add(grpNoteSplashes);

		camFollow = new FlxObject(0, 0, 1, 1);

		camFollow.setPosition(camPos.x, camPos.y);

		if (prevCamFollow != null)
		{
			camFollow = prevCamFollow;
			prevCamFollow = null;
		}

		add(camFollow);

		FlxG.camera.follow(camFollow, LOCKON, 0.04);
		FlxG.camera.zoom = defaultCamZoom;
		FlxG.camera.focusOn(camFollow.getPosition());

		FlxG.worldBounds.set(0, 0, FlxG.width, FlxG.height);

		FlxG.fixedTimestep = false;

		healthBarBG = new FlxSprite(0, FlxG.height * 0.9).loadGraphic(Paths.image('healthBar'));
		healthBarBG.screenCenter(X);
		healthBarBG.scrollFactor.set();
		add(healthBarBG);

		if (downscrollPref)
			healthBarBG.y = FlxG.height * 0.1;

		healthBar = new FlxBar(healthBarBG.x + 4, healthBarBG.y + 4, RIGHT_TO_LEFT, Std.int(healthBarBG.width - 8), Std.int(healthBarBG.height - 8), this,
			'health', 0, 2);
		healthBar.scrollFactor.set();
		healthBar.createFilledBar(0xFFFF0000, 0xFF66FF33);
		healthBar.numDivisions = 1000;
		add(healthBar);

		scoreTxt = new FlxText(0, healthBarBG.y + 36, FlxG.width, "", 16);
		scoreTxt.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		scoreTxt.borderSize = 1.25;
		scoreTxt.scrollFactor.set();
		scoreTxt.antialiasing = false;

		iconP1 = new HealthIcon(boyfriend.healthIcon, true);
		iconP1.y = healthBar.y - (iconP1.height / 2);
		add(iconP1);

		iconP2 = new HealthIcon(dad.healthIcon, false);
		iconP2.y = healthBar.y - (iconP2.height / 2);
		add(iconP2);

		add(scoreTxt);

		comboGroup = new ComboGroup(boyfriend.x - 110, boyfriend.y + 100);
		if (boyfriend != null)
			insert(members.indexOf(boyfriend) - 1, comboGroup);
		if (isPixelStage)
		{
			comboGroup.x -= 150;
			comboGroup.y -= 100;
		}

		for (i in [
			grpNoteSplashes,
			strums,
			notes,
			sustainTrails,
			healthBar,
			healthBarBG,
			iconP1,
			iconP2,
			scoreTxt,
			doof,
			vwooshNotes,
			vwooshTrails
		])
			i.cameras = [camHUD];
		loadSongEvents();
		startingSong = true;

		if (isStoryMode && !seenCutscene && startOffset <= 0)
		{
			seenCutscene = true;

			switch (curSong.toLowerCase())
			{
				case "winter-horrorland":
					var blackScreen:FlxSprite = new FlxSprite(0, 0).makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.BLACK);
					add(blackScreen);
					blackScreen.scrollFactor.set();
					camHUD.visible = false;

					new FlxTimer().start(0.1, function(tmr:FlxTimer)
					{
						remove(blackScreen);
						FlxG.sound.play(Paths.sound('Lights_Turn_On'));
						camFollow.y = -2050;
						camFollow.x += 200;
						FlxG.camera.focusOn(camFollow.getPosition());
						FlxG.camera.zoom = 1.5;

						new FlxTimer().start(0.8, function(tmr:FlxTimer)
						{
							camHUD.visible = true;
							remove(blackScreen);
							FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom}, 2.5, {
								ease: FlxEase.quadInOut,
								onComplete: function(twn:FlxTween)
								{
									startCountdown();
								}
							});
						});
					});
				case 'senpai' | 'roses' | 'thorns':
					schoolIntro(doof);
				case 'ugh':
					videoIntro('music/ughCutscene.mp4', true);
				case 'stress':
					videoIntro('music/stressCutscene.mp4');
				case 'guns':
					videoIntro('music/gunsCutscene.mp4');

				default:
					startCountdown();
			}
		}
		else
			startCountdown();

		super.create();

		scripts.call('create');
		instance = this;

		scripts.call('postCreate');
	}

	function placeChar(c:Character, name:String):Void
	{
		if (stage.placeCharacter(c, name))
			return;
		add(c);
	}

	function loadSongEvents()
	{
		scripts.set('FlxG', FlxG);
		scripts.set('FlxTween', FlxTween);
		scripts.set('FlxEase', FlxEase);
		scripts.set('FlxMath', FlxMath);
		scripts.set('FlxSprite', FlxSprite);
		scripts.set('boyfriend', boyfriend);
		scripts.set('dad', dad);
		scripts.set('gf', gf);
		scripts.set('iconP1', iconP1);
		scripts.set('iconP2', iconP2);
		scripts.set('healthBar', healthBar);
		scripts.set('healthBarBG', healthBarBG);
		scripts.set('scoreTxt', scoreTxt);
		scripts.set('camGame', camGame);
		scripts.set('camHUD', camHUD);
		scripts.set('comboGroup', comboGroup);
		scripts.set('defaultCamZoom', defaultCamZoom);
		scripts.set('setScrollSpeed', function(value:Float)
		{
			noteScrollSpeed = value * 0.45;
		});
		scripts.set('setDefaultCamZoom', function(value:Float)
		{
			defaultCamZoom = value;
			cameraZoomTarget.zoom = value;
		});
		scripts.set('cameraZoomTarget', cameraZoomTarget);
		scripts.set('tweenCameraToCharacter', tweenCameraToCharacter);
		scripts.set('moveCamera', moveCamera);
		scripts.set('setForcedCam', function(value:Bool)
		{
			isForcedCam = value;
		});
		scripts.set('setCameraTweens', function(value:Bool)
		{
			camTweensEnabled = value;
		});
		scripts.set('Conductor', Conductor);
		scripts.set('strumLineNotes', strums);
		scripts.set('strumBaseX', strums.baseX);
		scripts.set('strumBaseY', strums.baseY);
		scripts.set('strumBaseAngle', strums.baseAngle);
		scripts.set('strumBaseAlpha', strums.baseAlpha);
		scripts.set('camZoomInterval', setCamZoomInterval);
		scripts.set('setSkipCountdown', function(value:Bool, value2:Bool)
		{
			skipCountdown = value;

			FlxTransitionableState.skipNextTransIn = value2;
		});

		scripts.set('setShowRating', function(value:Bool)
		{
			showRating = value;
		});
		scripts.set('setShowCombo', function(value:Bool)
		{
			showCombo = value;
		});

		scripts.set('setSkipStrumIntro', function(value:Bool)
		{
			strums.skipIntroTween = value;
		});

		scripts.set('setOpponentStrumsVisible', function(value:Bool)
		{
			hideOpponentStrums = !value;

			if (value)
			{
				for (i in 0...4)
				{
					var s = strums.getStrum(i, false);
					if (s != null)
						s.visible = true;
				}
			}
		});
		scripts.set('setOpponentNotesVisible', function(value:Bool)
		{
			hideOpponentNotes = !value;
		});

		scripts.set('setCameraOffset', function(target:String, x:Float, y:Float)
		{
			switch (target.toLowerCase())
			{
				case 'dad':
					cameraOffsetDadX = x;
					cameraOffsetDadY = y;
				case 'boyfriend' | 'bf':
					cameraOffsetbfX = x;
					cameraOffsetbfY = y;
			}
		});
		scripts.set('getCameraOffset', function(target:String):Array<Float>
		{
			switch (target.toLowerCase())
			{
				case 'dad':
					return [cameraOffsetDadX, cameraOffsetDadY];
				case 'boyfriend' | 'bf':
					return [cameraOffsetbfX, cameraOffsetbfY];
				default:
					return [0, 0];
			}
		});

		scripts.set('PreferencesMenu', PreferencesMenu);
		scripts.set('Main', Main);

		for (d in ModManager.dirs('data/globalScripts'))
			scripts.load(d);
		for (d in ModManager.dirs('songs/' + SONG.song.toLowerCase()))
			scripts.load(d);
	}

	function formatTime(milliseconds:Float):String
	{
		var totalSeconds:Int = Math.floor(milliseconds / 1000);

		var minutes:Int = Math.floor(totalSeconds / 60);
		var seconds:Int = totalSeconds % 60;

		return minutes + ":" + StringTools.lpad(Std.string(seconds), "0", 2);
	}

	public function resumeTrainSound():Void
	{
		if (stage != null)
			stage.resumeTrainSound();
	}

	function videoIntro(path:String, zoomIn:Bool = false)
	{
		inCutscene = true;

		var blackShit:FlxSprite = new FlxSprite(-200, -200).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
		blackShit.scrollFactor.set();
		add(blackShit);

		var vid:FlxVideo = new FlxVideo(path);
		vid.finishCallback = function()
		{
			remove(blackShit);
			FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom}, (Conductor.crochet / 1000) * 5, {ease: FlxEase.quadInOut});
			startCountdown();
			cameraMovement();
		};

		if (zoomIn)
		{
			FlxG.camera.zoom = defaultCamZoom * 1.2;

			camFollow.x += 100;
			camFollow.y += 100;
		}
	}

	function schoolIntro(?dialogueBox:DialogueBox):Void
	{
		var black:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
		black.scrollFactor.set();
		add(black);

		var red:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, 0xFFff1b31);
		red.scrollFactor.set();

		var senpaiEvil:FlxSprite = new FlxSprite();
		senpaiEvil.frames = Paths.getSparrowAtlas('weeb/senpaiCrazy');
		senpaiEvil.animation.addByPrefix('idle', 'Senpai Pre Explosion', 24, false);
		senpaiEvil.setGraphicSize(Std.int(senpaiEvil.width * daPixelZoom));
		senpaiEvil.scrollFactor.set();
		senpaiEvil.updateHitbox();
		senpaiEvil.screenCenter();
		senpaiEvil.x += senpaiEvil.width / 5;

		camFollow.setPosition(camPos.x, camPos.y);

		if (SONG.song.toLowerCase() == 'roses' || SONG.song.toLowerCase() == 'thorns')
		{
			remove(black);

			if (SONG.song.toLowerCase() == 'thorns')
			{
				add(red);
				camHUD.visible = false;
			}
			else
				FlxG.sound.play(Paths.sound('ANGRY'));
		}

		new FlxTimer().start(0.3, function(tmr:FlxTimer)
		{
			black.alpha -= 0.15;

			if (black.alpha > 0)
				tmr.reset(0.3);
			else
			{
				if (dialogueBox != null)
				{
					inCutscene = true;

					if (SONG.song.toLowerCase() == 'thorns')
					{
						add(senpaiEvil);
						senpaiEvil.alpha = 0;
						new FlxTimer().start(0.3, function(swagTimer:FlxTimer)
						{
							senpaiEvil.alpha += 0.15;
							if (senpaiEvil.alpha < 1)
								swagTimer.reset();
							else
							{
								senpaiEvil.animation.play('idle');
								FlxG.sound.play(Paths.sound('Senpai_Dies'), 1, false, null, true, function()
								{
									remove(senpaiEvil);
									remove(red);
									FlxG.camera.fade(FlxColor.WHITE, 0.01, true, function()
									{
										add(dialogueBox);
										camHUD.visible = true;
									}, true);
								});
								new FlxTimer().start(3.2, function(deadTime:FlxTimer)
								{
									FlxG.camera.fade(FlxColor.WHITE, 1.6, false);
								});
							}
						});
					}
					else
						add(dialogueBox);
				}
				else
					startCountdown();

				remove(black);
			}
		});
	}

	var startTimer:FlxTimer = new FlxTimer();

	function danceHeads(beat:Int):Void
	{
		if (beat % gfSpeed == 0)
		{
			var anim = gf.animation.curAnim;

			if ((anim.name != 'cheer' && anim.name != 'sad') || anim.finished)
			{
				gf.dance();
			}
		}

		if (beat % 2 == 0)
		{
			if (!boyfriend.animation.curAnim.name.startsWith("sing"))
				boyfriend.dance();
			if (!dad.animation.curAnim.name.startsWith("sing"))
				dad.dance();
		}
		else if (dad.curCharacter == 'spooky' && !dad.animation.curAnim.name.startsWith("sing"))
			dad.dance();
	}

	function startCountdown():Void
	{
		inCutscene = false;
		camHUD.visible = true;

		if (!strumsGenerated)
		{
			strums.generate(0, strumLine.y);
			strums.generate(1, strumLine.y);
			strumsGenerated = true;
		}

		if (startOffset > 0)
		{
			startedCountdown = true;
			Conductor.songPosition = startOffset;
			return;
		}

		if (skipCountdown)
		{
			startedCountdown = true;
			Conductor.songPosition = 0;
			return;
		}

		startedCountdown = true;
		Conductor.songPosition = 0;
		Conductor.songPosition -= Conductor.crochet * 5;

		var swagCounter:Int = 0;

		startTimer.start(Conductor.crochet / 1000, function(tmr:FlxTimer)
		{
			danceHeads(swagCounter);

			if (generatedMusic)
				notes.sort(sortNotes, FlxSort.DESCENDING);

			var introSprPaths:Array<String> = ["ready", "set", "go"];
			var altSuffix:String = "";

			if (curStage.startsWith("school"))
			{
				altSuffix = '-pixel';
				introSprPaths = ['weeb/pixelUI/ready-pixel', 'weeb/pixelUI/set-pixel', 'weeb/pixelUI/date-pixel'];
			}

			var introSndPaths:Array<String> = [
				"intro3" + altSuffix, "intro2" + altSuffix,
				"intro1" + altSuffix, "introGo" + altSuffix
			];

			if (swagCounter > 0)
				readySetGo(introSprPaths[swagCounter - 1]);
			FlxG.sound.play(Paths.sound(introSndPaths[swagCounter]), 0.6);

			swagCounter += 1;
		}, 4);
	}

	function readySetGo(path:String):Void
	{
		var spr:FlxSprite = new FlxSprite().loadGraphic(Paths.image(path));
		spr.scrollFactor.set();
		if (curStage.startsWith("school"))
		{
			spr.antialiasing = false;
		}
		else
		{
			spr.antialiasing = true;
		}

		if (curStage.startsWith('school'))
			spr.setGraphicSize(Std.int(spr.width * daPixelZoom));

		spr.updateHitbox();
		spr.screenCenter();
		add(spr);
		FlxTween.tween(spr, {y: spr.y -= 50, alpha: 0}, Conductor.crochet / 1000, {
			ease: FlxEase.cubeInOut,
			onComplete: function(twn:FlxTween)
			{
				spr.destroy();
			}
		});
	}

	function startSong():Void
	{
		startingSong = false;

		PreferencesMenu.songOverrides.clear();
		PreferencesMenu.inSongMode = true;

		if (!paused)
			FlxG.sound.playMusic(Paths.inst(SONG.song), 1, false);

		if (startOffset > 0)
			FlxG.sound.music.time = startOffset;

		FlxG.sound.music.onComplete = endSong;

		if (vocals != null)
			vocals.play();

		if (playerVocals != null)
			playerVocals.play();

		startLerpHealth = true;

		resyncVocals();

		stage.onSongStart(SONG.song);
		scripts.call('onSongStart');
	}

	private function generateSong():Void
	{
		var songData = SONG;
		Conductor.changeBPM(songData.bpm);

		curSong = songData.song;

		noteScrollSpeed = 0.45 * FlxMath.roundDecimal(SONG.speed, 2);

		splitVocals = Paths.useSplitVocals(SONG.song, difficulty);

		if (SONG.needsVoices)
		{
			var oppVoices:String = Paths.voices(SONG.song, '-opponent');
			var playerVoices:String = Paths.voices(SONG.song, '-player');
			var plainVoices:String = Paths.voices(SONG.song);

			if (splitVocals)
			{
				vocals = openfl.utils.Assets.exists(oppVoices) ? new FlxSound().loadEmbedded(oppVoices) : new FlxSound();
				playerVocals = openfl.utils.Assets.exists(playerVoices) ? new FlxSound().loadEmbedded(playerVoices) : new FlxSound();
			}
			else
			{
				vocals = openfl.utils.Assets.exists(plainVoices) ? new FlxSound().loadEmbedded(plainVoices) : new FlxSound();
				playerVocals = new FlxSound();
			}
		}
		else
		{
			vocals = new FlxSound();
			playerVocals = new FlxSound();
		}

		vocals.onComplete = function()
		{
			vocalsFinished = true;
		};
		FlxG.sound.list.add(vocals);
		FlxG.sound.list.add(playerVocals);

		sustainTrails = new FlxTypedGroup<SustainTrail>();
		add(sustainTrails);

		notes = new FlxTypedGroup<Note>();
		add(notes);

		vwooshTrails = new FlxTypedGroup<SustainTrail>();
		add(vwooshTrails);

		vwooshNotes = new FlxTypedGroup<Note>();
		add(vwooshNotes);

		buildNotes();

		generatedMusic = true;
	}

	function buildNotes():Void
	{
		unspawnNotes = [];
		unspawnIndex = 0;

		HoldNote.generate(SONG.notes, unspawnNotes, sortByShit);

		if (startOffset > 0)
		{
			while (unspawnIndex < unspawnNotes.length && unspawnNotes[unspawnIndex].strumTime < startOffset)
				unspawnIndex++;
		}
	}

	function vwooshOut(animate:Bool):Void
	{
		var shift:Float = downscrollPref ? -FlxG.height : FlxG.height;

		for (n in notes.members.copy())
		{
			if (n == null)
				continue;

			notes.remove(n, true);

			if (!animate || n.isSustainNote || !n.visible || !n.alive)
			{
				n.kill();
				n.destroy();
				continue;
			}

			n.active = false;
			vwooshNotes.add(n);
			FlxTween.tween(n, {y: n.y + shift}, VWOOSH_TIME, {
				ease: FlxEase.expoIn,
				onComplete: function(_)
				{
					vwooshNotes.remove(n, true);
					n.kill();
					n.destroy();
				}
			});
		}

		for (t in sustainTrails.members.copy())
		{
			if (t == null)
				continue;

			sustainTrails.remove(t, true);

			if (t.holding)
			{
				t.holding = false;
				strums.endHold(t.noteDirection, t.mustPress, false);
			}

			if (!animate || !t.visible || !t.alive)
			{
				t.destroy();
				continue;
			}

			vwooshTrails.add(t);
			FlxTween.tween(t, {y: t.y + shift}, VWOOSH_TIME, {
				ease: FlxEase.expoIn,
				onComplete: function(_)
				{
					vwooshTrails.remove(t, true);
					t.destroy();
				}
			});
		}
	}

	public function restartSong(fromDeath:Bool = false):Void
	{
		startTimer.cancel();
		restartTimer.cancel();
		stopCamTween();

		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();
		vocals.stop();
		playerVocals.stop();
		vocals.volume = 1;
		playerVocals.volume = 1;
		vocalsFinished = false;

		vwooshOut(!fromDeath);
		for (i in unspawnIndex...unspawnNotes.length)
		{
			var n:Note = unspawnNotes[i];
			if (!n.isSustainNote && n.trail != null)
				n.trail.destroy();
			n.destroy();
		}

		for (i in 0...4)
			holdCovers.keyReleased(i);

		health = 1;
		lerpHealth = 50;
		startLerpHealth = false;
		combo = 0;
		maxCombo = 0;
		songScore = 0;
		songMisses = 0;
		sickCount = goodCount = badCount = shitCount = 0;
		totalNotesHit = 0;
		totalNotesPlayed = 0;
		accuracy = 0;
		lastScore = -999999;
		lastMisses = -1;
		lastNotesPlayed = -1;
		lastRemainingSec = -1;

		gfSpeed = 1;
		camZooming = false;
		cameraBopZoom = 0;
		camHUD.zoom = 1;
		defaultCamZoom = stage.defaultCamZoom;
		cameraZoomTarget.zoom = defaultCamZoom;
		setCamZoomInterval();
		camEventIdx = -1;
		camTarget = 0;
		cameraRightSide = false;
		camScrollX = 0;
		camScrollY = 0;
		FlxG.camera.targetOffset.set();
		resetCamClassic();
		camFollow.setPosition(camPos.x, camPos.y);
		FlxG.camera.follow(camFollow, LOCKON, camFollowLerp);
		FlxG.camera.targetOffset.set();
		FlxG.camera.focusOn(camFollow.getPosition());

		if (fromDeath)
			FlxG.camera.fade(FlxColor.BLACK, 1, true, null, true);

		boyfriend.holdTimer = 0;
		dad.holdTimer = 0;
		boyfriend.dance();
		dad.dance();
		gf.dance();

		Conductor.changeBPM(SONG.bpm);
		Conductor.songPosition = startOffset > 0 ? startOffset : -Conductor.crochet * 5;
		Conductor.resetDelta();
		buildNotes();

		startingSong = true;
		startedCountdown = false;

		scripts.call('onRestart');

		restartTimer.start(fromDeath ? 0.3 : VWOOSH_TIME, function(_) startCountdown());
	}

	function sortByShit(Obj1:Note, Obj2:Note):Int
	{
		return sortNotes(FlxSort.ASCENDING, Obj1, Obj2);
	}

	function sortNotes(order:Int = FlxSort.ASCENDING, Obj1:Note, Obj2:Note)
	{
		return FlxSort.byValues(order, Obj1.strumTime, Obj2.strumTime);
	}

	function tweenCamIn():Void
	{
		FlxTween.tween(FlxG.camera, {zoom: 1.3}, (Conductor.stepCrochet * 4 / 1000), {ease: FlxEase.elasticInOut});
	}

	var frozenTweens:Array<FlxTween> = [];

	function freezeTweens():Void
	{
		frozenTweens = [];
		FlxTween.globalManager.forEach(function(t:FlxTween)
		{
			if (t.active)
			{
				t.active = false;
				frozenTweens.push(t);
			}
		});
	}

	function unfreezeTweens():Void
	{
		for (t in frozenTweens)
			t.active = true;
		frozenTweens = [];
	}

	override function openSubState(SubState:FlxSubState)
	{
		if (paused)
		{
			if (FlxG.sound.music != null)
			{
				FlxG.sound.music.pause();
				if (vocals != null)
					vocals.pause();
				if (playerVocals != null)
					playerVocals.pause();
			}

			if (!startTimer.finished)
				startTimer.active = false;
		}

		super.openSubState(SubState);
	}

	override function closeSubState()
	{
		if (paused)
		{
			unfreezeTweens();

			if (FlxG.sound.music != null && !startingSong)
				resyncVocals();

			if (!startTimer.finished)
				startTimer.active = true;
			paused = false;
		}

		setFollowRate(camFollowLerp);

		super.closeSubState();
	}

	function resyncVocals():Void
	{
		if (_exiting)
			return;

		vocals.pause();
		playerVocals.pause();
		FlxG.sound.music.play();
		Conductor.songPosition = FlxG.sound.music.time + Conductor.offset;
		Conductor.resetDelta();

		if (vocalsFinished)
			return;

		vocals.time = Conductor.songPosition;
		vocals.play();

		playerVocals.time = Conductor.songPosition;
		playerVocals.play();
	}

	private var paused:Bool = false;
	var startedCountdown:Bool = false;
	var canPause:Bool = true;

	public var offsetSing = PreferencesMenu.getPref('camMovementStrength');

	public var isForcedCam = false;

	override public function update(elapsed:Float)
	{
		Conductor.update(elapsed);

		if (startingSong)
		{
			if (startedCountdown)
			{
				Conductor.songPosition += FlxG.elapsed * 1000;
				if (Conductor.songPosition >= 0)
					startSong();
			}
		}

		if (FlxG.keys.justPressed.P)
		{
			endSong();
		}

		stage.update(elapsed, inCutscene);

		var currentBeat = ((Conductor.getTimeWithDelta() / 1000) * (Conductor.bpm / 60)) * 0.1;

		if (testModchartPref)
			strums.updateModchart(currentBeat);

		super.update(elapsed);

		scriptArgs[0] = elapsed;
		scripts.call('update', scriptArgs);

		lerpHealth = CoolUtil.fpsLerp(lerpHealth, (health * 50), 0.15);

		if (startLerpHealth)
			healthBar.percent = lerpHealth;

		var iconOffset:Int = 26;

		iconP1.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(lerpHealth, 0, 100, 100, 0) * 0.01) - iconOffset);
		iconP2.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(lerpHealth, 0, 100, 100, 0) * 0.01)) - (iconP2.width - iconOffset);

		var iconLerp = 0.33;
		iconP1.scale.set(CoolUtil.fpsLerp(iconP1.scale.x, 1, iconLerp), CoolUtil.fpsLerp(iconP1.scale.y, 1, iconLerp));
		iconP1.updateHitbox();

		iconP2.scale.set(CoolUtil.fpsLerp(iconP2.scale.x, 1, iconLerp), CoolUtil.fpsLerp(iconP2.scale.y, 1, iconLerp));
		iconP2.updateHitbox();

		if (camMovementPref)
		{
			var anim:String = '';

			if (!cameraRightSide && dad != null)
			{
				anim = dad.animation.curAnim.name;
			}
			else if (cameraRightSide && boyfriend != null)
			{
				anim = boyfriend.animation.curAnim.name;
			}

			if (anim.contains('miss') || anim.startsWith('idle') || anim.startsWith('dance'))
				doScrollStuff(0, 0);
			else if (anim.startsWith('singLEFT'))
				doScrollStuff(-offsetSing, 0);
			else if (anim.startsWith('singDOWN'))
				doScrollStuff(0, offsetSing);
			else if (anim.startsWith('singUP'))
				doScrollStuff(0, -offsetSing);
			else if (anim.startsWith('singRIGHT'))
				doScrollStuff(offsetSing, 0);
		}

		updateScrollOffset();

		strums.updateOpponent();

		if (hideOpponentStrums)
		{
			for (i in 0...4)
			{
				var s = strums.getStrum(i, false);
				if (s != null)
					s.visible = false;
			}
		}

		var remainingSec:Int = Math.floor(Math.max(0, FlxG.sound.music.length - Conductor.songPosition) / 1000);

		if (songScore != lastScore
			|| songMisses != lastMisses
			|| totalNotesPlayed != lastNotesPlayed
			|| remainingSec != lastRemainingSec)
		{
			lastScore = songScore;
			lastMisses = songMisses;
			lastNotesPlayed = totalNotesPlayed;
			lastRemainingSec = remainingSec;

			var displayAccuracy:String = (totalNotesPlayed == 0) ? "0" : Std.string(FlxMath.roundDecimal(accuracy, 2));

			scoreTxt.text = "Score: " + FlxStringUtil.formatMoney(songScore, false, true) + " • Misses: " + songMisses + " • Accuracy: " + displayAccuracy
				+ "%" + " -" + " (" + getRatingFC() + ")" + ' | ' + formatTime(remainingSec * 1000);
		}

		if (controls.PAUSE && startedCountdown && canPause)
		{
			persistentUpdate = false;
			persistentDraw = true;
			paused = true;

			stage.pauseTrainSound();

			if (FlxG.random.bool(0.1))
			{
				FlxG.switchState(new GitarooPause());
			}
			else
			{
				freezeTweens();

				var boyfriendPos = boyfriend.getScreenPosition();
				var pauseSubState = new PauseSubState(boyfriendPos.x, boyfriendPos.y, this);
				setFollowRate(0);
				openSubState(pauseSubState);
				pauseSubState.camera = camHUD;
				boyfriendPos.put();
			}
		}

		#if debug
		if (FlxG.keys.justPressed.SEVEN)
		{
			FlxG.switchState(new ChartingState());
			FlxG.sound.music.stop();
			vocals.stop();
			playerVocals.stop();
		}
		#end

		if (FlxG.keys.justPressed.NINE)
			iconP1.swapOldIcon();

		if (health > 2)
			health = 2;

		if (iconP1.animation.curAnim != null)
			iconP1.animation.curAnim.curFrame = (healthBar.percent < 20) ? 1 : 0;

		if (iconP2.animation.curAnim != null)
			iconP2.animation.curAnim.curFrame = (healthBar.percent > 80) ? 1 : 0;

		#if debug
		if (FlxG.keys.justPressed.EIGHT)
		{
			/* 	 8 for opponent char
				SHIFT+8 for player char
				CTRL+SHIFT+8 for gf */
			if (FlxG.keys.pressed.SHIFT)
				if (FlxG.keys.pressed.CONTROL)
					FlxG.switchState(new AnimationDebug(gf.curCharacter));
				else
					FlxG.switchState(new AnimationDebug(SONG.player1));
			else
				FlxG.switchState(new AnimationDebug(SONG.player2));
		}
		#end

		if (generatedMusic)
			updateCameraEvents();

		if (camZooming)
		{
			var factor:Float = Math.pow(0.95, elapsed * 60);

			cameraBopZoom = FlxMath.lerp(0, cameraBopZoom, factor);
			camHUD.zoom = FlxMath.lerp(1, camHUD.zoom, factor);
		}

		FlxG.camera.zoom = cameraZoomTarget.zoom + cameraBopZoom;

		#if debug
		FlxG.watch.addQuick("followLerp", FlxG.camera.followLerp);
		FlxG.watch.addQuick("elapsed", FlxG.elapsed);
		FlxG.watch.addQuick("curBeat", curBeat);
		FlxG.watch.addQuick("curStep", curStep);
		FlxG.watch.addQuick("health", health);
		FlxG.watch.addQuick("songPosition", Conductor.songPosition / 1000);
		#end

		if (curSong == 'Fresh')
		{
			switch (curBeat)
			{
				case 16:
					camZooming = true;
					gfSpeed = 2;
				case 48:
					gfSpeed = 1;
				case 80:
					gfSpeed = 2;
				case 112:
					gfSpeed = 1;
			}
		}

		if (curSong == 'Bopeebo')
		{
			switch (curBeat)
			{
				case 128, 129, 130:
					vocals.volume = 0;
			}
		}

		if (!inCutscene && !_exiting)
		{
			if (controls.RESET)
			{
				health = 0;
				trace("RESET = True");
			}

			#if CAN_CHEAT
			if (controls.CHEAT)
			{
				health += 1;
				trace("User is cheating!");
			}
			#end

			if (health <= 0 && !practiceMode)
			{
				persistentUpdate = false;
				persistentDraw = false;
				paused = true;

				vocals.stop();
				playerVocals.stop();
				FlxG.sound.music.stop();

				deathCounter += 1;

				openSubState(new GameOverSubstate(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
			}
		}

		var spawnWindow:Float = 1800 / (noteScrollSpeed / 0.45);
		while (unspawnIndex < unspawnNotes.length && unspawnNotes[unspawnIndex].strumTime - Conductor.songPosition < spawnWindow)
		{
			var spawned:Note = unspawnNotes[unspawnIndex];
			notes.add(spawned);
			if (!spawned.isSustainNote && spawned.trail != null)
			{
				var t:SustainTrail = spawned.trail;
				t.scrollSpeed = noteScrollSpeed / 0.45;
				t.flipY = downscrollPref;
				t.visible = false;
				sustainTrails.add(t);
			}
			unspawnIndex++;
		}

		if (generatedMusic)
		{
			var noteTime:Float = Conductor.getTimeWithDelta();
			var i:Int = notes.members.length;
			while (i-- > 0)
			{
				var n:Note = notes.members[i];
				if (n != null && n.alive)
					updateNote(n, noteTime, noteScrollSpeed);
			}

			updateTrails(noteTime);
		}
		if (!inCutscene)
		{
			input.update(notes, boyfriend, cpuControlled, generatedMusic);
			strums.updatePlayer(input.pressArray, input.holdArray, cpuControlled);
			if (!cpuControlled)
				for (i in 0...4)
					if (!input.holdArray[i])
						holdCovers.keyReleased(i);
		}

		stage.postUpdate(elapsed);
		scriptArgs[0] = elapsed;
		scripts.call('postUpdate', scriptArgs);

		if (!paused && FlxG.camera.followLerp != camFollowLerp)
			FlxG.camera.followLerp = camFollowLerp;
	}

	function setFollowRate(value:Float):Void
	{
		FlxG.camera.followLerp = value;
	}

	function updateNote(daNote:Note, noteTime:Float, scrollSpeed:Float):Void
	{
		var isOpponentNote:Bool = !daNote.mustPress;

		if ((downscrollPref && daNote.y < -daNote.height) || (!downscrollPref && daNote.y > FlxG.height))
		{
			daNote.active = false;
			daNote.visible = false;
		}
		else
		{
			daNote.visible = !((middlescrollPref || hideOpponentNotes) && isOpponentNote);
			daNote.active = true;
		}

		var strum = strums.getStrum(daNote.noteData, daNote.mustPress);
		var noteStrumY:Float = strumLine.y;

		if (strum != null)
		{
			daNote.x = strum.x;

			if (daNote.isSustainNote)
				daNote.x += 36;
			else if (isPixelStage)
				daNote.x += 9;

			noteStrumY = strum.y;
		}

		var strumLineMid:Float = noteStrumY + Note.swagWidth / 2;

		if (downscrollPref)
		{
			daNote.y = noteStrumY + (noteTime - daNote.strumTime) * scrollSpeed;

			if (daNote.isSustainNote)
			{
				if (daNote.animation.curAnim.name.endsWith("end") && daNote.prevNote != null)
					daNote.y += daNote.prevNote.height + 14;
				else
					daNote.y += daNote.height / 2;

				if (daNote.trail != null)
					daNote.visible = false;
				else if (shouldClipSustain(daNote))
					daNote.setSustainClip((daNote.y + daNote.height - strumLineMid) / daNote.height);
				else
					daNote.setSustainClip(0);
			}
		}
		else
		{
			daNote.y = noteStrumY - (noteTime - daNote.strumTime) * scrollSpeed;

			if (daNote.isSustainNote)
			{
				if (daNote.trail != null)
					daNote.visible = false;
				else if (shouldClipSustain(daNote))
					daNote.setSustainClip((strumLineMid - daNote.y) / daNote.height);
				else
					daNote.setSustainClip(0);
			}
		}

		if (!daNote.mustPress && daNote.wasGoodHit && !daNote.hitHandled)
		{
			daNote.hitHandled = true;
			opponentNoteHit(daNote);
		}

		if (daNote.mustPress)
		{
			if (cpuControlled && daNote.canBeHit && (daNote.isSustainNote || daNote.strumTime <= Conductor.songPosition))
				goodNoteHit(daNote);
		}

		if (daNote.isSustainNote && daNote.wasGoodHit)
		{
			var fullyClipped:Bool = downscrollPref ? (daNote.y >= strumLineMid) : (daNote.y + daNote.height <= strumLineMid);

			if (fullyClipped)
			{
				daNote.active = false;
				daNote.visible = false;
				daNote.kill();
				notes.remove(daNote, true);
				daNote.destroy();
			}
		}
		else if (daNote.tooLate || daNote.wasGoodHit)
		{
			if (daNote.tooLate)
			{
				if (daNote.trail != null)
					daNote.trail.dropped = true;

				health -= 0.0475;

				if (splitVocals)
					playerVocals.volume = 0;
				else
					vocals.volume = 0;

				killCombo();
				noteMiss(daNote.noteData);
			}

			daNote.active = false;
			daNote.visible = false;
			daNote.kill();
			notes.remove(daNote, true);
			daNote.destroy();
		}
	}

	function updateTrails(noteTime:Float):Void
	{
		var i:Int = sustainTrails.members.length;
		while (i-- > 0)
		{
			var t:SustainTrail = sustainTrails.members[i];
			if (t == null || !t.alive)
				continue;

			var strum = strums.getStrum(t.noteDirection, t.mustPress);
			var strumY:Float = (strum != null) ? strum.y : strumLine.y;
			var strumX:Float = (strum != null) ? strum.x : 0;

			var headCenter:Float = Note.swagWidth / 2;
			var dist:Float = (noteTime - t.strumTime) * noteScrollSpeed;

			t.x = strumX + Note.swagWidth / 2 - t.graphicWidth / 2;

			if (downscrollPref)
				t.y = strumY + headCenter + dist - t.graphicHeight;
			else
				t.y = strumY + headCenter - dist;

			if (t.hit && !t.dropped)
				t.clipTime = noteTime;
			else if (!t.hit)
				t.clipTime = t.strumTime;

			var trailSpeed:Float = noteScrollSpeed / 0.45;
			t.scrollSpeed = trailSpeed;
			t.alpha = t.dropped ? 0.3 : 0.6;
			t.updateClipping(t.clipTime);
			var fullyClipped:Bool = !t.visible;

			var keyHeld:Bool = t.mustPress && !cpuControlled && input.holdArray[t.noteDirection];
			var holdActive:Bool = t.hit
				&& !t.dropped
				&& noteTime < t.strumTime + t.sustainLength
				&& (!t.mustPress || cpuControlled || keyHeld);

			if (holdActive)
			{
				strums.holdConfirm(t.noteDirection, t.mustPress);
				t.holding = true;

				if (t.mustPress || !(middlescrollPref || hideOpponentStrums))
					holdCovers.keepAlive(t.mustPress, t.noteDirection, t.strumTime + t.sustainLength, isPixelStage ? "pixel-default" : "default");
			}
			else if (t.holding)
			{
				t.holding = false;
				strums.endHold(t.noteDirection, t.mustPress, keyHeld);
			}

			var hideOpp:Bool = (middlescrollPref || hideOpponentNotes) && !t.mustPress;
			if (hideOpp)
				t.visible = false;

			var finished:Bool = t.hit && !t.dropped && noteTime >= t.strumTime + t.sustainLength;
			var offscreen:Bool = downscrollPref ? (t.y > FlxG.height + 100) : (t.y + t.graphicHeight < -100);

			if (finished || (t.dropped && offscreen) || (fullyClipped && t.hit && !t.dropped))
			{
				if (t.holding)
				{
					t.holding = false;
					strums.endHold(t.noteDirection, t.mustPress, false);
				}

				sustainTrails.remove(t, true);
				t.destroy();
			}
		}
	}

	function shouldClipSustain(n:Note):Bool
	{
		return !n.mustPress || n.wasGoodHit || (n.prevNote != null && n.prevNote.wasGoodHit && !n.canBeHit);
	}

	private function getRatingFC():String
	{
		if (cpuControlled)
			return "BOTPLAY";
		if (totalNotesPlayed == 0)
			return "?";
		if (accuracy >= 100)
			return "S";
		else if (accuracy >= 90)
			return "A";
		else if (accuracy >= 80)
			return "B";
		else if (accuracy >= 70)
			return "C";
		else if (accuracy >= 60)
			return "D";
		else
			return "F";
	}

	function killCombo():Void
	{
		if (combo > 5 && gf.animOffsets.exists('sad'))
			gf.playAnim('sad');
		if (combo != 0)
		{
			combo = 0;
			displayCombo();
		}
	}

	function endSong():Void
	{
		seenCutscene = false;
		deathCounter = 0;
		canPause = false;
		FlxG.sound.music.volume = 0;
		vocals.volume = 0;
		playerVocals.volume = 0;
		isForcedCam = true;

		camHUD.fade(0xFF000000, 0.6, false, function()
		{
			finishSong();
		});

		camFollow.setPosition(gf.getMidpoint().x, gf.getMidpoint().y - 100);
	}

	function finishSong():Void
	{
		if (SONG.validScore)
		{
			Highscore.saveScore(SONG.song, songScore, difficulty);
		}

		var stats:ResultsStats = collectStats();

		if (isStoryMode)
		{
			campaignScore += songScore;
			campaignStats = ResultsState.merge(campaignStats, stats);
			storyPlaylist.remove(storyPlaylist[0]);

			if (storyPlaylist.length <= 0)
			{
				StoryMenuState.weekUnlocked[Std.int(Math.min(storyWeek + 1, StoryMenuState.weekUnlocked.length - 1))] = true;

				if (SONG.validScore)
				{
					NGio.unlockMedal(60961);
					Highscore.saveWeekScore(storyWeek, campaignScore, difficulty);
				}

				FlxG.save.data.weekUnlocked = StoryMenuState.weekUnlocked;
				FlxG.save.flush();

				var weekStats = campaignStats;
				campaignStats = null;

				var leave = function()
				{
					FlxG.sound.playMusic(Paths.music('freakyMenu'));
					switch (PlayState.storyWeek)
					{
						case 7:
							FlxG.switchState(new VideoState());
						default:
							FlxG.switchState(new StoryMenuState());
					}
				};

				if (cpuControlled)
					leave();
				else
					FlxG.switchState(new ResultsState(weekStats, 'Week ' + storyWeek, leave));
			}
			else
			{
				var diffSuffix:String = CoolUtil.chartSuffix(difficulty);

				trace('LOADING NEXT SONG');
				trace(storyPlaylist[0].toLowerCase() + diffSuffix);

				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;

				FlxG.sound.music.stop();
				vocals.stop();
				playerVocals.stop();

				if (SONG.song.toLowerCase() == 'eggnog')
				{
					var blackShit:FlxSprite = new FlxSprite(-FlxG.width * FlxG.camera.zoom,
						-FlxG.height * FlxG.camera.zoom).makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
					blackShit.scrollFactor.set();
					add(blackShit);
					camHUD.visible = false;
					inCutscene = true;

					FlxG.sound.play(Paths.sound('Lights_Shut_off'), function()
					{
						SONG = Song.loadFromJson(storyPlaylist[0].toLowerCase() + diffSuffix, storyPlaylist[0]);
						LoadingState.loadAndSwitchState(new PlayState());
					});
				}
				else
				{
					prevCamFollow = camFollow;

					SONG = Song.loadFromJson(storyPlaylist[0].toLowerCase() + diffSuffix, storyPlaylist[0]);
					LoadingState.loadAndSwitchState(new PlayState());
				}
			}
		}
		else
		{
			if (cpuControlled)
				FlxG.switchState(new FreeplayState());
			else
				FlxG.switchState(new ResultsState(stats, null, function() FlxG.switchState(new FreeplayState())));
		}
	}

	private function popUpScore(strumtime:Float, daNote:Note):Void
	{
		var noteDiff:Float = Math.abs(Conductor.getTimeWithDelta() - strumtime);
		vocals.volume = 1;

		var score:Int = 350;

		var daRating:String = "sick";
		var isSick:Bool = true;

		if (noteDiff > Note.BAD_WINDOW)
		{
			daRating = "shit";
			score = 50;
			isSick = false;
			daNote.alpha = 0.6;
			killCombo();
		}
		else if (noteDiff > Note.GOOD_WINDOW)
		{
			daRating = "bad";
			score = 100;
			isSick = false;
		}
		else if (noteDiff > Note.SICK_WINDOW)
		{
			daRating = "good";
			score = 200;
			isSick = false;
		}

		// psych engine ahh hitboxes

		switch (daRating)
		{
			case "sick":
				totalNotesHit += 1.0;
				sickCount++;
			case "good":
				totalNotesHit += 0.75;
				goodCount++;
			case "bad":
				totalNotesHit += 0.50;
				badCount++;
			case "shit":
				totalNotesHit += 0.25;
				shitCount++;
		}

		totalNotesPlayed++;

		accuracy = (totalNotesHit / totalNotesPlayed) * 100;

		if (isSick)
		{
			var strum:FlxSprite = strums.getStrum(daNote.noteData, daNote.mustPress);

			var splash:NoteSplash = grpNoteSplashes.recycle(NoteSplash);
			splash.setupNoteSplash(strum.x, strum.y, daNote.noteData);
			grpNoteSplashes.add(splash);
		}

		if (!practiceMode)
			songScore += score;

		comboGroup.popRating(daRating, isPixelStage, showRating);

		if (combo >= 10 || combo == 0)
			displayCombo();

		if (combo == 50 || combo == 200)
			gf.playAnim('cheer', true);
	}

	function displayCombo():Void
	{
		if (!showCombo)
			return;

		comboGroup.popNumbers(combo, isPixelStage);
	}

	function collectStats():ResultsStats
	{
		return {
			total: sickCount + goodCount + badCount + shitCount,
			max: maxCombo,
			sick: sickCount,
			good: goodCount,
			bad: badCount,
			shit: shitCount,
			miss: songMisses,
			score: songScore,
			accuracy: accuracy / 100,
			played: totalNotesPlayed
		};
	}

	var cameraRightSide:Bool = false;
	var camEvents:Array<Song.CamEvent> = [];
	var camEventIdx:Int = -1;
	var camTarget:Int = 0;
	var cameraOffsetDadX:Float = 0;
	var cameraOffsetDadY:Float = 0;
	var cameraOffsetbfX:Float = 0;
	var cameraOffsetbfY:Float = 0;

	function cameraMovement()
	{
		if (isForcedCam)
			return;

		if (camTarget == 2)
			moveCameraGf();
		else
			moveCamera(camTarget == 0);
	}

	static inline var CAM_TWEEN_LERP:Float = 1;

	var camPointTmp:FlxPoint = new FlxPoint();
	var camTween:FlxTween = null;
	var camFollowLerp:Float = 0.04;
	var camTweensEnabled:Bool = true;

	function getCamPoint(target:Int, out:FlxPoint):FlxPoint
	{
		if (target == 2)
		{
			if (gf == null)
				return null;

			gf.getMidpoint(tmpMid);

			if (curStage.startsWith('school'))
			{
				return out.set(tmpMid.x - 330, tmpMid.y - 200);
			}
			else if (stage.gfVersion == 'gf-car')
			{
				return out.set(tmpMid.x, tmpMid.y - 350);
			}

			return out.set(tmpMid.x - 50, tmpMid.y - 15);
		}

		if (target == 0)
		{
			if (dad == null)
				return null;

			dad.getMidpoint(tmpMid);

			var dx:Float = tmpMid.x + 150 + cameraOffsetDadX;
			var dy:Float = tmpMid.y - 100 + cameraOffsetDadY;

			switch (dad.curCharacter)
			{
				case 'mom':
					dy = tmpMid.y;
				case 'senpai' | 'senpai-angry':
					dy = tmpMid.y - 430;
					dx = tmpMid.x - 100;
			}

			return out.set(dx, dy);
		}

		if (boyfriend == null)
			return null;

		boyfriend.getMidpoint(tmpMid);

		var bx:Float = tmpMid.x - 100 + cameraOffsetbfX;
		var by:Float = tmpMid.y - 100 + cameraOffsetbfY;

		switch (curStage)
		{
			case 'limo':
				bx = tmpMid.x - 300;
			case 'mall':
				by = tmpMid.y - 200;
			case 'school' | 'schoolEvil':
				bx = tmpMid.x - 200;
				by = tmpMid.y - 250;
		}

		return out.set(bx, by);
	}

	function moveCameraGf()
	{
		var p:FlxPoint = getCamPoint(2, camPointTmp);
		if (p != null)
			camFollow.setPosition(p.x, p.y);
	}

	public function moveCamera(isDad:Bool)
	{
		var p:FlxPoint = getCamPoint(isDad ? 0 : 1, camPointTmp);
		if (p != null)
			camFollow.setPosition(p.x, p.y);
	}

	function camEventTweens(ev:Song.CamEvent):Bool
	{
		return camTweensEnabled && Song.camIsTween(ev);
	}

	function updateCameraEvents():Void
	{
		if (camEvents.length == 0)
			return;

		var prevIdx:Int = camEventIdx;

		while (camEventIdx + 1 < camEvents.length && camEvents[camEventIdx + 1].time <= Conductor.songPosition)
			camEventIdx++;
		while (camEventIdx >= 0 && camEvents[camEventIdx].time > Conductor.songPosition)
			camEventIdx--;

		var ev:Song.CamEvent = camEvents[Std.int(Math.max(camEventIdx, 0))];

		camTarget = ev.target;
		cameraRightSide = (ev.target == 1);

		if (camEventIdx != prevIdx)
		{
			if (camEventIdx >= 0)
				applyCamEvent(ev);
			else
				resetCamClassic();
		}

		if (camEventIdx < 0 || !camEventTweens(ev))
			cameraMovement();
	}

	function stopCamTween():Void
	{
		if (camTween != null)
		{
			camTween.cancel();
			camTween = null;
		}
	}

	function setCamFollowLerp(value:Float):Void
	{
		camFollowLerp = value;

		if (!paused)
			setFollowRate(value);
	}

	function resetCamClassic():Void
	{
		stopCamTween();
		setCamFollowLerp(0.04);
	}

	function applyCamEvent(ev:Song.CamEvent):Void
	{
		resetCamClassic();

		if (!camEventTweens(ev) || isForcedCam)
			return;

		var p:FlxPoint = getCamPoint(ev.target, camPointTmp);
		if (p == null)
			return;

		var tx:Float = p.x + ((ev.x == null) ? 0 : ev.x);
		var ty:Float = p.y + ((ev.y == null) ? 0 : ev.y);
		var dur:Float = Song.camDuration(ev) * Conductor.stepCrochet / 1000;

		setCamFollowLerp(CAM_TWEEN_LERP);

		if (ev.ease.toUpperCase() == Song.CAM_INSTANT || dur <= 0)
		{
			camFollow.setPosition(tx, ty);
			return;
		}

		camTween = FlxTween.tween(camFollow, {x: tx, y: ty}, dur, {
			ease: getCameraEase(ev.ease),
			onComplete: function(twn:FlxTween)
			{
				camTween = null;
			}
		});
	}

	function tweenCameraToCharacter(target:String, duration:Float = 0.5, ease:String = 'quadOut', force:Bool = false)
	{
		if (force)
			isForcedCam = true;

		var targetX:Float;
		var targetY:Float;

		switch (target.toLowerCase())
		{
			case 'dad':
				targetX = dad.getMidpoint().x + 150 + cameraOffsetDadX;
				targetY = dad.getMidpoint().y - 100 + cameraOffsetDadY;

				switch (dad.curCharacter)
				{
					case 'mom':
						targetY = dad.getMidpoint().y;

					case 'senpai' | 'senpai-angry':
						targetX = dad.getMidpoint().x - 100;
						targetY = dad.getMidpoint().y - 430;
				}

			case 'boyfriend' | 'bf':
				targetX = boyfriend.getMidpoint().x - 100 + cameraOffsetbfX;
				targetY = boyfriend.getMidpoint().y - 100 + cameraOffsetbfY;

				switch (curStage)
				{
					case 'limo':
						targetX = boyfriend.getMidpoint().x - 300;

					case 'mall':
						targetY = boyfriend.getMidpoint().y - 200;

					case 'school' | 'schoolEvil':
						targetX = boyfriend.getMidpoint().x - 200;
						targetY = boyfriend.getMidpoint().y - 200;
				}

			case 'gf':
				targetX = gf.getMidpoint().x;
				targetY = gf.getMidpoint().y;

			default:
				return;
		}

		FlxTween.cancelTweensOf(camFollow);

		FlxTween.tween(camFollow, {
			x: targetX,
			y: targetY
		}, duration, {
			ease: getCameraEase(ease)
		});
	}

	function getCameraEase(ease:String):Dynamic
	{
		switch (ease)
		{
			case 'linear':
				return FlxEase.linear;

			case 'quadIn':
				return FlxEase.quadIn;
			case 'quadOut':
				return FlxEase.quadOut;
			case 'quadInOut':
				return FlxEase.quadInOut;

			case 'cubeIn':
				return FlxEase.cubeIn;
			case 'cubeOut':
				return FlxEase.cubeOut;
			case 'cubeInOut':
				return FlxEase.cubeInOut;

			case 'sineIn':
				return FlxEase.sineIn;
			case 'sineOut':
				return FlxEase.sineOut;
			case 'sineInOut':
				return FlxEase.sineInOut;

			case 'elasticIn':
				return FlxEase.elasticIn;
			case 'elasticOut':
				return FlxEase.elasticOut;
			case 'elasticInOut':
				return FlxEase.elasticInOut;

			case 'bounceIn':
				return FlxEase.bounceIn;
			case 'bounceOut':
				return FlxEase.bounceOut;
			case 'bounceInOut':
				return FlxEase.bounceInOut;

			case 'backIn':
				return FlxEase.backIn;
			case 'backOut':
				return FlxEase.backOut;
			case 'backInOut':
				return FlxEase.backInOut;

			default:
				var easeFunc:Dynamic = Reflect.field(FlxEase, ease);
				return (easeFunc != null && Reflect.isFunction(easeFunc)) ? easeFunc : FlxEase.quadOut;
		}
	}

	var camScrollX:Float = 0;
	var camScrollY:Float = 0;

	function doScrollStuff(x:Float, y:Float)
	{
		camScrollX = x;
		camScrollY = y;

		if (camFollowLerp != CAM_TWEEN_LERP)
			FlxG.camera.targetOffset.set(x, y);
	}

	function updateScrollOffset():Void
	{
		if (!camMovementPref || camFollowLerp != CAM_TWEEN_LERP)
			return;

		var off = FlxG.camera.targetOffset;
		var goalX:Float = camScrollX;
		var goalY:Float = camScrollY;
		off.set(CoolUtil.fpsLerp(off.x, goalX, 0.04), CoolUtil.fpsLerp(off.y, goalY, 0.04));
	}

	function playSing(char:Character, anim:String, note:Note):Void
	{
		if (note.isSustainNote)
			return;

		char.playAnim(anim, true);
	}

	function extrasSing(list:Array<Character>, singAnim:String, altAnim:String, note:Note):Void
	{
		for (c in list)
		{
			if (c == null)
				continue;

			var a:String = singAnim + altAnim;
			if (altAnim != '' && !c.animation.exists(a))
				a = singAnim;
			if (!c.animation.exists(a))
				continue;

			playSing(c, a, note);
			c.holdTimer = 0;
		}
	}

	function extrasDance():Void
	{
		for (list in [stage.extraBoyfriends, stage.extraDads])
		{
			for (c in list)
			{
				if (c != null && c.animation.curAnim != null && !c.animation.curAnim.name.startsWith('sing'))
					c.dance();
			}
		}
	}

	function noteMiss(direction:Int = 1):Void
	{
		songMisses += 1;
		totalNotesPlayed++;
		accuracy = (totalNotesHit / totalNotesPlayed) * 100;
		health -= 0.04;
		killCombo();
		songScore -= 10;

		if (splitVocals)
			playerVocals.volume = 0;
		else
			vocals.volume = 0;

		switch (direction)
		{
			case 0:
				boyfriend.playAnim('singLEFTmiss', true);
			case 1:
				boyfriend.playAnim('singDOWNmiss', true);
			case 2:
				boyfriend.playAnim('singUPmiss', true);
			case 3:
				boyfriend.playAnim('singRIGHTmiss', true);
		}

		var missAnim:String = ['singLEFTmiss', 'singDOWNmiss', 'singUPmiss', 'singRIGHTmiss'][direction];
		for (c in stage.extraBoyfriends)
		{
			if (c != null && c.animation.exists(missAnim))
			{
				c.playAnim(missAnim, true);
			}
		}

		FlxG.sound.play(Paths.soundRandom('missnote', 1, 3), FlxG.random.float(0.1, 0.2));
	}

	function goodNoteHit(note:Note):Void
	{
		if (!note.wasGoodHit)
		{
			boyfriend.holdTimer = 0;

			if (!note.isSustainNote)
			{
				combo += 1;
				if (combo > maxCombo)
					maxCombo = combo;
				popUpScore(note.strumTime, note);

				if (PreferencesMenu.getPref('hitsounds'))
				{
					FlxG.sound.play(Paths.sound('hitSound')); // von codename engine, muss ich noch ersetzen
				}
			}

			health += 0.023;

			if (!note.noAnimation)
			{
				var altAnim:String = note.altNote ? '-alt' : '';
				var singAnim:String = ['singLEFT', 'singDOWN', 'singUP', 'singRIGHT'][note.noteData];
				if (altAnim != "" && !boyfriend.animation.exists(singAnim + altAnim))
					altAnim = "";

				playSing(boyfriend, singAnim + altAnim, note);
				extrasSing(stage.extraBoyfriends, singAnim, altAnim, note);
			}

			strums.confirmPlayer(note.noteData);

			var coverStyle:String = isPixelStage ? "pixel-default" : "default";
			if (!note.isSustainNote && note.sustainLength > 0)
				holdCovers.noteHit(true, note.noteData, note.strumTime, note.sustainLength, coverStyle);

			note.wasGoodHit = true;
			if (!note.isSustainNote && note.trail != null)
				note.trail.hit = true;
			vocals.volume = 1;
			playerVocals.volume = 1;

			stage.rainTimeScale += 0.7;

			if (!note.isSustainNote)
			{
				note.kill();
				notes.remove(note, true);
				note.destroy();
			}
		}

		scripts.call('onNoteHit', [note]);
		stage.noteHit(note, true);
	}

	function opponentNoteHit(note:Note):Void
	{
		strums.confirmOpponent(note.noteData);

		if (!note.isSustainNote && note.trail != null)
			note.trail.hit = true;

		if (!middlescrollPref && !hideOpponentStrums)
		{
			var coverStyle:String = isPixelStage ? "pixel-default" : "default";
			if (!note.isSustainNote && note.sustainLength > 0)
				holdCovers.noteHit(false, note.noteData, note.strumTime, note.sustainLength, coverStyle);
		}

		stage.rainTimeScale += 0.7;

		if (SONG.song != 'Tutorial')
			camZooming = true;

		var altAnim:String = "";

		if (SONG.notes[Math.floor(curStep / 16)] != null)
		{
			if (SONG.notes[Math.floor(curStep / 16)].altAnim)
				altAnim = '-alt';
		}

		if (note.altNote)
			altAnim = '-alt';

		if (!note.noAnimation)
		{
			var singAnim:String = ['singLEFT', 'singDOWN', 'singUP', 'singRIGHT'][note.noteData];
			playSing(dad, singAnim + altAnim, note);
			extrasSing(stage.extraDads, singAnim, altAnim, note);
		}

		dad.holdTimer = 0;

		if (SONG.needsVoices)
			vocals.volume = 1;

		if (!note.isSustainNote)
		{
			note.kill();
			notes.remove(note, true);
			note.destroy();
		}

		scripts.call('onOpponentHit', [note]);
	}

	override function stepHit()
	{
		super.stepHit();

		stage.stepHit(curStep);

		scripts.call('stepHit', [curStep]);

		var syncPos:Float = Conductor.songPosition - Conductor.offset;

		if (Math.abs(FlxG.sound.music.time - syncPos) > 20 || (SONG.needsVoices && Math.abs(vocals.time - syncPos) > 20))
		{
			resyncVocals();
		}

		if (curStep == 5)
		{
			resyncVocals();
		}
	}

	override function beatHit()
	{
		super.beatHit();

		scripts.call('beatHit', [curBeat]);

		if (generatedMusic)
		{
			notes.sort(sortNotes, FlxSort.DESCENDING);
		}

		if (SONG.notes[Math.floor(curStep / 16)] != null)
		{
			if (SONG.notes[Math.floor(curStep / 16)].changeBPM)
			{
				Conductor.changeBPM(SONG.notes[Math.floor(curStep / 16)].bpm);
				FlxG.log.add('CHANGED BPM!');
			}
		}

		if (camZoomPref)
		{
			if (curSong.toLowerCase() == 'milf' && curBeat >= 168 && curBeat < 200 && camZooming && FlxG.camera.zoom < 1.35)
			{
				cameraBopZoom += 0.015;
				camHUD.zoom += 0.03;
			}

			if (camZooming && FlxG.camera.zoom < 1.35 && curBeat % camZoomInterval == 0)
			{
				cameraBopZoom += camZoomAmount;
				camHUD.zoom += camHUDZoomAmount;
			}
		}

		var iconScale = 1.2;
		iconP2.scale.set(1 * iconScale, 1 * iconScale);
		iconP2.updateHitbox();

		iconP1.scale.set(1 * iconScale, 1 * iconScale);
		iconP1.updateHitbox();

		danceHeads(curBeat);

		if (curBeat % 2 == 0)
			extrasDance();

		if (curBeat % 8 == 7 && curSong == 'Bopeebo')
		{
			boyfriend.playAnim('hey', true);
		}

		if (curBeat % 16 == 15 && SONG.song == 'Tutorial' && dad.curCharacter == 'gf' && curBeat > 16 && curBeat < 48)
		{
			boyfriend.playAnim('hey', true);
			dad.playAnim('cheer', true);
		}

		stage.beatHit(curBeat);
	}

	function setCamZoomInterval(?interval:Int, ?cameraZoom:Float, ?hudZoom:Float)
	{
		if (interval == null || cameraZoom == null || hudZoom == null)
		{
			camZoomInterval = 4;
			camZoomAmount = 0.015;
			camHUDZoomAmount = 0.03;
			return;
		}

		camZoomInterval = interval;
		camZoomAmount = cameraZoom;
		camHUDZoomAmount = hudZoom;
	}

	override function destroy()
	{
		PreferencesMenu.clearSongOverrides();
		if (input != null)
		{
			input.destroy();
			input = null;
		}
		super.destroy();
	}
}
