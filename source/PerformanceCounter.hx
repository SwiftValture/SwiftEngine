package;

import Type;
import flixel.FlxG;
import openfl.Lib;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.system.System;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.ui.Keyboard;

class PerformanceCounter extends Sprite
{
	private var text:TextField;
	private var background:Shape;

	private static inline var DISPLAY_INTERVAL:Float = 0.05;
	private static inline var FPS_WINDOW:Float = 1.0;
	private static inline var MAX_SAMPLES:Int = 20000;

	private var frameTimes:Array<Float> = [];
	private var sampleHead:Int = 0;
	private var sampleCount:Int = 0;

	private var lastFrameTime:Float = 0;
	private var lastDisplayTime:Float = 0;

	private var debugMode:Bool = false;

	public function new(x:Float = 4, y:Float = 7)
	{
		super();

		this.x = x;
		this.y = y;

		background = new Shape();
		drawBackground(25);

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
		text.text = "FPS: 0 | RAM: 0mb";
		text.alpha = 0.9;

		addChild(background);
		addChild(text);

		lastFrameTime = Lib.getTimer() / 1000;
		lastDisplayTime = lastFrameTime;

		addEventListener(Event.ENTER_FRAME, updateCounter);

		if (FlxG.stage != null)
			FlxG.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		else
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}

	private function onAddedToStage(event:Event):Void
	{
		removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

		if (stage != null)
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
	}

	private function onKeyDown(event:KeyboardEvent):Void
	{
		if (event.keyCode == Keyboard.F8)
		{
			debugMode = !debugMode;
			drawBackground(debugMode ? 40 : 25);

			lastDisplayTime = 0;
			updateCounter(null);
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

		if (currentTime <= lastFrameTime)
			return;

		if (sampleCount < MAX_SAMPLES)
		{
			var insertIndex:Int = (sampleHead + sampleCount) % MAX_SAMPLES;
			frameTimes[insertIndex] = currentTime;
			sampleCount++;
		}
		else
		{
			frameTimes[sampleHead] = currentTime;
			sampleHead = (sampleHead + 1) % MAX_SAMPLES;
		}

		lastFrameTime = currentTime;

		while (sampleCount > 0)
		{
			if (frameTimes[sampleHead] >= currentTime - FPS_WINDOW)
				break;

			sampleHead = (sampleHead + 1) % MAX_SAMPLES;
			sampleCount--;
		}

		if (currentTime - lastDisplayTime >= DISPLAY_INTERVAL)
		{
			lastDisplayTime = currentTime;

			var currentFPS:Int = sampleCount;
			var ram:Float = System.totalMemory / 1024 / 1024;

			var displayText:String = "FPS: " + currentFPS + " | RAM: " + Math.round(ram) + "mb";

			if (debugMode && FlxG.state != null)
			{
				var stateClassName:String = Type.getClassName(Type.getClass(FlxG.state));

				if (stateClassName != null && stateClassName.indexOf(".") != -1)
				{
					stateClassName = stateClassName.substr(stateClassName.lastIndexOf(".") + 1);
				}

				displayText += "\nState: " + stateClassName;
			}

			text.text = displayText;
		}
	}

	public function destroy():Void
	{
		removeEventListener(Event.ENTER_FRAME, updateCounter);
		removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

		if (stage != null)
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}

		frameTimes = [];
		sampleHead = 0;
		sampleCount = 0;

		if (parent != null)
			parent.removeChild(this);

		text = null;
		background = null;
	}
}
