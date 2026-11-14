package;

import haxe.Json;
#if sys
import lime.app.Future;
import lime.graphics.Image;
import lime.media.AudioBuffer;
import lime.text.Font;
import lime.utils.AssetLibrary;
import lime.utils.Assets as LimeAssets;
import lime.utils.Bytes;
import sys.FileSystem;
import sys.io.File;
#end

using StringTools;

typedef ModSong =
{
	var song:String;
	var icon:String;
	var week:Int;
	var diffs:Array<String>;
}

class ModManager
{
	public static inline var MODS_DIR:String = 'mods';
	public static inline var LIBRARY:String = 'mods';

	public static var active:Array<String> = [];

	static var cache:Map<String, String> = new Map();

	public static function init():Void
	{
		#if sys
		LimeAssets.registerLibrary(LIBRARY, new ModLibrary());
		reload();
		#end
	}

	public static function listInstalled():Array<String>
	{
		var result:Array<String> = [];
		#if sys
		if (FileSystem.exists(MODS_DIR) && FileSystem.isDirectory(MODS_DIR))
		{
			for (n in FileSystem.readDirectory(MODS_DIR))
				if (!n.startsWith('.') && FileSystem.isDirectory(MODS_DIR + '/' + n))
					result.push(n);
		}
		result.sort(function(a, b) return a < b ? -1 : (a > b ? 1 : 0));
		#end
		return result;
	}

	public static function reload():Void
	{
		active = [];
		cache = new Map();

		#if sys
		var installed = listInstalled();
		var listPath = MODS_DIR + '/modlist.txt';

		if (FileSystem.exists(listPath))
		{
			for (line in File.getContent(listPath).split('\n'))
			{
				var n = line.trim();
				if (n != '' && !n.startsWith('#') && installed.indexOf(n) != -1 && active.indexOf(n) == -1)
					active.push(n);
			}
		}
		else
			active = installed;

		trace('Mods aktiv: ' + active);
		#end
	}

	public static function find(rel:String):Null<String>
	{
		#if sys
		if (active.length == 0)
			return null;

		var c = cache.get(rel);
		if (c != null)
			return c == '' ? null : c;

		var i = active.length;
		while (i-- > 0)
		{
			if (FileSystem.exists(MODS_DIR + '/' + active[i] + '/' + rel))
			{
				var id = LIBRARY + ':' + active[i] + '/' + rel;
				cache.set(rel, id);
				return id;
			}
		}

		cache.set(rel, '');
		#end
		return null;
	}

	public static function dirs(rel:String):Array<String>
	{
		var result:Array<String> = ['assets/' + rel];
		#if sys
		for (m in active)
		{
			var d = MODS_DIR + '/' + m + '/' + rel;
			if (FileSystem.exists(d) && FileSystem.isDirectory(d))
				result.push(d);
		}
		#end
		return result;
	}

	public static function readAll(rel:String):Array<String>
	{
		var result:Array<String> = [];
		#if sys
		for (m in active)
		{
			var p = MODS_DIR + '/' + m + '/' + rel;
			if (FileSystem.exists(p))
				result.push(File.getContent(p));
		}
		#end
		return result;
	}

	public static function getFreeplaySongs():Array<ModSong>
	{
		var result:Array<ModSong> = [];

		for (txt in readAll('data/freeplay.json'))
		{
			try
			{
				var arr:Array<Dynamic> = Json.parse(txt);
				for (e in arr)
				{
					if (e.song == null)
						continue;

					result.push({
						song: e.song,
						icon: e.icon != null ? e.icon : 'bf',
						week: e.week != null ? e.week : 1,
						diffs: e.diffs != null ? e.diffs : CoolUtil.defaultDiffs
					});
				}
			}
			catch (e:Dynamic)
			{
				trace('freeplay.json Fehler: ' + e);
			}
		}

		return result;
	}
}

#if sys
class ModLibrary extends AssetLibrary
{
	public function new()
	{
		super();
	}

	inline function disk(id:String):String
		return ModManager.MODS_DIR + '/' + id;

	override public function exists(id:String, type:String):Bool
		return FileSystem.exists(disk(id)) && !FileSystem.isDirectory(disk(id));

	override public function isLocal(id:String, type:String):Bool
		return true;

	override public function getPath(id:String):String
		return disk(id);

	override public function getText(id:String):String
		return File.getContent(disk(id));

	override public function getBytes(id:String):Bytes
		return Bytes.fromFile(disk(id));

	override public function getImage(id:String):Image
		return Image.fromFile(disk(id));

	override public function getAudioBuffer(id:String):AudioBuffer
		return AudioBuffer.fromFile(disk(id));

	override public function getFont(id:String):Font
		return Font.fromFile(disk(id));

	override public function loadText(id:String):Future<String>
		return Future.withValue(getText(id));

	override public function loadBytes(id:String):Future<Bytes>
		return Future.withValue(getBytes(id));

	override public function loadImage(id:String):Future<Image>
		return Future.withValue(getImage(id));

	override public function loadAudioBuffer(id:String):Future<AudioBuffer>
		return Future.withValue(getAudioBuffer(id));

	override public function loadFont(id:String):Future<Font>
		return Future.withValue(getFont(id));

	override public function list(type:String):Array<String>
	{
		var result:Array<String> = [];

		for (m in ModManager.active)
			walk(m, '', result);

		return result;
	}

	function walk(mod:String, sub:String, out:Array<String>):Void
	{
		var dir = ModManager.MODS_DIR + '/' + mod + (sub == '' ? '' : '/' + sub);

		for (n in FileSystem.readDirectory(dir))
		{
			var rel = sub == '' ? n : sub + '/' + n;

			if (FileSystem.isDirectory(ModManager.MODS_DIR + '/' + mod + '/' + rel))
				walk(mod, rel, out);
			else
				out.push(mod + '/' + rel);
		}
	}
}
#end
