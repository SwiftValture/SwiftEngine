package;

import openfl.display.Sprite;
import openfl.display.Shape;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;
import openfl.system.System;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.Lib;
import flixel.FlxG;
import Type;

class PerformanceCounter extends Sprite
{
	private var text:TextField;
	private var background:Shape;

	private var times:Array<Float> = [];
	private var updateTimer:Float = 0;

	// Flag für den F8-Debug-Modus
	private var debugMode:Bool = false;

	public function new(x:Float = 5, y:Float = 3)
	{
		super();

		this.x = x;
		this.y = y;

		text = new TextField();
		text.width = 175;
		text.height = 45;
		text.x = 3;
		text.y = 3;
		text.selectable = false;
		text.mouseEnabled = false;

		var format = new TextFormat();
		format.font = "Arial";
		format.size = 13;
		format.bold = false;
		format.color = 0xFFFFFF;

		text.defaultTextFormat = format;
		text.text = "the fuckass counter is broken if you see this";
		text.alpha = 0.9;

		background = new Shape();
		drawBackground(25);

		addChild(background);
		addChild(text);

		addEventListener(Event.ENTER_FRAME, updateCounter);

		if (FlxG.stage != null)
			FlxG.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		else
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}

	private function onAddedToStage(event:Event):Void
	{
		removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
	}

	private function onKeyDown(event:KeyboardEvent):Void
	{
		if (event.keyCode == Keyboard.F8)
		{
			debugMode = !debugMode;
			drawBackground(debugMode ? 40 : 25);
		}
	}

	private function drawBackground(height:Float):Void
	{
		background.graphics.clear();
		background.graphics.beginFill(0x7C7A7A, 0.65);
		background.graphics.drawRoundRect(0, 0, 155, height, 8, 8);
		background.graphics.endFill();

		background.graphics.lineStyle(1, 0xFFFFFF, 0.5);
		background.graphics.drawRoundRect(0, 0, 155, height, 8, 8);
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

			var displayText:String = "FPS: " + currentFPS + " | RAM: " + Math.round(ram) + "mb";

			if (debugMode && FlxG.state != null)
			{
				var stateClassName:String = Type.getClassName(Type.getClass(FlxG.state));
				if (stateClassName.indexOf(".") != -1)
					stateClassName = stateClassName.substr(stateClassName.lastIndexOf(".") + 1);

				displayText += "\nState: " + stateClassName;
			}

			text.text = displayText;
		}
	}

	public function destroy():Void
	{
		removeEventListener(Event.ENTER_FRAME, updateCounter);
		if (stage != null)
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);

		times = [];

		if (parent != null)
			parent.removeChild(this);

		text = null;
	}
}
