package;

import openfl.display.Sprite;
import openfl.display.Shape;
import openfl.events.Event;
import openfl.system.System;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.Lib;

class PerformanceCounter extends Sprite
{
	private var text:TextField;

	private var times:Array<Float> = [];
	private var updateTimer:Float = 0;

	public function new(x:Float = 5, y:Float = 3)
	{
		super();

		this.x = x;
		this.y = y;

		text = new TextField();
		text.width = 175;
		text.height = 25;
		text.x = 2;
		text.y = 3;
		text.selectable = false;
		text.mouseEnabled = false;

		var format = new TextFormat();
		format.font = "Arial";
		format.size = 13;
		format.bold = false;
		format.color = 0xFFFFFF;

		text.defaultTextFormat = format;
		text.text = "|FPS: 0 | RAM: 0 MB|";
		text.alpha = 0.9;

		var background:Shape = new Shape();

		background.graphics.beginFill(0x7C7A7A, 0.65);
		background.graphics.drawRect(0, 0, 155, 25);
		background.graphics.endFill();
		background.graphics.lineStyle(1, 0xFFFFFF, 0.5);
		background.graphics.drawRect(0, 0, 155, 25);

		addChild(background);
		addChild(text);

		addEventListener(Event.ENTER_FRAME, updateCounter);
	}

	private function updateCounter(event:Event):Void
	{
		var currentTime:Float = Lib.getTimer() / 1000;

		times.push(currentTime);

		while (times.length > 0 && times[0] < currentTime - 1)
		{
			times.shift();
		}
		updateTimer += 1 / Lib.current.stage.frameRate;

		if (updateTimer >= 0.1)
		{
			updateTimer = 0;

			var currentFPS:Int = times.length;
			var ram:Float = System.totalMemory / 1024 / 1024;

			text.text = "FPS: " + currentFPS + " | RAM: " + Math.round(ram) + "mb";
		}
	}

	public function destroy():Void
	{
		removeEventListener(Event.ENTER_FRAME, updateCounter);

		times = [];

		if (parent != null)
			parent.removeChild(this);

		text = null;
	}
}
