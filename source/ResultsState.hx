package;

import animate.FlxAnimate;
import animate.FlxAnimateFrames;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.effects.FlxSkewedSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.text.FlxBitmapText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

typedef ResultsStats =
{
	var total:Int;
	var max:Int;
	var sick:Int;
	var good:Int;
	var bad:Int;
	var shit:Int;
	var miss:Int;
	var score:Int;
	var accuracy:Float;
	var played:Int;
}

typedef RankSprite =
{
	var sheet:String;
	var isAtlas:Bool;
	var anim:String;
	var loopFrame:Int;
	var x:Float;
	var y:Float;
	var delay:Float;
	@:optional var scale:Float;
	@:optional var extra:RankSprite;
	@:optional var front:Bool;
}

class ResultsState extends MusicBeatState
{
	var stats:ResultsStats;
	var title:String;
	var onExit:Void->Void;

	var camFront:FlxCamera;
	var camTitle:FlxCamera;
	var camChars:FlxCamera;

	var rank:String = 'shit';
	var targetNum:Int = 0;

	var titleGap:Float = 40;

	var scrollers:Array<FlxBackdrop> = [];
	var scoreGroup:FlxTypedSpriteGroup<ScoreGuy>;
	var songName:FlxBitmapText;
	var songDifficulty:FlxSprite;
	var clearBig:ClearPercentCounter;
	var clearSmall:ClearPercentCounter;
	var grahh:FlxBackdrop;
	var resultsAnim:FlxSprite;
	var soundSystem:FlxSprite;
	var ratingsPopin:FlxSprite;
	var scorePopin:FlxSprite;

	var titleWait:Float = 5;
	var canPress:Bool = true;

	var debugSpr:FlxSprite;

	public static var fadeInNextState:Bool = false;

	public function new(stats:ResultsStats, ?title:String, ?onExit:Void->Void)
	{
		super();
		transIn = null;
		transOut = null;
		this.stats = stats;
		this.title = title;
		this.onExit = onExit;
	}

	public static function merge(a:ResultsStats, b:ResultsStats):ResultsStats
	{
		if (a == null)
			return b;

		var played:Int = a.played + b.played;
		return {
			total: a.total + b.total,
			max: Std.int(Math.max(a.max, b.max)),
			sick: a.sick + b.sick,
			good: a.good + b.good,
			bad: a.bad + b.bad,
			shit: a.shit + b.shit,
			miss: a.miss + b.miss,
			score: a.score + b.score,
			accuracy: played > 0 ? (a.accuracy * a.played + b.accuracy * b.played) / played : 0,
			played: played
		};
	}

	function getRankTrueName():String
	{
		if (rank == 'shit')
			return 'LOSS';
		return rank.toUpperCase();
	}

	function getFromNum(real:Int):String
	{
		var rankID:String = 'shit';
		if (real >= 69)
			rankID = 'good';
		if (real >= 80)
			rankID = 'great';
		if (real >= 90)
			rankID = 'excellent';
		if (real >= 100)
			rankID = 'perfect';
		return rankID;
	}

	function getRankMusicName():String
	{
		return switch (getRankTrueName())
		{
			case 'GOOD' | 'GREAT': 'NORMAL';
			case 'EXCELLENT': 'EXCELLENT-intro';
			case 'PERFECT': 'PERFECT';
			default: 'SHIT-intro';
		}
	}

	function getNameX():Float
	{
		var pctWidth:Float = (Std.string(targetNum).length + 1) * 30;
		return songDifficulty.x + songDifficulty.width + titleGap + pctWidth + titleGap;
	}

