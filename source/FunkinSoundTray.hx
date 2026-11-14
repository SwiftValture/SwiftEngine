package;

import flixel.FlxG;
import flixel.system.ui.FlxSoundTray;
import openfl.Assets;
import openfl.display.Bitmap;

class FunkinSoundTray extends FlxSoundTray
{
	public static var canShow:Bool = true;

	var graphicScale:Float = 0.30;
	var lerpYPos:Float = 0;
	var alphaTarget:Float = 0;
	var startupChecked:Bool = false;
	var startupDelay:Float = 0.5;

	static inline function loadBmp(name:String):Bitmap
	{
		return new Bitmap(Assets.getBitmapData('assets/images/soundtray/$name.png'));
	}

	public function new()
	{
		super();
		removeChildren();

		var bg = loadBmp('volumebox');
		bg.scaleX = bg.scaleY = graphicScale;
		bg.smoothing = true;
		addChild(bg);

		var backingBar = loadBmp('bars_10');
		backingBar.x = 9;
		backingBar.y = 5;
		backingBar.scaleX = backingBar.scaleY = graphicScale;
		backingBar.smoothing = true;
		backingBar.alpha = 0.4;
		addChild(backingBar);

		_bars = [];
		for (i in 1...11)
		{
			var bar = loadBmp('bars_$i');
			bar.x = 9;
			bar.y = 5;
			bar.scaleX = bar.scaleY = graphicScale;
			bar.smoothing = true;
			addChild(bar);
			_bars.push(bar);
		}

		y = -height;
		visible = false;
		active = true;
		screenCenter();
	}

	static inline function fpsLerp(a:Float, b:Float, ratio:Float, elapsed:Float):Float
	{
		return a + (b - a) * (1 - Math.exp(-ratio * 60 * elapsed));
	}

	override public function update(MS:Float):Void
	{
		var elapsed = Math.min(MS / 1000, 1 / 30);

		if (!startupChecked)
		{
			startupDelay -= elapsed;
			if (startupDelay > 0)
				return;

			startupChecked = true;
			if (canShow && isSilent())
			{
				y = -height;
				alpha = 0;
				visible = true;
				lerpYPos = 10;
				alphaTarget = 1;
				_timer = 1;
				updateBars();
			}
		}

		y = fpsLerp(y, lerpYPos, 0.1, elapsed);
		alpha = fpsLerp(alpha, alphaTarget, 0.25, elapsed);

		if (isSilent() && visible && canShow)
		{
			_timer = 1;
			lerpYPos = 10;
			alphaTarget = 1;
		}
		else if (_timer > 0)
		{
			_timer -= elapsed;
			alphaTarget = 1;
		}
		else if (y >= -height)
		{
			lerpYPos = -height - 10;
			alphaTarget = 0;
		}

		if (y <= -height)
		{
			visible = false;
			active = false;
			flushVolumeSettings();
		}
	}

	override public function show(up:Bool = false):Void
	{
		showFunkinBar(up);
	}

	function showFunkinBar(up:Bool = false)
	{
		if (!canShow)
			return;

		_timer = 1;
		lerpYPos = 10;
		visible = true;
		active = true;

		var globalVolume:Int = Math.round(FlxG.sound.volume * 10);
		if (FlxG.sound.muted)
			globalVolume = 0;

		if (!silent)
		{
			var name = up ? 'menu/Volup' : 'menu/Voldown';
			if (globalVolume == 10)
				name = 'menu/VolMAX';
			FlxG.sound.play(Paths.sound(name));
		}

		for (i in 0..._bars.length)
			_bars[i].visible = i < globalVolume;

		saveVolume();
	}

	inline function isSilent():Bool
	{
		return FlxG.sound.muted || Math.round(FlxG.sound.volume * 10) <= 0;
	}

	function updateBars():Void
	{
		var globalVolume:Int = Math.round(FlxG.sound.volume * 10);
		if (FlxG.sound.muted)
			globalVolume = 0;

		for (i in 0..._bars.length)
			_bars[i].visible = i < globalVolume;
	}

	static function saveVolume()
	{
		#if FLX_SAVE
		if (FlxG.save.isBound)
		{
			FlxG.save.data.mute = FlxG.sound.muted;
			FlxG.save.data.volume = FlxG.sound.volume;
		}
		#end
	}

	public static function flushVolumeSettings()
	{
		#if FLX_SAVE
		if (FlxG.save.isBound)
		{
			saveVolume();
			FlxG.save.flush();
		}
		#end
	}
}
