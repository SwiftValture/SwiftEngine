package;

import flixel.system.ui.FlxSoundTray;
import openfl.display.Bitmap;
import openfl.Assets;

class CustomSoundTray extends FlxSoundTray
{
	var trueY:Float = 0;
	var lerpYPos:Float = 0;
	var alphaTarget:Float = 0;

	override public function new()
	{
		super();

		volumeDownSound = Paths.sound('menu/Voldown');
		volumeUpSound = Paths.sound('menu/Volup');
	}

	override public function show(up:Bool = false):Void
	{
		super.show(up);

		y = trueY;
		lerpYPos = 10;
		alphaTarget = 1;
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		trueY = CoolUtil.fpsLerp(trueY, lerpYPos, 0.1);
		y = trueY;
		alpha = CoolUtil.fpsLerp(alpha, alphaTarget, 0.25);

		if (_timer > 0)
		{
			alphaTarget = 1;
		}
		else if (y >= -height)
		{
			lerpYPos = -height - 10;
			alphaTarget = 0;
		}
	}
}
