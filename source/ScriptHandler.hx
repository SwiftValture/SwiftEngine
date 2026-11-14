package;

import hscript.Interp;
import hscript.Parser;
#if sys
import sys.FileSystem;
import sys.io.File;
#end

using StringTools;

class ScriptHandler
{
	var scripts:Array<{name:String, interp:Interp}> = [];
	var variables:Map<String, Dynamic> = new Map();

	public var count(get, never):Int;

	function get_count():Int
		return scripts.length;

	public function new() {}

	public function set(name:String, value:Dynamic):Void
	{
		variables.set(name, value);

		for (s in scripts)
			s.interp.variables.set(name, value);
	}

	public function load(folder:String):Void
	{
		#if sys
		if (!FileSystem.exists(folder) || !FileSystem.isDirectory(folder))
		{
			trace('Kein Script wurde gefunden: ' + folder);
			return;
		}

		var files = FileSystem.readDirectory(folder);
		files.sort(function(a, b) return a < b ? -1 : (a > b ? 1 : 0));

		for (file in files)
		{
			if (!file.toLowerCase().endsWith('.hx'))
				continue;

			loadFile(folder + '/' + file, file);
		}
		#end
	}

	public function loadFile(path:String, name:String):Bool
	{
		#if sys
		try
		{
			var interp = new Interp();

			for (key in variables.keys())
				interp.variables.set(key, variables.get(key));

			var parser = new Parser();
			var program = parser.parseString(File.getContent(path));

			interp.execute(program);

			scripts.push({name: name, interp: interp});

			trace('script wurde ausgefuehrt: ' + name);
			return true;
		}
		catch (e:Dynamic)
		{
			trace('HScript error in ' + name + ': ' + e);
		}
		#end

		return false;
	}

	public function call(name:String, ?args:Array<Dynamic>):Dynamic
	{
		if (args == null)
			args = [];

		var result:Dynamic = null;

		for (s in scripts)
		{
			var func:Dynamic = s.interp.variables.get(name);

			if (func == null || !Reflect.isFunction(func))
				continue;

			try
			{
				result = Reflect.callMethod(null, func, args);
			}
			catch (e:Dynamic)
			{
				trace('HScript error in ' + s.name + ' (' + name + '): ' + e);
			}
		}

		return result;
	}

	public function destroy():Void
	{
		scripts = [];
		variables = new Map();
	}
}
