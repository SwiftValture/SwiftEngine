package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import shaderslmfao.ColorSwap;
import ui.PreferencesMenu;
import openfl.Lib;

using StringTools;

#if desktop
import sys.FileSystem;
import sys.io.File;
import sys.thread.Thread;
#end

class TitleState extends MusicBeatState
{
	public static var initialized:Bool = false;

	var startedIntro:Bool;

	var blackScreen:FlxSprite;
	var credGroup:FlxGroup;
	var credTextShit:Alphabet;
	var textGroup:FlxGroup;
	var ngSpr:FlxSprite;

	var curWacky:Array<String> = [];
	var wackyImage:FlxSprite;
	var lastBeat:Int = 0;
	var swagShader:ColorSwap;

	var window = Lib.application.window;
	var jingleArray:Array<Int> = [0x0001, 0x0010, 0x0001, 0x0010, 0x0100, 0x1000, 0x0100, 0x1000];
	var curJinglePos:Int = 0;
	var jingleActive:Bool = false;

	override public function create():Void
	{
		startedIntro = false;

		FlxG.game.focusLostFramerate = 60;

		swagShader = new ColorSwap();

		FlxG.sound.muteKeys = [ZERO];

		curWacky = FlxG.random.getObject(getIntroTextShit());

		super.create();

		PreferencesMenu.initPrefs();
		PlayerSettings.init();
		Highscore.load();

		#if newgrounds
		NGio.init();
		#end

		if (FlxG.save.data.weekUnlocked != null)
		{
			if (StoryMenuState.weekUnlocked.length < 4)
				StoryMenuState.weekUnlocked.insert(0, true);

			if (!StoryMenuState.weekUnlocked[0])
				StoryMenuState.weekUnlocked[0] = true;
		}

		if (FlxG.save.data.seenVideo != null)
		{
			VideoState.seenVideo = FlxG.save.data.seenVideo;
		}

		#if FREEPLAY
		FlxG.switchState(new FreeplayState());
		#elseif ANIMATE
		FlxG.switchState(new CutsceneAnimTestState());
		#elseif CHARTING
		FlxG.switchState(new ChartingState());
		#else
		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			startIntro();
		});
		#end
	}

	var logoBl:FlxSprite;

	var gfDance:FlxSprite;
	var danceLeft:Bool = false;
	var titleText:FlxSprite;

	function startIntro()
	{
		if (!initialized)
		{
			var diamond:FlxGraphic = FlxGraphic.fromClass(GraphicTransTileDiamond);
			diamond.persist = true;
			diamond.destroyOnNoUse = false;

			FlxTransitionableState.defaultTransIn = new TransitionData(FADE, FlxColor.BLACK, 1, new FlxPoint(0, -1), {asset: diamond, width: 32, height: 32},
				new FlxRect(-200, -200, FlxG.width * 1.4, FlxG.height * 1.4));
			FlxTransitionableState.defaultTransOut = new TransitionData(FADE, FlxColor.BLACK, 0.7, new FlxPoint(0, 1),
				{asset: diamond, width: 32, height: 32}, new FlxRect(-200, -200, FlxG.width * 1.4, FlxG.height * 1.4));
		}

		if (FlxG.sound.music == null || !FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
			FlxG.sound.music.fadeIn(4, 0, 0.7);
		}

		Conductor.changeBPM(102);
		persistentUpdate = true;

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);

		add(bg);

		logoBl = new FlxSprite(-150, -100);
		logoBl.frames = Paths.getSparrowAtlas('logoBumpin');
		logoBl.antialiasing = true;
		logoBl.animation.addByPrefix('bump', 'logo bumpin', 24);
		logoBl.animation.play('bump');

		logoBl.updateHitbox();

		logoBl.shader = swagShader.shader;

		gfDance = new FlxSprite(FlxG.width * 0.4, FlxG.height * 0.07);
		gfDance.frames = Paths.getSparrowAtlas('gfDanceTitle');
		gfDance.animation.addByIndices('danceLeft', 'gfDance', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
		gfDance.animation.addByIndices('danceRight', 'gfDance', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
		gfDance.antialiasing = true;
		add(gfDance);

		gfDance.shader = swagShader.shader;

		add(logoBl);

		titleText = new FlxSprite(100, FlxG.height * 0.8);
		titleText.frames = Paths.getSparrowAtlas('titleEnter');
		titleText.animation.addByPrefix('idle', "Press Enter to Begin", 24);
		titleText.animation.addByPrefix('press', "ENTER PRESSED", 24);
		titleText.antialiasing = true;
		titleText.animation.play('idle');
		titleText.updateHitbox();
		add(titleText);

		credGroup = new FlxGroup();
		add(credGroup);
		textGroup = new FlxGroup();

		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		credGroup.add(blackScreen);

		ngSpr = new FlxSprite(0, FlxG.height * 0.52 + 40).loadGraphic(Paths.image('newgrounds_logo'));
		add(ngSpr);
		ngSpr.visible = false;
		ngSpr.setGraphicSize(Std.int(ngSpr.width * 0.8));
		ngSpr.updateHitbox();
		ngSpr.screenCenter(X);
		ngSpr.antialiasing = true;

		FlxG.mouse.visible = false;

		if (initialized)
			skipIntro();
		else
			initialized = true;

		startedIntro = true;
	}

	function jingleInput()
	{
		if (FlxG.keys.justPressed.LEFT)
			jingleCode(0x0001);
		if (FlxG.keys.justPressed.DOWN)
			jingleCode(0x1000);
		if (FlxG.keys.justPressed.UP)
			jingleCode(0x0100);
		if (FlxG.keys.justPressed.RIGHT)
			jingleCode(0x0010);
	}

	function jingleCode(input:Int)
	{
		if (input == jingleArray[curJinglePos])
		{
			if ((++curJinglePos) >= jingleArray.length)
				startJingle();
		}
		else
			curJinglePos = 0;
	}

	function startJingle()
	{
		jingleActive = true;

		FlxG.sound.playMusic(Paths.music("girlfriendsRingtone"), 0, true);
		FlxG.sound.music.fadeIn(4, 0, 1);

		FlxG.camera.flash(FlxColor.WHITE, 1, null, true);
		FlxG.sound.play(Paths.sound("scrollMenu"));

		Conductor.changeBPM(160);
	}

	function getIntroTextShit():Array<Array<String>>
	{
		return [
			["shoutouts to tom fulp", "lmao"],
			["Ludum dare", "extraordinaire"],
			["cyberzone", "coming soon"],
			["love to thriftman", "swag"],
			["ultimate rhythm gaming", "probably"],
			["dope ass game", "playstation magazine"],
			["in loving memory of", "henryeyes"],
			["dancin", "forever"],
			["funkin", "forever"],
			["ritz dx", "rest in peace lol"],
			["rate five", "pls no blam"],
			["rhythm gaming", "ultimate"],
			["game of the year", "forever"],
			["you already know", "we really out here"],
			["rise and grind", "love to luis"],
			["like parappa", "but cooler"],
			["album of the year", "chuckie finster"],
			["free gitaroo man", "with love to wandaboy"],
			["better than geometry dash", "fight me robtop"],
			["kiddbrute for president", "vote now"],
			["play dead estate", "on newgrounds"],
			["this is a god damn prototype", "we workin on it okay"],
			["women are real", "this is official"],
			["too over exposed", "newgrounds cant handle us"],
			["Hatsune Miku", "biggest inspiration"],
			["too many people", "my head hurts"],
			["newgrounds", "forever"],
			["refined taste in music", "if i say so myself"],
			["his name isnt keith", "dumb eggy lol"],
			["his name isnt evan", "silly tiktok"],
			["stream chuckie finster", "on spotify"],
			["never forget to", "pray to god"],
			["dont play rust", "we only funkin"],
			["good bye", "my penis"],
			["dababy", "biggest inspiration"],
			["fashionably late", "but here it is"],
			["yooooooooooo", "yooooooooo"],
			["pico funny", "pico funny"],
			["updates each friday", "on time every time"],
			["shoutouts to mason", "for da homies"],
			["bonk", "get in the discord call"],
			["carpal tunnel", "game design"],
			["downscroll", "i dont know what that is"],
			["warning", "choking hazard"],
			["devin chat", "what an honorable man"],
			["kickstarter exclusive", "intro text"],
			["cussing", "we have it"],
			["github exclusive intro text", "open source forever"]
		];
	}

	var transitioning:Bool = false;

	var wasnet = false;

	override function update(elapsed:Float)
	{
		if (controls.BACK)
			window.close();

		if (FlxG.keys.justPressed.Y)
		{
			if (!wasnet)
			{
				FlxTween.tween(window, {x: window.x + 300}, 1.4, {ease: FlxEase.quadInOut, type: FlxTweenType.PINGPONG, startDelay: 0.35});
				FlxTween.tween(window, {y: window.y + 100}, 0.7, {ease: FlxEase.quadInOut, type: FlxTweenType.PINGPONG});
				wasnet = true;
			}
			else
			{
				FlxTween.cancelTweensOf(window, ["x", "y"]);
				wasnet = false;
			}
		}

		if (!jingleActive && skippedIntro)
		{
			jingleInput();
		}

		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;

		if (FlxG.keys.justPressed.F)
			FlxG.fullscreen = !FlxG.fullscreen;

		var pressedEnter:Bool = FlxG.keys.justPressed.ENTER;

		#if mobile
		for (touch in FlxG.touches.list)
		{
			if (touch.justPressed)
				pressedEnter = true;
		}
		#end

		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

		if (gamepad != null)
		{
			if (gamepad.justPressed.START)
				pressedEnter = true;

			#if switch
			if (gamepad.justPressed.B)
				pressedEnter = true;
			#end
		}

		if (pressedEnter && skippedIntro)
		{
			if (transitioning)
			{
				FlxG.switchState(new MainMenuState());
				return;
			}

			if (FlxG.sound.music != null)
				FlxG.sound.music.onComplete = null;

			titleText.animation.play('press');

			FlxG.camera.flash(FlxColor.WHITE, 1);
			FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);

			transitioning = true;

			new FlxTimer().start(2, function(tmr:FlxTimer)
			{
				FlxG.switchState(new MainMenuState());
			});
		}

		if (pressedEnter && !skippedIntro && initialized)
			skipIntro();

		if (!jingleActive)
		{
			if (controls.UI_LEFT)
				swagShader.update(-elapsed * 0.1);

			if (controls.UI_RIGHT)
				swagShader.update(elapsed * 0.1);
		}

		if (jingleActive)
		{
			swagShader.update(elapsed * 0.1);
		}

		super.update(elapsed);
	}

	function createCoolText(textArray:Array<String>)
	{
		for (i in 0...textArray.length)
		{
			var money:Alphabet = new Alphabet(0, 0, textArray[i], true, false);
			money.screenCenter(X);
			money.y += (i * 70) + 200;
			credGroup.add(money);
			textGroup.add(money);
		}
	}

	function addMoreText(text:String)
	{
		var coolText:Alphabet = new Alphabet(0, 0, text, true, false);
		coolText.screenCenter(X);
		coolText.y += (textGroup.length * 70) + 200;
		credGroup.add(coolText);
		textGroup.add(coolText);
	}

	function deleteCoolText()
	{
		while (textGroup.members.length > 0)
		{
			credGroup.remove(textGroup.members[0], true);
			textGroup.remove(textGroup.members[0], true);
		}
	}

	var isRainbow:Bool = false;

	override function beatHit()
	{
		super.beatHit();

		if (!startedIntro)
			return;

		if (skippedIntro)
		{
			logoBl.animation.play('bump', true);

			danceLeft = !danceLeft;

			if (danceLeft)
				gfDance.animation.play('danceRight');
			else
				gfDance.animation.play('danceLeft');
		}
		else
		{
			FlxG.log.add(curBeat);
			if (curBeat > lastBeat)
			{
				for (i in lastBeat...curBeat)
				{
					switch (i + 1)
					{
						case 1:
							createCoolText(['ninjamuffin99', 'phantomArcade', 'kawaisprite', 'evilsk8er']);
						case 3:
							addMoreText('present');
						case 4:
							deleteCoolText();
						case 5:
							createCoolText(['In association', 'with']);
						case 7:
							addMoreText('newgrounds');
							ngSpr.visible = true;
						case 8:
							deleteCoolText();
							ngSpr.visible = false;
						case 9:
							createCoolText([curWacky[0]]);
						case 11:
							addMoreText(curWacky[1]);
						case 12:
							deleteCoolText();
						case 13:
							addMoreText('Friday');
						case 14:
							addMoreText('Night');
						case 15:
							addMoreText('Funkin');
						case 16:
							skipIntro();
					}
				}
			}
			lastBeat = curBeat;
		}
	}

	var skippedIntro:Bool = false;

	function skipIntro():Void
	{
		if (!skippedIntro)
		{
			remove(ngSpr);

			FlxG.camera.flash(FlxColor.WHITE, 4);
			remove(credGroup);
			skippedIntro = true;
		}
	}
}