	override function create()
	{
		super.create();

		targetNum = Std.int(Math.max(0, Math.min(100, stats.accuracy * 100 + 0.0001)));
		rank = getFromNum(targetNum);

		FlxG.camera.bgColor = 0xffFECC5C;
		FlxG.camera.width = Std.int(FlxG.camera.width * 1.25);
		FlxG.camera.height = Std.int(FlxG.camera.height * 1.25);
		FlxG.camera.setPosition((FlxG.width - FlxG.camera.width) * 0.5, 0);
		FlxG.camera.scroll.x = FlxG.camera.x;

		FlxG.camera.angle = -3.8;

		camChars = new FlxCamera();
		camChars.bgColor = 0x00000000;
		FlxG.cameras.add(camChars, false);

		camTitle = new FlxCamera(Std.int(FlxG.camera.x), 0, FlxG.camera.width, FlxG.camera.height);
		camTitle.bgColor = 0x00000000;
		camTitle.angle = FlxG.camera.angle;
		camTitle.scroll.x = FlxG.camera.scroll.x;
		FlxG.cameras.add(camTitle, false);

		camFront = new FlxCamera();
		camFront.bgColor = 0x00000000;
		FlxG.cameras.add(camFront, false);

		FlxG.camera.antialiasing = true;
		camChars.antialiasing = true;
		camTitle.antialiasing = true;
		camFront.antialiasing = true;

		for (idx => i in [-1, 1])
		{
			var shit = new FlxBackdrop(Paths.image('results/rankText/rankScroll' + getRankTrueName()));
			var pad:Float = shit.height * 1.5;
			if (i == 1)
				shit.y = FlxMath.lerp(shit.height, pad, 0.5);
			shit.velocity.x = 0.5 * i;
			shit.spacing.y = pad;
			shit.visible = false;
			add(shit);
			scrollers[idx] = shit;
		}

		var fontLetters:String = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz:1234567890!?,.()-Ññ&\"'+[]/#";

		var diff:String = PlayState.difficulty != null ? PlayState.difficulty.toLowerCase() : 'hard';
		songDifficulty = new FlxSprite(567, -100);
		songDifficulty.loadGraphic(Paths.image('results/diff_' + diff));
		songDifficulty.cameras = [camTitle];
		add(songDifficulty);

		songName = new FlxBitmapText(FlxBitmapFont.fromMonospace(Paths.image('results/tardlingSpritesheet'), fontLetters, FlxPoint.get(49, 62)));
		songName.setPosition(getNameX(), -100);
		songName.letterSpacing = -15;
		songName.antialiasing = true;

		var shownTitle:String = 'Unknown';
		if (title != null)
			shownTitle = title;
		else if (PlayState.SONG != null)
		{
			shownTitle = PlayState.SONG.song;
			var artist:Dynamic = Reflect.field(PlayState.SONG, 'artist');
			if (artist != null)
				shownTitle += ' by ' + artist;
		}
		songName.text = shownTitle;
		songName.cameras = [camTitle];
		add(songName);

		FlxTween.tween(songName, {y: 125}, 0.5, {ease: FlxEase.quartOut, startDelay: 0.9});
		FlxTween.tween(songDifficulty, {y: 125}, 0.5, {ease: FlxEase.quartOut, startDelay: 0.9});

		clearBig = new ClearPercentCounter(800, 300);
		clearBig.cameras = [camFront];
		add(clearBig);
		clearBig.number = 0;
		clearBig.alpha = 0.001;

		var tick = FlxG.sound.load(Paths.sound('scrollMenu'));
		FlxTween.tween(clearBig, {alpha: 1}, 0.4, {
			startDelay: 0.5,
			onComplete: function(_:FlxTween)
			{
				FlxTween.num(0, targetNum - 0.5, 3, {
					ease: FlxEase.quartOut,
					onComplete: function(_:FlxTween)
					{
						clearBig.number = Std.int(Math.max(0, targetNum - 1));
					}
				}, function(num:Float)
				{
					var n:Int = Std.int(Math.max(0, num));
					if (n != clearBig.number)
					{
						clearBig.number = n;
						tick.play(true, 40);
					}
				});
			}
		});

		clearSmall = new ClearPercentCounter(songDifficulty.x + songDifficulty.width + titleGap, 125);
		clearSmall.big = false;
		add(clearSmall);
		clearSmall.number = targetNum;
		clearSmall.alpha = 0.001;
		clearSmall.cameras = [camTitle];

		buildRankSprites();

		var blehh:FlxSkewedSprite = new FlxSkewedSprite(-50, -490);
		blehh.makeGraphic(Std.int(FlxG.width * 1.25), 400, FlxColor.BLACK);
		blehh.skew.y = FlxG.camera.angle;
		blehh.antialiasing = true;
		blehh.cameras = [camFront];
		FlxTween.tween(blehh, {y: -300}, 7 / 24, {ease: FlxEase.quartOut, startDelay: 3 / 24});

		resultsAnim = new FlxSprite(-200, -10);
		resultsAnim.frames = Paths.getSparrowAtlas('results/results');
		resultsAnim.animation.addByPrefix('result', 'results instance 1', 24, false);
		resultsAnim.visible = false;
		new FlxTimer().start(6 / 24, function(_)
		{
			resultsAnim.visible = true;
			resultsAnim.animation.play('result');
		});
		resultsAnim.antialiasing = true;
		resultsAnim.cameras = [camFront];

		soundSystem = new FlxSprite(-15, -190);
		soundSystem.frames = Paths.getSparrowAtlas('results/soundSystem');
		soundSystem.animation.addByPrefix('idle', 'sound system', 24, false);
		soundSystem.visible = false;
		new FlxTimer().start(8 / 24, function(_)
		{
			soundSystem.animation.play('idle');
			soundSystem.visible = true;
		});
		add(soundSystem);
		soundSystem.antialiasing = true;
		soundSystem.cameras = [camFront];

		ratingsPopin = new FlxSprite(-135, 135);
		ratingsPopin.frames = Paths.getSparrowAtlas('results/ratingsPopin');
		ratingsPopin.animation.addByPrefix('idle', 'Categories', 24, false);
		ratingsPopin.visible = false;
		new FlxTimer().start(21 / 24, function(_)
		{
			ratingsPopin.animation.play('idle');
			ratingsPopin.visible = true;
		});
		add(ratingsPopin);
		ratingsPopin.antialiasing = true;
		ratingsPopin.cameras = [camFront];

		scorePopin = new FlxSprite(-180, 515);
		scorePopin.frames = Paths.getSparrowAtlas('results/scorePopin');
		scorePopin.animation.addByPrefix('idle', 'tally score', 24, false);
		scorePopin.visible = false;
		new FlxTimer().start(31 / 24, function(_)
		{
			scorePopin.animation.play('idle');
			scorePopin.visible = true;
		});
		add(scorePopin);
		scorePopin.antialiasing = true;
		scorePopin.cameras = [camFront];

		scoreGroup = new FlxTypedSpriteGroup<ScoreGuy>();
		add(scoreGroup);
		scoreGroup.cameras = [camFront];

		for (i in 0...10)
		{
			var digit = new ScoreGuy(i * 61, 0);
			digit.ID = i;
			digit.setNumber(-1);
			scoreGroup.add(digit);
		}
		scoreGroup.setPosition(69, 605);
		scoreGroup.visible = false;

		new FlxTimer().start(37 / 24, function(_)
		{
			scoreGroup.visible = true;

			var splitScore:Array<String> = Std.string(Std.int(Math.max(0, stats.score))).split('');
			for (i in 0...splitScore.length)
			{
				var index:Int = i + (10 - splitScore.length);
				if (index < 0)
					continue;
				new FlxTimer().start(i / 24, function(_)
				{
					scoreGroup.members[index].shuffle(Std.parseInt(splitScore[i]));
				});
			}
		});

		var intendedNums:Array<Int> = [
			stats.total,
			stats.max,
			stats.sick,
			stats.good,
			stats.bad,
			stats.shit,
			stats.miss
		];
		var tallyData:Array<Array<Int>> = [
			[375, 150, -1],
			[375, 200, -1],
			[230, 277, 0xFF89e59E],
			[210, 331, 0xFF89c9e5],
			[190, 385, 0xFFe6cf8a],
			[220, 439, 0xFFe68c8a],
			[260, 493, 0xFFc68ae6]
		];
		for (index in 0...tallyData.length)
		{
			var d:Array<Int> = tallyData[index];
			var tal = new TallyCounter(d[0], d[1]);
			tal.cameras = [camFront];
			add(tal);
			tal.number = 0;
			tal.color = d[2];
			tal.visible = false;

			new FlxTimer().start((0.3 * index) + 1.20, function(_)
			{
				tal.visible = true;
				FlxTween.num(0, intendedNums[index], 0.5, {ease: FlxEase.quartOut}, function(num:Float)
				{
					tal.number = Std.int(num);
				});
			});
		}

		grahh = new FlxBackdrop(Paths.image('results/rankText/rankText' + getRankTrueName()), FlxAxes.Y, 0, 30);
		add(grahh);
		grahh.antialiasing = true;
		grahh.cameras = [camFront];
		grahh.x = FlxG.width - grahh.width - 5;
		grahh.visible = false;

		add(blehh);
		add(resultsAnim);

		var trackID:String = getRankMusicName();

		if (trackID != 'PERFECT')
		{
			if (StringTools.contains(trackID, '-intro'))
			{
				FlxG.sound.playMusic(Paths.music('results' + trackID), 1, false);
				FlxG.sound.music.onComplete = function()
				{
					FlxG.sound.playMusic(Paths.music('results' + StringTools.replace(trackID, '-intro', '')));
					FlxG.sound.music.onComplete = null;
				};
			}
			else
			{
				FlxG.sound.playMusic(Paths.music('results' + trackID), 1, true);
			}
		}
		else
		{
			FlxG.sound.playMusic(Paths.music('resultsPERFECT'), 0);
		}
	}

