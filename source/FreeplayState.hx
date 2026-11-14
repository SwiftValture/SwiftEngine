package;

#if discord_rpc
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.effects.FlxFlicker;
import flixel.util.FlxColor;
import lime.utils.Assets;

using StringTools;

class FreeplayState extends MusicBeatState
{
	var songs:Array<SongMetadata> = [];

	static var curSelected:Int = 0;
	static var curDifficulty:String = 'normal';

	var scoreText:FlxText;
	var diffText:FlxText;
	var lerpScore:Float = 0;
	var intendedScore:Int = 0;
	var playingSong:Bool = false;
	var selectedSomethin:Bool = false;
	var noChartData:FlxSprite;
	var dataText:FlxText;
	var currentPreview:String = '';

	var coolColors:Array<Int> = [
		0xff9271fd,
		0xff9271fd,
		0xff223344,
		0xFF941653,
		0xFFfc96d7,
		0xFFa0d1ff,
		0xffff78bf,
		0xfff6b604
	];

	private var grpSongs:FlxTypedGroup<Alphabet>;
	private var curPlaying:Bool = false;

	private var iconArray:Array<HealthIcon> = [];
	var bg:FlxSprite;
	var bgR:Float = 255;
	var bgG:Float = 255;
	var bgB:Float = 255;
	var scoreBG:FlxSprite;

	override function create()
	{
		persistentUpdate = true;
		persistentDraw = true;

		var isDebug:Bool = false;

		#if debug
		isDebug = true;
		addSong('Test', 1, 'bf-pixel');
		#end

		addSong('miss-me', 2, 'zibidi', ['normal']);

		if (FlxG.sound.music != null)
		{
			if (!FlxG.sound.music.playing)
				FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		addSong('tutorial', 1, 'gf', ['easy', 'normal', 'hard']);

		if (StoryMenuState.weekUnlocked[2] || isDebug)
			addWeek(['Bopeebo', 'Fresh', 'Dadbattle'], 1, ['dad'], ['easy', 'normal', 'hard', 'erect', 'nightmare']);

		if (StoryMenuState.weekUnlocked[2] || isDebug)
		{
			addSong('Spookeez', 2, 'spooky', ['easy', 'normal', 'hard', 'erect', 'nightmare']);
			addSong('South', 2, 'spooky', ['easy', 'normal', 'hard', 'erect', 'nightmare']);
			addSong('Monster', 2, 'monster', ['easy', 'normal', 'hard']);
		}

		if (StoryMenuState.weekUnlocked[3] || isDebug)
			addWeek(['Pico', 'Philly', 'Blammed'], 3, ['pico'], ['easy', 'normal', 'hard', 'erect', 'nightmare']);

		if (StoryMenuState.weekUnlocked[4] || isDebug)
			addWeek(['Satin-Panties', 'High', 'Milf'], 4, ['mom'], ['easy', 'normal', 'hard', 'erect', 'nightmare']);

		if (StoryMenuState.weekUnlocked[5] || isDebug)
			addWeek(['Cocoa', 'Eggnog', 'Winter-Horrorland'], 5, ['parents-christmas', 'parents-christmas', 'monster-christmas'],
				['easy', 'normal', 'hard', 'erect', 'nightmare']);

		if (StoryMenuState.weekUnlocked[6] || isDebug)
			addWeek(['Senpai', 'Roses', 'Thorns'], 6, ['senpai', 'senpai', 'spirit'], ['easy', 'normal', 'hard', 'erect', 'nightmare']);

		if (StoryMenuState.weekUnlocked[7] || isDebug)
		{
			addSong('Ugh', 7, 'tankman', ['easy', 'normal', 'hard', 'erect', 'nightmare', 'unreleased']);
			addSong('Guns', 7, 'tankman', ['easy', 'normal', 'hard', 'erect', 'nightmare']);
			addSong('Stress', 7, 'tankman', ['easy', 'normal', 'hard', 'erect', 'nightmare']);
		}

		addSong('darnell-boyfriend', 8, 'darnell', ['easy', 'normal', 'hard']);

		addSong('lit-up-boyfriend', 8, 'darnell', ['easy', 'normal', 'hard']);

		for (s in ModManager.getFreeplaySongs())
			addSong(s.song, s.week, s.icon, s.diffs);

		bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.antialiasing = true;
		add(bg);

		grpSongs = new FlxTypedGroup<Alphabet>();
		add(grpSongs);

		for (i in 0...songs.length)
		{
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, songs[i].songName, true, false);
			songText.isMenuItem = true;
			songText.targetY = i;
			songText.antialiasing = true;
			grpSongs.add(songText);

			var icon:HealthIcon = new HealthIcon(songs[i].songCharacter);
			icon.sprTracker = songText;

			iconArray.push(icon);
			icon.antialiasing = true;
			add(icon);
		}

		scoreText = new FlxText(FlxG.width * 0.7, 5, 0, "", 32);
		scoreText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, RIGHT);

