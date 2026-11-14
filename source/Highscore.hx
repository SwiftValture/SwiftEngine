package;

import flixel.FlxG;

class Highscore
{
	#if (haxe >= "4.0.0")
	public static var songScores:Map<String, Int> = new Map();
	#else
	public static var songScores:Map<String, Int> = new Map<String, Int>();
	#end

	public static function saveScore(song:String, score:Int = 0, ?diff:String = 'normal'):Void
	{
		var formattedSong:String = formatSong(song, diff);

		#if newgrounds
		NGio.postScore(score, song);
		#end

		if (songScores.exists(formattedSong))
		{
			if (songScores.get(formattedSong) < score)
				setScore(formattedSong, score);
		}
		else
			setScore(formattedSong, score);
	}

	public static function saveWeekScore(week:Int = 1, score:Int = 0, ?diff:String = 'normal'):Void
	{
		#if newgrounds
		NGio.postScore(score, "Week " + week);
		#end

		var formattedSong:String = formatSong('week' + week, diff);

		if (songScores.exists(formattedSong))
		{
			if (songScores.get(formattedSong) < score)
				setScore(formattedSong, score);
		}
		else
			setScore(formattedSong, score);
	}

	/**
	 * YOU SHOULD FORMAT SONG WITH formatSong() BEFORE TOSSING IN SONG VARIABLE
	 */
	static function setScore(formattedSong:String, score:Int):Void
	{
		#if !switch
		songScores.set(formattedSong, score);
		FlxG.save.data.songScores = songScores;
		FlxG.save.flush();
		#end
	}

	public static function formatSong(song:String, diff:String):String
	{
		return song + CoolUtil.chartSuffix(diff);
	}

	public static function getScore(song:String, diff:String):Int
	{
		if (!songScores.exists(formatSong(song, diff)))
			setScore(formatSong(song, diff), 0);

		return songScores.get(formatSong(song, diff));
	}

	public static function getWeekScore(week:Int, diff:String):Int
	{
		if (!songScores.exists(formatSong('week' + week, diff)))
			setScore(formatSong('week' + week, diff), 0);

		return songScores.get(formatSong('week' + week, diff));
	}

	public static function load():Void
	{
		if (FlxG.save.data.songScores != null)
		{
			songScores = FlxG.save.data.songScores;
		}
	}
}