	function getRankParams():RankSprite
	{
		switch (rank)
		{
			case 'good':
				return {
					sheet: 'results/results-bf/resultsGOOD/resultBoyfriendGOOD',
					isAtlas: false,
					anim: 'Boyfriend Good Anim',
					loopFrame: 14,
					x: 640,
					y: -200,
					delay: 95 / 24,
					extra: {
						sheet: 'results/results-bf/resultsGOOD/resultGirlfriendGOOD',
						isAtlas: false,
						anim: 'Girlfriend Good Anim',
						loopFrame: 9,
						x: 625,
						y: -325,
						delay: 22 / 24
					}
				};
			case 'great':
				return {
					sheet: 'results/results-bf/resultsGREAT/bf',
					isAtlas: true,
					anim: 'bf jumping ',
					loopFrame: 15,
					x: 643,
					y: -228,
					delay: 95 / 24,
					scale: 0.93,
					extra: {
						sheet: 'results/results-bf/resultsGREAT/gf',
						isAtlas: true,
						anim: 'gf jumping',
						loopFrame: 9,
						x: 543,
						y: -128,
						delay: 6 / 24
					}
				};
			case 'excellent':
				return {
					sheet: 'results/results-bf/resultsEXCELLENT',
					isAtlas: true,
					anim: 'bf results excellent',
					loopFrame: 28,
					x: 556,
					y: -416,
					delay: 97 / 24
				};
			case 'perfect':
				return {
					sheet: 'results/results-bf/resultsPERFECT',
					isAtlas: true,
					anim: 'boyfriend perfect rank',
					loopFrame: 137,
					x: 406,
					y: -327,
					delay: 95 / 24,
					extra: {
						sheet: 'results/results-bf/resultsPERFECT/hearts',
						isAtlas: true,
						anim: 'hearts full anim',
						loopFrame: 43,
						x: 406,
						y: 327,
						delay: 106 / 24,
						front: true
					}
				};
			default:
				return {
					sheet: 'results/results-bf/resultsSHIT',
					isAtlas: true,
					anim: 'LOSS Animation',
					loopFrame: 149,
					x: 630,
					y: -380,
					delay: 95 / 24
				};
		}
	}

