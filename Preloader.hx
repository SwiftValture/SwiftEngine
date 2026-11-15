package;

import flixel.system.FlxBasePreloader;
import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.Lib;

@:bitmap("art/preloaderArt.png")
class LogoImage extends BitmapData {}

class Preloader extends FlxBasePreloader
{
	public function new(MinDisplayTime:Float = 3, ?AllowedURLs:Array<String>)
	{
		super(MinDisplayTime, AllowedURLs);
	}

	var logo:Sprite;

	var startScale:Float = 1;
	var startX:Float = 0;
	var startY:Float = 0;

	var lastTime:Float = 0;

	override function create():Void
	{
		this._width = Lib.current.stage.stageWidth;
		this._height = Lib.current.stage.stageHeight;

		var ratio:Float = this._width / 2560;

		logo = new Sprite();
		logo.addChild(new Bitmap(new LogoImage(0, 0)));

		logo.scaleX = logo.scaleY = ratio;

		logo.x = (this._width / 2) - (logo.width / 2);
		logo.y = (this._height / 2) - (logo.height / 2);

		addChild(logo);

		startScale = ratio;
		startX = logo.x;
		startY = logo.y;

		lastTime = Lib.getTimer();

		super.create();
	}

	override function update(Percent:Float):Void
	{
		var currentTime:Float = Lib.getTimer();

		var elapsed:Float = (currentTime - lastTime) / 1000;
		lastTime = currentTime;

		var delta:Float = elapsed * 60;

		if (Percent < 69)
		{
			logo.scaleX += (Percent / 1920) * delta;
			logo.scaleY += (Percent / 1920) * delta;

			logo.x -= (Percent * 0.6) * delta;
			logo.y -= (Percent / 2) * delta;
		}
		else
		{
			logo.scaleX = this._width / 1280;
			logo.scaleY = this._width / 1280;

			logo.x = (this._width / 2) - (logo.width / 2);
			logo.y = (this._height / 2) - (logo.height / 2);
		}

		super.update(Percent);
	}
}
