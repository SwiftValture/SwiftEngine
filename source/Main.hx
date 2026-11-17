package;

import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxState;
import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;

class Main extends Sprite
{
	var gameWidth:Int = 1280;
	var gameHeight:Int = 720;
	var initialState:Class<FlxState> = TitleState;
	var zoom:Float = -1;
	var framerate:Int = 240;
	var skipSplash:Bool = true;
	var startFullscreen:Bool = false;

	public static var fpsCounter:PerformanceCounter;

	public static function main():Void
	{
		Lib.current.addChild(new Main());
	}

	public function new()
	{
		super();

		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);

		if (stage != null)
			init();
		else
			addEventListener(Event.ADDED_TO_STAGE, init);
	}

	private function onKeyDown(event:KeyboardEvent):Void
	{
		if (event.keyCode == Keyboard.F11)
		{
			#if !html5
			Lib.application.window.fullscreen = !Lib.application.window.fullscreen;
			#end
		}

		if (event.keyCode == Keyboard.F5)
			FlxG.resetState();
	}

	private function init(?E:Event):Void
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
			removeEventListener(Event.ADDED_TO_STAGE, init);

		setupGame();
	}

	private function setupGame():Void
	{
		ModManager.init();

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
		fpsCounter = new PerformanceCounter(5, 5);
		#end

		var game = new FlxGame(gameWidth, gameHeight, initialState, #if (flixel < "5.0.0") zoom, #end framerate, framerate, skipSplash, startFullscreen);
		@:privateAccess game._customSoundTray = FunkinSoundTray;
		addChild(game);

		FlxG.save.bind("SwiftEngine");
		lime.app.Application.current.onExit.add(function(_) FunkinSoundTray.flushVolumeSettings());

		if (FlxG.save.data.volume != null)
			FlxG.sound.volume = FlxG.save.data.volume;
		if (FlxG.save.data.mute != null)
			FlxG.sound.muted = FlxG.save.data.mute;

		#if !mobile
		addChild(fpsCounter);
		#end

		FlxG.fixedTimestep = false;
		FlxG.mouse.useSystemCursor = true;
	}
}
