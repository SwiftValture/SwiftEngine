package;

import Song.SwagSong;
import flixel.FlxG;

typedef BPMChangeEvent =
{
	var stepTime:Int;
	var songTime:Float;
	var bpm:Float;
}

class Conductor
{
	public static var bpm:Float = 100;
	public static var crochet:Float = ((60 / bpm) * 1000);
	public static var stepCrochet:Float = crochet / 4;
	public static var songPosition:Float;
	public static var lastSongPos:Float;
	public static var offset:Float = 0;

	public static var safeFrames:Int = 10;
	public static var safeZoneOffset:Float = (safeFrames / 60) * 1000;

	public static var bpmChangeMap:Array<BPMChangeEvent> = [];

	public function new() {}

	public static var songPositionDelta:Float = 0;
	private static var prevTime:Float = 0;

	public static function getTimeWithDelta():Float
	{
		return songPosition + songPositionDelta;
	}

	public static function getStepTime(time:Float):Float
	{
    	return flixel.math.FlxMath.roundDecimal(time / stepCrochet, 6);
	}

public static var currentStep(get, never):Int;
static function get_currentStep():Int
{
    return Math.floor(getStepTime(getTimeWithDelta()));
}

	public static function mapBPMChanges(song:SwagSong)
	{
		bpmChangeMap = [];

		var curBPM:Float = song.bpm;
		var totalSteps:Int = 0;
		var totalPos:Float = 0;
		for (i in 0...song.notes.length)
		{
			if (song.notes[i].changeBPM && song.notes[i].bpm != curBPM)
			{
				curBPM = song.notes[i].bpm;
				var event:BPMChangeEvent = {
					stepTime: totalSteps,
					songTime: totalPos,
					bpm: curBPM
				};
				bpmChangeMap.push(event);
			}

			var deltaSteps:Int = song.notes[i].lengthInSteps;
			totalSteps += deltaSteps;
			totalPos += ((60 / curBPM) * 1000 / 4) * deltaSteps;
		}
		trace("new BPM map BUDDY " + bpmChangeMap);
	}

	public static function changeBPM(newBpm:Float)
	{
		bpm = newBpm;

		crochet = ((60 / bpm) * 1000);
		stepCrochet = crochet / 4;
	}

	public static function update(elapsed:Float):Void
{
    if (FlxG.sound.music != null && FlxG.sound.music.playing)
    {
        var pitch:Float = FlxG.sound.music.pitch;
        songPositionDelta += elapsed * 1000 * pitch;

        if (prevTime != FlxG.sound.music.time)
        {
            songPosition = FlxG.sound.music.time + offset;
            songPositionDelta = 0;
            prevTime = FlxG.sound.music.time;
        }
    }
    else
    {
        songPositionDelta = 0;
    }
}
}
