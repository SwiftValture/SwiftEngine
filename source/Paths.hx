package;

import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;
import openfl.utils.AssetType;
import openfl.utils.Assets as OpenFlAssets;

class Paths
{
	inline public static var SOUND_EXT = #if web "mp3" #else "ogg" #end;

	static var currentLevel:String;

	static public function setCurrentLevel(name:String)
	{
		currentLevel = name.toLowerCase();
	}

	static function getPath(file:String, type:AssetType, library:Null<String>)
	{
		var mod = ModManager.find(file);
		if (mod != null)
			return mod;

		if (library != null)
			return getLibraryPath(file, library);

		if (currentLevel != null)
		{
			var levelPath = getLibraryPathForce(file, currentLevel);
			if (OpenFlAssets.exists(levelPath, type))
				return levelPath;

			levelPath = getLibraryPathForce(file, "shared");
			if (OpenFlAssets.exists(levelPath, type))
				return levelPath;
		}

		return getPreloadPath(file);
	}

	static public function getLibraryPath(file:String, library = "preload")
	{
		return if (library == "preload" || library == "default") getPreloadPath(file); else getLibraryPathForce(file, library);
	}

	inline static function getLibraryPathForce(file:String, library:String)
	{
		return '$library:assets/$library/$file';
	}

	inline static function getPreloadPath(file:String)
	{
		return 'assets/$file';
	}

	inline static public function file(file:String, type:AssetType = TEXT, ?library:String)
	{
		return getPath(file, type, library);
	}

	inline static public function txt(key:String, ?library:String)
	{
		return getPath('data/songs/$key.txt', TEXT, library);
	}

	inline static public function xml(key:String, ?library:String)
	{
		return getPath('data/$key.xml', TEXT, library);
	}

	inline static public function json(key:String, ?library:String)
	{
		return getPath('data/songs/$key.json', TEXT, library);
	}

	inline static public function frag(key:String, ?library:String)
	{
		return getPath('shaders/$key.frag', TEXT, library);
	}

	static public function sound(key:String, ?library:String)
	{
		return getPath('sounds/$key.$SOUND_EXT', SOUND, library);
	}

	inline static public function soundRandom(key:String, min:Int, max:Int, ?library:String)
	{
		return sound(key + FlxG.random.int(min, max), library);
	}

	inline static public function music(key:String, ?library:String)
	{
		return getPath('music/$key.$SOUND_EXT', MUSIC, library);
	}

	inline static public function voices(song:String, suffix:String = '')
	{
		var rel = 'songs/${song.toLowerCase()}/Voices${suffix}.$SOUND_EXT';
		var mod = ModManager.find(rel);
		return mod != null ? mod : 'songs:assets/' + rel;
	}

	static public function useSplitVocals(song:String, diff:String):Bool
	{
		var d:String = diff.toLowerCase();

		var hasSplit:Bool = OpenFlAssets.exists(voices(song, '-opponent')) || OpenFlAssets.exists(voices(song, '-player'));
		var hasPlain:Bool = OpenFlAssets.exists(voices(song));

		return hasSplit && (!hasPlain || d == 'erect' || d == 'nightmare');
	}

	inline static public function inst(song:String)
	{
		var rel = 'songs/${song.toLowerCase()}/Inst.$SOUND_EXT';
		var mod = ModManager.find(rel);
		return mod != null ? mod : 'songs:assets/' + rel;
	}

	static public function voicesFiles(song:String):Array<String>
	{
		var found:Array<String> = [];
		for (suffix in ['-opponent', '-player', ''])
		{
			var path = voices(song, suffix);
			if (OpenFlAssets.exists(path))
				found.push(path);
		}
		return found;
	}

	inline static public function image(key:String, ?library:String)
	{
		return getPath('images/$key.png', IMAGE, library);
	}

	inline static public function getAnimateAtlas(key:String, ?library:String)
	{
		return getPath('images/$key', TEXT, library);
	}

	inline static public function font(key:String)
	{
		return 'assets/fonts/$key';
	}

	inline static public function getSparrowAtlas(key:String, ?library:String)
	{
		return FlxAtlasFrames.fromSparrow(image(key, library), file('images/$key.xml', library));
	}

	static public function getMultiAtlas(keys:Array<String>, ?library:String):FlxAtlasFrames
	{
		if (keys == null || keys.length == 0)
			return null;

		var first:FlxAtlasFrames = getSparrowAtlas(StringTools.trim(keys[0]), library);
		if (first == null || keys.length == 1)
			return first;

		var combined:FlxAtlasFrames = new FlxAtlasFrames(first.parent);
		combined.addAtlas(first, true);

		for (i in 1...keys.length)
		{
			var extra:FlxAtlasFrames = getSparrowAtlas(StringTools.trim(keys[i]), library);
			if (extra != null)
				combined.addAtlas(extra, true);
			else
			{
				var k = StringTools.trim(keys[i]);
				var png = image(k, library);
				var xml = file('images/$k.xml', library);
				trace('MultiAtlas "$k" fehlt | png=$png exists=${OpenFlAssets.exists(png, IMAGE)} | xml=$xml exists=${OpenFlAssets.exists(xml, TEXT)}');
			}
		}
		return combined;
	}

	static public function getAtlas(key:String, ?library:String):FlxAtlasFrames
	{
		return key.indexOf(",") == -1 ? getSparrowAtlas(key, library) : getMultiAtlas(key.split(","), library);
	}

	inline static public function getPackerAtlas(key:String, ?library:String)
	{
		return FlxAtlasFrames.fromSpriteSheetPacker(image(key, library), file('images/$key.txt', library));
	}
}
