package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxFramesCollection;
import openfl.display.BitmapData;
import openfl.geom.Point;

class SustainStrip
{
	public static var capFraction(default, null):Float = 0.5;

	public static function get(skin:NoteSkin):FlxGraphic
	{
		var key:String = 'sustainStrip-' + skin.name;
		var cached:FlxGraphic = FlxG.bitmap.get(key);
		if (cached != null && cached.bitmap != null)
		{
			capFraction = fractions.get(key);
			return cached;
		}

		var pieces:Array<BitmapData> = [];
		var caps:Array<BitmapData> = [];

		if (skin.pixel)
		{
			var s:FlxSprite = new FlxSprite();
			s.loadGraphic(Paths.image('weeb/pixelUI/arrowEnds'), true, 7, 6);
			for (i in 0...4)
			{
				pieces.push(grabIndex(s, i));
				caps.push(grabIndex(s, 4 + i));
			}
		}
		else
		{
			var frames:FlxFramesCollection = Paths.getSparrowAtlas('NOTE_assets');
			var holdNames:Array<String> = ['purple hold piece', 'blue hold piece', 'green hold piece', 'red hold piece'];
			var endNames:Array<String> = ['pruple end hold', 'blue hold end', 'green hold end', 'red hold end'];
			for (i in 0...4)
			{
				pieces.push(grabPrefix(frames, holdNames[i]));
				caps.push(grabPrefix(frames, endNames[i]));
			}
		}

		for (i in 0...4)
		{
			pieces[i] = trimRows(pieces[i], true, true);
			caps[i] = trimRows(caps[i], true, false);
		}

		var w:Int = 0;
		var pieceH:Int = 1;
		var capH:Int = 1;
		for (i in 0...4)
		{
			w = Std.int(Math.max(w, Math.max(pieces[i].width, caps[i].width)));
			pieceH = Std.int(Math.max(pieceH, pieces[i].height));
			capH = Std.int(Math.max(capH, caps[i].height));
		}

		var tiles:Int = Math.ceil(capH / pieceH);
		var h:Int = pieceH * tiles;

		var bd:BitmapData = new BitmapData(w * 8, h, true, 0x00000000);

		for (i in 0...4)
		{
			var px:Int = (i * 2) * w + Std.int((w - pieces[i].width) / 2);
			for (k in 0...tiles)
				bd.copyPixels(pieces[i], pieces[i].rect, new Point(px, k * pieceH));

			var cx:Int = (i * 2 + 1) * w + Std.int((w - caps[i].width) / 2);
			bd.copyPixels(caps[i], caps[i].rect, new Point(cx, 0));
		}

		var frac:Float = capH / h;
		fractions.set(key, frac);
		capFraction = frac;

		var g:FlxGraphic = FlxG.bitmap.add(bd, false, key);
		g.persist = true;
		g.destroyOnNoUse = false;
		return g;
	}

	static var fractions:Map<String, Float> = new Map();

	static function trimRows(bd:BitmapData, top:Bool, bottom:Bool):BitmapData
	{
		var cx:Int = Std.int(bd.width / 2);
		var y0:Int = 0;
		var y1:Int = bd.height - 1;

		if (top)
			while (y0 < y1 && ((bd.getPixel32(cx, y0) >>> 24) < 250))
				y0++;
		if (bottom)
			while (y1 > y0 && ((bd.getPixel32(cx, y1) >>> 24) < 250))
				y1--;

		if (y0 == 0 && y1 == bd.height - 1)
			return bd;

		var out:BitmapData = new BitmapData(bd.width, y1 - y0 + 1, true, 0x00000000);
		out.copyPixels(bd, new openfl.geom.Rectangle(0, y0, bd.width, y1 - y0 + 1), new Point(0, 0));
		return out;
	}

	static function grabPrefix(frames:FlxFramesCollection, prefix:String):BitmapData
	{
		var s:FlxSprite = new FlxSprite();
		s.frames = frames;
		s.animation.addByPrefix('a', prefix, 24, false);
		s.animation.play('a');
		s.updateFramePixels();
		return s.framePixels.clone();
	}

	static function grabIndex(s:FlxSprite, index:Int):BitmapData
	{
		s.animation.add('f' + index, [index], 1, false);
		s.animation.play('f' + index);
		s.updateFramePixels();
		return s.framePixels.clone();
	}

	// had to take a biiiiiiiiiiiiiiiiiiiiiig look at vslice's soure code for this one
	// well i usually look at vslices source code if i dont know something(almost always), but i dont copy 1 to 1, but i rewrite it as well as i can and understand
}
