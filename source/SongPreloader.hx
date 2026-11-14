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

	public static function start(songs:Array<{name:String, diffs:Array<String>}>):Void
	{
		if (started)
			return;
		started = true;

		var paths:Array<String> = [];

		for (s in songs)
		{
			var variants:Array<String> = [s.name];

			for (d in s.diffs)
			{
				if (d == 'erect' || d == 'nightmare')
					variants.push(s.name + '-erect');
				else if (d == 'unreleased')
					variants.push(s.name + '-unreleased');
			}

			for (v in variants)
			{
				var p:String = Paths.inst(v);
				if (paths.indexOf(p) == -1 && Assets.exists(p))
					paths.push(p);
			}
		}

		total = paths.length;

		#if sys
		Thread.create(function()
		{
			for (p in paths)
			{
				try
				{
					Assets.getSound(p);
				}
				catch (e:Dynamic) {}
				loaded++;
			}
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
