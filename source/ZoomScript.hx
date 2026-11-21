package;

using StringTools;

class ZoomEvent
{
	public var step:Int;

	public var hasZoom:Bool = false;
	public var zoom:Float = 1;
	public var dur:Float = 8;
	public var durIsSec:Bool = false;
	public var ease:String = "expoOut";

	public var hasMod:Bool = false;
	public var interval:Int = 4;
	public var amount:Float = 0.015;
	public var hud:Float = 0.03;

	public var extra:String = "";

	public function new(step:Int)
	{
		this.step = step;
	}

	public var mult(get, set):Float;

	function get_mult():Float
		return ZoomScript.round(amount / 0.015, 4);

	function set_mult(v:Float):Float
	{
		amount = ZoomScript.round(v * 0.015, 6);
		hud = ZoomScript.round(v * 0.03, 6);
		return v;
	}
}

class ZoomScript
{
	public var header:String = "function stepHit(curStep)\n{\n\tswitch (curStep)\n\t{";
	public var footer:String = "}\n}\n";
	public var closeIndent:String = "\t";
	public var caseIndent:String = "\t\t";

	public var events:Array<ZoomEvent> = [];
	public var rawBlocks:Array<String> = [];
	public var valid:Bool = true;

	public function new() {}

	public static function round(v:Float, decimals:Int):Float
	{
		var p:Float = Math.pow(10, decimals);
		return Math.round(v * p) / p;
	}

	static function fmt(v:Float):String
		return Std.string(round(v, 6));

