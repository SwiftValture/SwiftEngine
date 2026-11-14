package;

import Section.SwagSection;
import haxe.Json;
import haxe.format.JsonParser;
import lime.utils.Assets;

using StringTools;

typedef SwagSong =
{
	var song:String;
	var notes:Array<SwagSection>;
	var bpm:Float;
	var needsVoices:Bool;
	var speed:Float;

	var player1:String;
	var player2:String;
	var validScore:Bool;

	@:optional var cameraEvents:Array<CamEvent>;
}

typedef CamEvent =
{
	var time:Float;
	var target:Int;

	@:optional var ease:String;

	@:optional var duration:Null<Float>;

	@:optional var x:Null<Float>;

	@:optional var y:Null<Float>;
}

class Song
{
	public var song:String; // hi
	public var notes:Array<SwagSection>;
	public var bpm:Float;
	public var needsVoices:Bool = true;
	public var speed:Float = 1;

	public var player1:String = 'bf';
	public var player2:String = 'dad';

	public function new(song, notes, bpm)
	{
		this.song = song;
		this.notes = notes;
		this.bpm = bpm;
	}

	public static function loadFromJson(jsonInput:String, ?folder:String):SwagSong
	{
		var rawJson = Assets.getText(Paths.json(folder.toLowerCase() + '/' + jsonInput.toLowerCase())).trim();

		while (!rawJson.endsWith("}"))
		{
			rawJson = rawJson.substr(0, rawJson.length - 1);
		}

		return parseJSONshit(rawJson);
	}

	public static function parseJSONshit(rawJson:String):SwagSong
	{
		var swagShit:SwagSong = cast Json.parse(rawJson).song;
		swagShit.validScore = true;
		migrateCameraEvents(swagShit);
		return swagShit;
	}

	public static inline var CAM_CLASSIC:String = "CLASSIC";
	public static inline var CAM_INSTANT:String = "INSTANT";

	public static function camIsTween(ev:CamEvent):Bool
	{
		return ev.ease != null && ev.ease != "" && ev.ease.toUpperCase() != CAM_CLASSIC;
	}

	public static function camDuration(ev:CamEvent):Float
	{
		return (ev.duration == null) ? 4 : ev.duration;
	}

	public static function migrateCameraEvents(song:SwagSong):Void
	{
		if (song.cameraEvents != null && song.cameraEvents.length > 0)
			return;

		song.cameraEvents = [];

		if (song.notes == null)
			return;

		var t:Float = 0;
		var bpm:Float = song.bpm;
		var last:Int = -1;

		for (sec in song.notes)
		{
			if (sec.changeBPM && sec.bpm > 0)
				bpm = sec.bpm;

			var target:Int = sec.mustHitSection ? 1 : 0;
			if (target != last)
			{
				song.cameraEvents.push({time: t, target: target});
				last = target;
			}

			t += sec.lengthInSteps * (15000 / bpm);
		}
	}
}
