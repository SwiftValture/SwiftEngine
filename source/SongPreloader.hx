package;

import flixel.FlxG;
import openfl.utils.Assets;
#if sys
import sys.thread.Thread;
#end

class SongPreloader
{
	public static var started:Bool = false;
	public static var loaded:Int = 0;
	public static var total:Int = 0;

	public static function startAll():Void
	{
		if (started)
			return;
		started = true;

		var paths:Array<String> = [];

		for (id in Assets.list())
		{
			var parts:Array<String> = id.split('/');
			if (parts.length < 3)
				continue;

			var file:String = parts[parts.length - 1].toLowerCase();
			if (!StringTools.startsWith(file, 'inst') || parts[parts.length - 3] != 'songs')
				continue;

			var name:String = parts[parts.length - 2];
			var p:String = Paths.inst(name);

			if (paths.indexOf(p) == -1 && Assets.exists(p))
				paths.push(p);
		}

		total = paths.length;
		trace('SongPreloader: ' + total + ' Insts gefunden');
		for (p in paths)
			trace('  ' + p);

		#if sys
		Thread.create(function()
		{
			for (p in paths)
			{
				try
				{
					var snd = Assets.getSound(p);
					trace('geladen: ' + p + ' -> ' + (snd != null));
				}
				catch (e:Dynamic)
				{
					trace('FEHLER bei ' + p + ': ' + e);
				}
				loaded++;
			}
			trace('SongPreloader fertig');
		});
		#else
		for (p in paths)
		{
			FlxG.sound.cache(p);
			loaded++;
		}
		#end
	}
}
