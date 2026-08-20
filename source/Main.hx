package;

import flixel.FlxGame;
import flixel.FlxState;
import flixel.FlxG;
import openfl.Assets;
import openfl.Lib;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;
import openfl.display.Sprite;
import openfl.events.AsyncErrorEvent;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.events.NetStatusEvent;
import openfl.media.Video;
import openfl.net.NetConnection;
import openfl.net.NetStream;

class Main extends Sprite
{
	var gameWidth:Int = 1280;
	var gameHeight:Int = 720;
	var initialState:Class<FlxState> = TitleState;
	var zoom:Float = -1;
	#if web
	var framerate:Int = 240;
	#else
	var framerate:Int = 240;
	#end
	var skipSplash:Bool = true;
	var startFullscreen:Bool = false;

	public static function main():Void
	{
		Lib.current.addChild(new Main());
	}

	public function new()
	{
		super();

		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);

		if (stage != null)
		{
			init();
		}
		else
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}

	private function onKeyDown(event:KeyboardEvent):Void
	{
		if (event.keyCode == Keyboard.F11)
		{
			Lib.application.window.fullscreen = !Lib.application.window.fullscreen;
		}
	}

	private function init(?E:Event):Void
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}

		setupGame();
	}

	var video:Video;
	var netStream:NetStream;
	private var overlay:Sprite;

	public static var fpsCounter:PerformanceCounter;

	private function setupGame():Void
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (zoom == -1)
		{
			var ratioX:Float = stageWidth / gameWidth;
			var ratioY:Float = stageHeight / gameHeight;
			zoom = Math.min(ratioX, ratioY);
			gameWidth = Math.ceil(stageWidth / zoom);
			gameHeight = Math.ceil(stageHeight / zoom);
		}

		#if !debug
		initialState = TitleState;
		#end

		#if !mobile
		fpsCounter = new PerformanceCounter(5, 3);
		#end

		addChild(new FlxGame(gameWidth, gameHeight, initialState, #if (flixel < "5.0.0") zoom, #end framerate, framerate, skipSplash, startFullscreen));

		FlxG.save.bind("SwiftEngine");

		if (FlxG.save.data.volume == null)
			FlxG.save.data.volume = FlxG.sound.volume;

		FlxG.sound.volume = FlxG.save.data.volume;

		#if !mobile
		addChild(fpsCounter);
		#end
	}

	public function update(elapsed:Float) {}
}