	public static function parse(src:String):ZoomScript
	{
		var z:ZoomScript = new ZoomScript();
		src = src.replace("\r\n", "\n");

		var sw:EReg = ~/switch\s*\(\s*curStep\s*\)\s*\{/;
		if (!sw.match(src))
		{
			z.valid = false;
			return z;
		}

		var mp = sw.matchedPos();
		var openEnd:Int = mp.pos + mp.len;
		var closePos:Int = findClose(src, openEnd);
		if (closePos < 0)
		{
			z.valid = false;
			return z;
		}

		z.header = src.substr(0, openEnd);
		z.footer = src.substr(closePos);

		var body:String = src.substring(openEnd, closePos);

		var nl:Int = body.lastIndexOf("\n");
		if (nl >= 0)
		{
			var tail:String = body.substr(nl + 1);
			if (tail.trim() == "")
			{
				z.closeIndent = tail;
				body = body.substr(0, nl + 1);
			}
		}

		var anyLabel:EReg = ~/^([ \t]*)(case[^\n]*?:|default[ \t]*:)[ \t]*$/m;
		if (!anyLabel.match(body))
			return z;

		z.caseIndent = anyLabel.matched(1);

		var labelRx:EReg = new EReg("^" + z.caseIndent + "(case[^\\n]*?:|default[ \\t]*:)[ \\t]*$", "m");

		var marks:Array<{pos:Int, len:Int, label:String}> = [];
		var off:Int = 0;
		while (off <= body.length && labelRx.matchSub(body, off))
		{
			var p = labelRx.matchedPos();
			marks.push({pos: p.pos, len: p.len, label: labelRx.matched(1)});
			off = p.pos + p.len;
		}

		var stepRx:EReg = ~/^case\s+(\d+)\s*:$/;

		for (i in 0...marks.length)
		{
			var m = marks[i];
			var textStart:Int = m.pos + m.len;
			var textEnd:Int = (i + 1 < marks.length) ? marks[i + 1].pos : body.length;
			var text:String = body.substring(textStart, textEnd);

			if (stepRx.match(m.label))
			{
				var ev:ZoomEvent = parseBlock(Std.parseInt(stepRx.matched(1)), text);
				if (ev != null)
					z.events.push(ev);
			}
			else
				z.rawBlocks.push(rtrim(body.substring(m.pos, textEnd)));
		}

		z.events.sort(function(a, b) return a.step - b.step);
		return z;
	}

	static function parseBlock(step:Int, text:String):ZoomEvent
	{
		var ev:ZoomEvent = new ZoomEvent(step);

		var zoomRx:EReg = ~/(?:FlxTween\.cancelTweensOf\(cameraZoomTarget\)\s*;\s*)?FlxTween\.tween\(cameraZoomTarget,\s*\{\s*zoom:\s*(-?[0-9.]+)\s*\}\s*,\s*(?:Conductor\.stepCrochet\s*\/\s*1000\s*\*\s*(-?[0-9.]+)|(-?[0-9.]+))\s*,\s*\{\s*ease:\s*FlxEase\.(\w+)\s*,\s*onComplete:\s*function\(\s*\w*\s*\)\s*\{\s*setDefaultCamZoom\(\s*-?[0-9.]+\s*\)\s*;\s*\}\s*\}\s*\)\s*;/;

		if (zoomRx.match(text))
		{
			ev.hasZoom = true;
			ev.zoom = Std.parseFloat(zoomRx.matched(1));
			ev.ease = zoomRx.matched(4);

			var inSteps:String = zoomRx.matched(2);
			var inSecs:String = zoomRx.matched(3);

			if (inSteps != null && inSteps != "")
				ev.dur = Std.parseFloat(inSteps);
			else if (ev.ease == "INSTANT")
				ev.dur = 0;
			else
			{
				ev.dur = Std.parseFloat(inSecs);
				ev.durIsSec = true;
			}

			text = zoomRx.matchedLeft() + zoomRx.matchedRight();
		}

		var modRx:EReg = ~/camZoomInterval\(\s*(\d+)\s*,\s*(-?[0-9.]+)\s*,\s*(-?[0-9.]+)\s*\)\s*;/;

		if (modRx.match(text))
		{
			ev.hasMod = true;
			ev.interval = Std.parseInt(modRx.matched(1));
			ev.amount = Std.parseFloat(modRx.matched(2));
			ev.hud = Std.parseFloat(modRx.matched(3));

			text = modRx.matchedLeft() + modRx.matchedRight();
		}

		var infoRx:EReg = ~/^[ \t]*\/\/[ \t]*Camera (?:Movement|Modulo Change)\b[^\n]*$/gm;
		text = infoRx.replace(text, "");

		if (text.trim() != "")
		{
			var lead:EReg = ~/^(?:[ \t]*\n)+/;
			ev.extra = rtrim(lead.replace(text, ""));
		}

		if (!ev.hasZoom && !ev.hasMod && ev.extra == "")
			return null;

		return ev;
	}

	public function write():String
	{
		var sb:StringBuf = new StringBuf();
		sb.add(header);
		sb.add("\n");

		var evs:Array<ZoomEvent> = events.copy();
		evs.sort(function(a, b) return a.step - b.step);

		var chunks:Array<String> = [];
		for (ev in evs)
		{
			var c:String = writeCase(ev);
			if (c != "")
				chunks.push(c);
		}
		for (r in rawBlocks)
			chunks.push(r + "\n");

		if (chunks.length == 0)
			chunks.push(caseIndent + "case -1:\n" + caseIndent + "\t// Camera Movement | (no zoom events)\n");

		sb.add(chunks.join("\n"));
		sb.add(closeIndent);
		sb.add(footer);
		return sb.toString();
	}

	function writeCase(ev:ZoomEvent):String
	{
		if (!ev.hasZoom && !ev.hasMod && ev.extra == "")
			return "";

		var bi:String = caseIndent + "\t";
		var parts:Array<String> = [];

		if (ev.hasMod)
			parts.push(bi + "camZoomInterval(" + ev.interval + ", " + fmt(ev.amount) + ", " + fmt(ev.hud) + ");\n");

		if (ev.hasZoom)
		{
			var durExpr:String;
			if (ev.ease == "INSTANT")
				durExpr = "0.01";
			else if (ev.durIsSec)
				durExpr = fmt(ev.dur);
			else
				durExpr = "Conductor.stepCrochet / 1000 * " + fmt(ev.dur);

			var z:String = fmt(ev.zoom);

			parts.push(bi + "FlxTween.cancelTweensOf(cameraZoomTarget);\n\n" + bi + "FlxTween.tween(cameraZoomTarget, {zoom: " + z + "}, " + durExpr
				+ ", {\n" + bi + "\tease: FlxEase." + ev.ease + ",\n" + bi + "\tonComplete: function(tween)\n" + bi + "\t{\n" + bi + "\t\tsetDefaultCamZoom("
				+ z + ");\n" + bi + "\t}\n" + bi + "});\n");
		}

		if (ev.extra != "")
			parts.push(ev.extra + "\n");

		return caseIndent + "case " + ev.step + ":\n" + parts.join("\n");
	}

	static function rtrim(s:String):String
	{
		var e:Int = s.length;
		while (e > 0 && StringTools.isSpace(s, e - 1))
			e--;
		return s.substr(0, e);
	}

	static function findClose(s:String, from:Int):Int
	{
		var depth:Int = 1;
		var i:Int = from;
		var n:Int = s.length;

		while (i < n)
		{
			var c:String = s.charAt(i);

			if (c == "/" && i + 1 < n && s.charAt(i + 1) == "/")
			{
				while (i < n && s.charAt(i) != "\n")
					i++;
				continue;
			}

			if (c == "/" && i + 1 < n && s.charAt(i + 1) == "*")
			{
				i += 2;
				while (i + 1 < n && !(s.charAt(i) == "*" && s.charAt(i + 1) == "/"))
					i++;
				i += 2;
				continue;
			}

			if (c == "\"" || c == "'")
			{
				var q:String = c;
				i++;
				while (i < n && s.charAt(i) != q)
				{
					if (s.charAt(i) == "\\")
						i++;
					i++;
				}
				i++;
				continue;
			}

			if (c == "{")
				depth++;
			else if (c == "}")
			{
				depth--;
				if (depth == 0)
					return i;
			}

			i++;
		}

		return -1;
	}
}