	function animLength(a:FlxAnimate):Int
	{
		var anim = a.anim.getByName('anim');
		if (anim != null && anim.numFrames > 0)
			return anim.numFrames;
		var len:Dynamic = Reflect.getProperty(a.anim, 'length');
		return len != null ? Std.int(len) : 0;
	}

	function makeRankSprite(p:RankSprite):FlxSprite
	{
		var spr:FlxSprite;

		if (p.isAtlas)
		{
			var a = new FlxAnimate(p.x, p.y);
			a.frames = FlxAnimateFrames.fromAnimate(StringTools.replace(Paths.image(p.sheet), '.png', ''));
			a.anim.addBySymbol('anim', p.anim, 24, false);
			var len:Int = animLength(a);
			if (len <= p.loopFrame)
				len = p.loopFrame + 1;
			a.anim.addBySymbolIndices('loop', p.anim, [for (i in p.loopFrame...len) i], 24, true);
			spr = a;
		}
		else
		{
			spr = new FlxSprite(p.x, p.y);
			spr.frames = Paths.getSparrowAtlas(p.sheet);
			spr.animation.addByPrefix('anim', p.anim, 24, false);
			spr.animation.play('anim', true);
			spr.animation.addByIndices('loop', p.anim, [for (i in p.loopFrame...spr.animation.numFrames) i], '', 24, true);
		}

		spr.cameras = [camChars];
		spr.antialiasing = true;
		spr.visible = false;
		if (p.scale != null)
			spr.scale.set(p.scale, p.scale);
		return spr;
	}

