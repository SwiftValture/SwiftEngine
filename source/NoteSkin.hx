package;

import haxe.Json;
import openfl.utils.Assets;

using StringTools;

class NoteSkin
{
	public static var current:NoteSkin = new NoteSkin();

	public var name:String = 'default';
	public var image:String = 'NOTE_assets';
	public var holdImage:String = 'weeb/pixelUI/arrowEnds';
	public var pixel:Bool = false;
	public var scale:Float = 0.7;
	public var antialiasing:Bool = true;

	public function new() {}

	public static function select(song:String, stage:String):Void
	{
		var name:String = fromSongMap(song.toLowerCase());
		if (name == null)
			name = stage.startsWith('school') ? 'pixel' : 'default';
		set(name);
	}

	public static function set(name:String):Void
	{
		if (current.name == name)
			return;
		current = load(name);
	}

	static function load(name:String):NoteSkin
	{
		var s:NoteSkin = new NoteSkin();
		s.name = name;

		if (name == 'default')
			return s;

		if (name == 'pixel')
		{
			s.image = 'weeb/pixelUI/arrows-pixels';
			s.pixel = true;
			s.scale = PlayState.daPixelZoom;
			s.antialiasing = false;
			return s;
		}

		var raw:String = readText('data/noteskins/' + name + '.json');
		if (raw == null)
		{
			trace('NoteSkin "$name" nicht gefunden, nehme default');
			s.name = 'default';
			return s;
		}

		var d:Dynamic = Json.parse(raw);
		if (d.image != null)
			s.image = d.image;
		if (d.holdImage != null)
			s.holdImage = d.holdImage;
		if (d.pixel != null)
			s.pixel = d.pixel;
		s.scale = (d.scale != null) ? d.scale : (s.pixel ? PlayState.daPixelZoom : 0.7);
		s.antialiasing = (d.antialiasing != null) ? d.antialiasing : !s.pixel;
		return s;
	}

	static function fromSongMap(song:String):Null<String>
	{
		var result:Null<String> = null;
		var rel:String = 'data/noteskins/songs.json';

		var base:Null<String> = Assets.exists('assets/' + rel) ? Assets.getText('assets/' + rel) : null;
		if (base != null)
			result = lookup(base, song, result);

		#if sys
		for (txt in ModManager.readAll(rel))
			result = lookup(txt, song, result);
		#end

		return result;
	}

	static function lookup(raw:String, song:String, fallback:Null<String>):Null<String>
	{
		try
		{
			var v:Dynamic = Reflect.field(Json.parse(raw), song);
			return (v != null) ? Std.string(v) : fallback;
		}
		catch (e:Dynamic)
		{
			trace('noteskins/songs.json Fehler: ' + e);
			return fallback;
		}
	}

	static function readText(rel:String):Null<String>
	{
		#if sys
		var modId:Null<String> = ModManager.find(rel);
		if (modId != null)
			return Assets.getText(modId);
		#end

		var p:String = 'assets/' + rel;
		return Assets.exists(p) ? Assets.getText(p) : null;
	}
}