		scoreBG = new FlxSprite(scoreText.x - 6, 0).makeGraphic(1, 66, 0x99000000);
		scoreBG.antialiasing = false;
		add(scoreBG);

		diffText = new FlxText(scoreText.x, scoreText.y + 36, 0, "", 24);
		diffText.font = scoreText.font;
		add(diffText);

		add(scoreText);

		if (curSelected >= songs.length)
			curSelected = 0;

		changeSelection(0);
		changeDiff(0);

		noChartData = new FlxSprite().loadGraphic(Paths.image('gokgok'));
		noChartData.screenCenter();
		noChartData.scale.set(2, 2);
		noChartData.alpha = 0;
		add(noChartData);

		dataText = new FlxText(0, 10, FlxG.width, "NO CHART DATA", 60);
		dataText.setFormat(Paths.font("vcr.ttf"), 60, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		dataText.screenCenter();
		dataText.alpha = 0;
		add(dataText);

		SongPreloader.start([for (s in songs) {name: s.songName, diffs: s.diffs}]);

		super.create();
	}

	public function addSong(songName:String, weekNum:Int, songCharacter:String, ?diffs:Array<String>)
	{
		songs.push(new SongMetadata(songName, weekNum, songCharacter, diffs));
	}

	public function addWeek(songs:Array<String>, weekNum:Int, ?songCharacters:Array<String>, ?diffs:Array<String>)
	{
		if (songCharacters == null)
			songCharacters = ['bf'];

		var num:Int = 0;
		for (song in songs)
		{
			addSong(song, weekNum, songCharacters[num], diffs);

			if (songCharacters.length != 1)
				num++;
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.sound.music != null)
		{
			if (FlxG.sound.music.volume < 0.7)
			{
				FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
			}
		}

		lerpScore = CoolUtil.fpsLerp(lerpScore, intendedScore, 0.4);
		var target:FlxColor = coolColors[songs[curSelected].week % coolColors.length];
		var f:Float = CoolUtil.getFPSRatio(0.045);

		bgR = FlxMath.lerp(bgR, target.red, f);
		bgG = FlxMath.lerp(bgG, target.green, f);
		bgB = FlxMath.lerp(bgB, target.blue, f);

		bg.color = FlxColor.fromRGB(Math.round(bgR), Math.round(bgG), Math.round(bgB));

		scoreText.text = "PERSONAL BEST:" + Math.round(lerpScore);

		positionHighscore();
		if (!selectedSomethin)
		{
			var upP = controls.UI_UP_P;
			var downP = controls.UI_DOWN_P;
			var accepted = controls.ACCEPT;

			if (upP)
				changeSelection(-1);
			if (downP)
				changeSelection(1);

			if (FlxG.mouse.wheel != 0)
				changeSelection(-FlxG.mouse.wheel);

			if (controls.UI_LEFT_P)
				changeDiff(-1);
			if (controls.UI_RIGHT_P)
				changeDiff(1);

			if (controls.BACK)
			{
				FlxG.sound.play(Paths.sound('cancelMenu'));
				FlxG.switchState(new MainMenuState());
			}

			if (accepted)
			{
				var songName:String = songs[curSelected].songName.toLowerCase();
				var poop:String = songName + CoolUtil.chartSuffix(curDifficulty);

				if (!Assets.exists(Paths.json(songName + '/' + poop)))
				{
					FlxG.sound.play(Paths.sound('cancelMenu'));
					FlxTween.cancelTweensOf(noChartData);
					FlxTween.cancelTweensOf(dataText);

					noChartData.alpha = 1;
					dataText.alpha = 1;

					FlxTween.tween(noChartData, {alpha: 0}, 1.0, {ease: FlxEase.quadInOut});
					FlxTween.tween(dataText, {alpha: 0}, 1.0, {ease: FlxEase.quadInOut});
					return;
				}

				selectedSomethin = true;

				FlxG.sound.play(Paths.sound('confirmMenu'));

				PlayState.SONG = Song.loadFromJson(poop, songName);
				PlayState.isStoryMode = false;
				PlayState.difficulty = curDifficulty;
				PlayState.storyWeek = songs[curSelected].week;

				if (FlxG.sound.music != null)
				{
					FlxG.sound.music.fadeOut(0.9, 0, function(twn:FlxTween)
					{
						FlxG.sound.music.volume = 0;
						FlxG.sound.music.stop();
					});
					FlxFlicker.flicker(grpSongs.members[curSelected], 1.0, 0.06, false, true, function(flicker:FlxFlicker)
					{
						LoadingState.loadAndSwitchState(new PlayState());
					});
					FlxFlicker.flicker(iconArray[curSelected], 1.0, 0.06, false, true);
				}
				else
				{
					FlxFlicker.flicker(grpSongs.members[curSelected], 1.0, 0.06, false, true, function(flicker:FlxFlicker)
					{
						LoadingState.loadAndSwitchState(new PlayState());
					});
					FlxFlicker.flicker(iconArray[curSelected], 1.0, 0.06, false, true);
				}
			}
		}
	}