	function playRank(spr:FlxSprite, name:String):Void
	{
		if (Std.isOfType(spr, FlxAnimate))
			cast(spr, FlxAnimate).anim.play(name, true);
		else
			spr.animation.play(name, true);
	}

	function buildRankSprites():Void
	{
		var p:RankSprite = getRankParams();

		var bf:FlxSprite = makeRankSprite(p);
		debugSpr = bf;
		var xtra:FlxSprite = null;
		if (p.extra != null)
		{
			xtra = makeRankSprite(p.extra);
			if (p.scale != null)
				xtra.scale.set(p.scale, p.scale);
		}

		new FlxTimer().start(p.delay, function(_)
		{
			FlxG.camera.flash(FlxColor.WHITE, 0.1, null, true);
			for (s in scrollers)
				s.visible = true;
			FlxG.sound.play(Paths.sound('confirmMenu'));

			new FlxTimer().start(3 / 24, function(t:FlxTimer)
			{
				if (t.loopsLeft == 0)
				{
					grahh.velocity.y = -80;
				}
				else
				{
					grahh.visible = !grahh.visible;
					var fu:Float = t.loopsLeft % 2 == 0 ? 255 : 0;
					clearSmall.setColorTransform(1, 1, 1, 1, Std.int(fu), Std.int(fu), Std.int(fu));
					clearBig.setColorTransform(1, 1, 1, 1, Std.int(fu), Std.int(fu), Std.int(fu));
				}
			}, 10);

			clearSmall.alpha = 1;
			clearBig.number = clearSmall.number;
			FlxTween.tween(clearBig, {alpha: 0}, 0.4, {startDelay: 1.7});

			bf.visible = true;
			playRank(bf, 'anim');
			new FlxTimer().start(p.loopFrame / 24, function(_)
			{
				playRank(bf, 'loop');

				if (xtra != null)
				{
					new FlxTimer().start(p.extra.delay, function(_)
					{
						xtra.visible = true;
						playRank(xtra, 'anim');
						new FlxTimer().start(p.extra.loopFrame / 24, function(_)
						{
							playRank(xtra, 'loop');
						});
					});
				}
			});

			if (getRankMusicName() == 'PERFECT')
				FlxG.sound.playMusic(Paths.music('resultsPERFECT'), 1, true);
		});

		if (p.extra != null && p.extra.front == true)
		{
			add(bf);
			add(xtra);
		}
		else
		{
			if (xtra != null)
				add(xtra);
			add(bf);
		}
	}

