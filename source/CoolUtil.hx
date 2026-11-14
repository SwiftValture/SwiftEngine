package;

import flixel.FlxG;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxAssets.FlxGraphicAsset;
import haxe.Json;
import lime.math.Rectangle;
import lime.utils.Assets;

using StringTools;

class CoolUtil
{
	public static var defaultDiffs:Array<String> = ['easy', 'normal', 'hard'];

	public static function difficultyString():String
	{
		return PlayState.difficulty.toUpperCase();
	}

	public static function chartSuffix(diff:String):String
	{
		return (diff == 'normal') ? '' : '-' + diff;
	}

	public static function coolTextFile(path:String):Array<String>
	{
		var daList:Array<String> = Assets.getText(path).trim().split('\n');

		for (i in 0...daList.length)
		{
			daList[i] = daList[i].trim();
		}

		return daList;
	}

	public static function numberArray(max:Int, ?min = 0):Array<Int>
	{
		var dumbArray:Array<Int> = [];
		for (i in min...max)
		{
			dumbArray.push(i);
		}
		return dumbArray;
	}

	public static inline function bound(Value:Float, Min:Float, Max:Float):Float
	{
		#if cpp
		var _hx_tmp1:Float = Value;
		var _hx_tmp2:Float = Min;
		var _hx_tmp3:Float = Max;
		return untyped __cpp__("((({0}) < ({1})) ? ({1}) : (({0}) > ({2})) ? ({2}) : ({0}))", _hx_tmp1, _hx_tmp2, _hx_tmp3);
		#else
		return (Value < Min) ? Min : (Value > Max) ? Max : Value;
		#end
	}

	public static function camLerpShit(lerp:Float):Float
	{
		return lerp * (FlxG.elapsed / (1 / 60));
	}

	public static function coolLerp(a:Float, b:Float, ratio:Float):Float
	{
		return FlxMath.lerp(a, b, camLerpShit(ratio));
	}

	public static inline function getFPSRatio(ratio:Float, ?delta:Float):Float
	{
		return 1.0 - Math.pow(1.0 - ratio, (delta == null ? FlxG.elapsed : delta) * 60);
	}

	public static inline function fpsLerp(a:Float, b:Float, ratio:Float):Float
	{
		return FlxMath.lerp(a, b, getFPSRatio(ratio));
	}
}