	function playPreview()
	{
		var songTitle:String = songs[curSelected].songName;

		if (curDifficulty == 'erect' || curDifficulty == 'nightmare')
			songTitle += '-erect';
		else if (curDifficulty == 'unreleased')
			songTitle += '-unreleased';

		if (currentPreview == songTitle)
			return;

		currentPreview = songTitle;

		FlxG.sound.playMusic(Paths.inst(songTitle), 0.7);
		playingSong = true;
	}

	function changeDiff(change:Int = 0)
	{
		var diffs:Array<String> = songs[curSelected].diffs;

		var idx:Int = diffs.indexOf(curDifficulty);
		if (idx == -1)
			idx = Std.int(Math.max(diffs.indexOf('normal'), 0));

		idx = (idx + change + diffs.length) % diffs.length;
		curDifficulty = diffs[idx];

		PlayState.difficulty = curDifficulty;

		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
		#end

		diffText.text = diffs.length > 1 ? "< " + curDifficulty.toUpperCase() + " >" : curDifficulty.toUpperCase();

		positionHighscore();

		playPreview();
	}

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = songs.length - 1;
		if (curSelected >= songs.length)
			curSelected = 0;

		changeDiff(0);

		var bullShit:Int = 0;

		for (i in 0...iconArray.length)
		{
			iconArray[i].alpha = 0.6;
		}

		iconArray[curSelected].alpha = 1;

		for (item in grpSongs.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;

			if (item.targetY == 0)
			{
				item.alpha = 1;
			}
		}

		playPreview();
	}

	function positionHighscore()
	{
		scoreText.x = FlxG.width - scoreText.width - 6;
		scoreBG.scale.x = FlxG.width - scoreText.x + 6;
		scoreBG.x = FlxG.width - scoreBG.scale.x / 2;

		diffText.x = Std.int(scoreBG.x + scoreBG.width / 2);
		diffText.x -= (diffText.width / 2);
	}
}

class SongMetadata
{
	public var songName:String = "";
	public var week:Int = 0;
	public var songCharacter:String = "";
	public var diffs:Array<String>;

	public function new(song:String, week:Int, songCharacter:String, ?diffs:Array<String>)
	{
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
		this.diffs = (diffs != null) ? diffs : CoolUtil.defaultDiffs;
	}
}