	function resetTitleScroll():Void
	{
		titleWait = 5;
		songDifficulty.setPosition(567, -100);
		songName.setPosition(getNameX(), -100);
		clearSmall.setPosition(songDifficulty.x + songDifficulty.width + titleGap, -100);
		songName.velocity.x = 0;
		songDifficulty.velocity.x = 0;
		FlxTween.tween(clearSmall, {y: 125}, 0.5, {ease: FlxEase.quartOut, startDelay: 0.9});
		FlxTween.tween(songName, {y: 125}, 0.5, {ease: FlxEase.quartOut, startDelay: 0.9});
		FlxTween.tween(songDifficulty, {y: 125}, 0.5, {ease: FlxEase.quartOut, startDelay: 0.9});
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		#if debug
		if (debugSpr != null)
		{
			var speed:Float = (FlxG.keys.pressed.SHIFT ? 600 : 120) * elapsed;
			if (FlxG.keys.pressed.LEFT)
				debugSpr.x -= speed;
			if (FlxG.keys.pressed.RIGHT)
				debugSpr.x += speed;
			if (FlxG.keys.pressed.UP)
				debugSpr.y -= speed;
			if (FlxG.keys.pressed.DOWN)
				debugSpr.y += speed;

			if (FlxG.keys.justReleased.LEFT || FlxG.keys.justReleased.RIGHT || FlxG.keys.justReleased.UP || FlxG.keys.justReleased.DOWN)
				trace('rank=' + rank + ' x=' + Math.round(debugSpr.x) + ' y=' + Math.round(debugSpr.y));
		}
		#end

		if (titleWait > 0)
		{
			titleWait -= elapsed;
		}
		else
		{
			var max:Float = 125;
			songName.velocity.x = FlxMath.bound(songName.velocity.x - elapsed * max, -max, 0);
			songDifficulty.velocity.x = songName.velocity.x;
			clearSmall.x = songDifficulty.x + songDifficulty.width + titleGap;

			if (songName.x - songName.offset.x + songName.width <= 500)
				resetTitleScroll();
		}

		if (canPress && (controls.PAUSE || controls.ACCEPT || controls.BACK))
		{
			canPress = false;

			if (FlxG.sound.music != null)
			{
				FlxTween.tween(FlxG.sound.music, {volume: 0}, 0.8, {
					onComplete: function(_:FlxTween)
					{
						FlxG.sound.music.stop();
					}
				});
				FlxTween.tween(FlxG.sound.music, {pitch: 3}, 0.1, {
					onComplete: function(_:FlxTween)
					{
						FlxTween.tween(FlxG.sound.music, {pitch: 0.5}, 0.4);
					}
				});
			}

			camFront.fade(0xFF000000, 0.2, false, function()
			{
				FlxTransitionableState.skipNextTransIn = true;
				new FlxTimer().start(1, function(_)
				{
					if (FlxG.sound.music != null)
						FlxG.sound.music.pitch = 1;

					fadeInNextState = true;

					if (onExit != null)
						onExit();
					else
						FlxG.switchState(PlayState.isStoryMode ? new StoryMenuState() : new FreeplayState());
				});
			}, true);
		}
	}

	override function destroy()
	{
		if (FlxG.camera != null)
			FlxG.camera.bgColor = 0;
		super.destroy();
	}
}

class TallyCounter extends FlxSprite
{
	public var number:Int = 0;

	public function new(x:Float, y:Float)
	{
		super(x, y);
		frames = Paths.getSparrowAtlas('results/tallieNumber');
		for (i in 0...10)
		{
			var str:String = Std.string(i);
			animation.addByPrefix(str, str + ' small', 0, true);
		}
		animation.play('0', true);
	}

	override public function draw()
	{
		var ogx:Float = x;
		var width:Int = 40;
		var splitStr:Array<String> = Std.string(number).split('');
		splitStr.remove('-');
		var index:Int = 0;
		for (i in splitStr)
		{
			x = ogx + (width * index);
			animation.play(i, true);
			super.draw();
			index += 1;
		}
		x = ogx;
	}
}

class ScoreGuy extends FlxSprite
{
	public var number:Int = -1;

	public function new(x:Float, y:Float)
	{
		super(x, y);
		frames = Paths.getSparrowAtlas('results/score-digital-numbers');
		var names:Array<String> = ['ZERO', 'ONE', 'TWO', 'THREE', 'FOUR', 'FIVE', 'SIX', 'SEVEN', 'EIGHT', 'NINE'];
		for (idx in 0...names.length)
			animation.addByPrefix(Std.string(idx), names[idx] + ' DIGITAL', 24, false);
		animation.addByPrefix('disabled', 'DISABLED', 24, false);
		animation.addByPrefix('gone', 'GONE', 24, false);

		animation.play('gone', true);
	}

	public function shuffle(finalNum:Int = 0):Void
	{
		var finall:Int = finalNum;
		setNumber(-1);
		var duration:Float = 41 / 24;
		var interval:Float = 1 / 24;
		new FlxTimer().start(interval, function(t:FlxTimer)
		{
			var tempDigit:Int = number;
			tempDigit += 1;
			tempDigit %= 10;
			setNumber(tempDigit, false);

			if (t.loops > 0 && t.loopsLeft == 0)
			{
				FlxTween.num(0, finall, 2 + (ID * 0.01), {
					ease: FlxEase.quartOut,
					onComplete: function(_:FlxTween)
					{
						setNumber(finall, true);
					}
				}, function(num:Float)
				{
					setNumber(Std.int(num), false);
				});
			}
		}, Std.int(duration / interval));
	}

	public function setNumber(num:Int = 0, glow:Bool = true):Void
	{
		number = num;
		if (num >= 0)
			animation.play(Std.string(num), true, false, glow ? 0 : 4);
		else
			animation.play(num == -1 ? 'disabled' : 'gone', true);
		centerOffsets(false);
	}
}

class ClearPercentCounter extends FlxSprite
{
	public var number:Int = 0;
	public var big:Bool = true;
	public var graphWidth:Float = 0;

	public function new(x:Float, y:Float)
	{
		super(x, y);
		antialiasing = true;
		frames = Paths.getSparrowAtlas('results/clearPercentText');
		animation.addByPrefix('bg', 'clearPercentText', 0, true);
		animation.addByPrefix('big', 'numbers0', 0, true);
		animation.addByPrefix('small', 'numbers small', 0, true);
		animation.play('bg', true);
	}

	override public function draw()
	{
		var ogx:Float = x;
		var ogy:Float = y;

		if (big)
		{
			animation.play('bg', true);
			super.draw();
		}

		var _width:Int = big ? 80 : 30;
		var splitStr:Array<String> = Std.string(Std.int(Math.max(0, number))).split('');
		var offsex:Int = splitStr.length * _width;
		var offsex2:Int = 160;
		if (!big)
		{
			splitStr.push('10');
			offsex = offsex2 = 0;
		}
		else
		{
			y += 69;
		}

		for (index in 0...splitStr.length)
		{
			var i:String = splitStr[index];
			scale.set(1, 1);
			x = ogx + (_width * index) - offsex + offsex2;
			animation.play(big ? 'big' : 'small', true, false, Std.parseInt(i));
			if (i == '10')
				scale.set(1.25, 1.25);
			updateHitbox();
			super.draw();
		}

		graphWidth = x - ogx + frameWidth;
		setPosition(ogx, ogy);
	}
}
