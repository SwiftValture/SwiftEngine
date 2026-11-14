package ui;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import flixel.math.FlxMath;
import ui.AtlasText.AtlasFont;
import ui.TextMenuList.TextMenuItem;

class PreferencesMenu extends ui.OptionsState.Page
{
	public static var preferences:Map<String, Dynamic> = new Map();
	public static var songOverrides:Map<String, Dynamic> = new Map();
	public static var inSongMode:Bool = false;

	var items:TextMenuList;

	var checkboxes:Array<CheckboxThingie> = [];
	var menuCamera:FlxCamera;
	var camFollow:FlxObject;

	var numberData:Map<Int, NumberPref> = new Map();
	var numberTexts:Map<Int, AtlasText> = new Map();
	var holdTimer:Float = 0;

	public function new()
	{
		super();

		menuCamera = new SwagCamera();
		FlxG.cameras.add(menuCamera, false);
		menuCamera.bgColor = 0x0;
		camera = menuCamera;

		add(items = new TextMenuList());

		createPrefItem('naughtyness', 'censor-naughty', true);
		createPrefItem('downscroll', 'downscroll', false);
		createPrefItem('middlescroll', 'middlescroll', false);
		createPrefItem('ghost Tapping', 'ghost Tapping', false);
		createPrefItem('uncapped fps', 'uncapped fps', false);
		createPrefItem('show splashes', 'show splashes', false);
		createPrefItem('flashing menu', 'flashing-menu', true);
		createPrefItem('Camera Zooming on Beat', 'camera-zoom', true);
		createPrefItem('FPS Counter', 'fps-counter', true);
		createPrefItem('Auto Pause', 'auto-pause', false);
		createPrefItem('Test Modchart', 'Test Modchart', false);
		createPrefItem('botplay', 'botplay', false);
		createPrefItem('hitsounds', 'hitsounds', false);
		createPrefItem('camMovement', 'camMovement', false);
		createNumberItem('camMovementStrength', 'camMovementStrength', 28, 0, 80, 1);

		camFollow = new FlxObject(FlxG.width / 2, 0, 140, 70);

		if (items != null)
			camFollow.y = items.selectedItem.y - 60;

		menuCamera.follow(camFollow, null, 0.06);
		menuCamera.deadzone.set(0, 160, menuCamera.width, 40);
		menuCamera.minScrollY = 0;

		items.onChange.add(function(selected)
		{
			camFollow.y = selected.y - 120;
		});
	}

	public static function getPref(pref:String):Dynamic
	{
		if (songOverrides.exists(pref))
			return songOverrides.get(pref);

		return preferences.get(pref);
	}

	public static function setPref(pref:String, value:Dynamic):Void
	{
		preferences.set(pref, value);
	}

	public static function setFramerate(fps:Int, unlocked:Bool):Void
	{
		var target = unlocked ? 9999 : fps;

		if (target > FlxG.drawFramerate)
		{
			FlxG.updateFramerate = target;
			FlxG.drawFramerate = target;
		}
		else
		{
			FlxG.drawFramerate = target;
			FlxG.updateFramerate = target;
		}
	}

	public static function clearSongOverrides():Void
	{
		songOverrides.clear();
		inSongMode = false;

		Main.fpsCounter.visible = preferences.get('fps-counter');
		FlxG.autoPause = preferences.get('auto-pause');
	}

	public static function initPrefs():Void
	{
		if (FlxG.save.data.preferences == null)
			FlxG.save.data.preferences = preferences;
		else
			preferences = FlxG.save.data.preferences;

		preferenceCheck('censor-naughty', true);
		preferenceCheck('downscroll', false);
		preferenceCheck('middlescroll', false);
		preferenceCheck('ghost Tapping', false);
		preferenceCheck('uncapped fps', false);
		preferenceCheck('show splashes', false);
		preferenceCheck('flashing-menu', true);
		preferenceCheck('camera-zoom', true);
		preferenceCheck('fps-counter', true);
		preferenceCheck('auto-pause', false);
		preferenceCheck('master-volume', 1);
		preferenceCheck('Test Modchart', false);
		preferenceCheck('botplay', false);
		preferenceCheck('hitsounds', false);
		preferenceCheck('camMovement', false);
		preferenceCheck('camMovementStrength', 28);

		#if muted
		setPref('master-volume', 0);
		FlxG.sound.muted = true;
		#end

		Main.fpsCounter.visible = getPref('fps-counter');

		FlxG.autoPause = getPref('auto-pause');

		applyFramerate();
	}

	public static function applyFramerate():Void
	{
		setFramerate(240, getPref('uncapped fps'));
	}

	private function createPrefItem(prefName:String, prefString:String, prefValue:Dynamic):Void
	{
		items.createItem(120, (120 * items.length) + 30, prefName, AtlasFont.Bold, function()
		{
			preferenceCheck(prefString, prefValue);

			switch (Type.typeof(prefValue).getName())
			{
				case 'TBool':
					prefToggle(prefString);

				default:
					trace('swag');
			}
		});

		switch (Type.typeof(prefValue).getName())
		{
			case 'TBool':
				createCheckbox(prefString);

			default:
				trace('swag');
		}
	}

	private function createNumberItem(prefName:String, prefString:String, defaultValue:Float, min:Float, max:Float, step:Float, decimals:Int = 0):Void
	{
		preferenceCheck(prefString, defaultValue);

		var index = items.length;
		items.createItem(120, (120 * index) + 30, prefName, AtlasFont.Bold, function() {});
		checkboxes.push(null);

		numberData.set(index, {
			pref: prefString,
			min: min,
			max: max,
			step: step,
			decimals: decimals
		});

		var valueText = new AtlasText(0, (120 * index) + 30, formatNumber(getPref(prefString), decimals), AtlasFont.Default);
		numberTexts.set(index, valueText);
		add(valueText);
	}

	function formatNumber(value:Float, decimals:Int):String
	{
		return Std.string(FlxMath.roundDecimal(value, decimals));
	}

	function changeNumber(index:Int, dir:Int):Void
	{
		var data = numberData.get(index);
		var value:Float = getPref(data.pref);

		value = FlxMath.bound(value + dir * data.step, data.min, data.max);
		value = FlxMath.roundDecimal(value, data.decimals);

		if (inSongMode)
		{
			songOverrides.set(data.pref, value);
		}
		else
		{
			preferences.set(data.pref, value);
			FlxG.save.data.preferences = preferences;
			FlxG.save.flush();
		}

		numberTexts.get(index).text = formatNumber(value, data.decimals);
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}

	override function updateEnabled(elapsed:Float)
	{
		super.updateEnabled(elapsed);

		var index = items.selectedIndex;
		if (!numberData.exists(index))
		{
			holdTimer = 0;
			return;
		}

		var dir = 0;

		if (controls.UI_LEFT_P)
			dir = -1;
		else if (controls.UI_RIGHT_P)
			dir = 1;

		if (controls.UI_LEFT_P || controls.UI_RIGHT_P)
		{
			holdTimer = 0;
		}
		else if (controls.UI_LEFT || controls.UI_RIGHT)
		{
			var before = holdTimer;
			holdTimer += elapsed;

			if (holdTimer > 0.4 && Math.floor(holdTimer / 0.05) > Math.floor(before / 0.05))
				dir = controls.UI_LEFT ? -1 : 1;
		}
		else
		{
			holdTimer = 0;
		}

		if (dir != 0)
			changeNumber(index, dir);
	}

	function createCheckbox(prefString:String)
	{
		var checkbox:CheckboxThingie = new CheckboxThingie(0, 120 * (items.length - 1), getPref(prefString));
		checkboxes.push(checkbox);
		add(checkbox);
	}

	private function prefToggle(prefName:String)
	{
		var daSwap:Bool = getPref(prefName);
		daSwap = !daSwap;

		if (inSongMode)
		{
			songOverrides.set(prefName, daSwap);
		}
		else
		{
			preferences.set(prefName, daSwap);
			FlxG.save.data.preferences = preferences;
			FlxG.save.flush();
		}

		checkboxes[items.selectedIndex].daValue = daSwap;

		switch (prefName)
		{
			case 'fps-counter':
				Main.fpsCounter.visible = getPref('fps-counter');
			case 'auto-pause':
				FlxG.autoPause = getPref('auto-pause');
			case 'uncapped fps':
				applyFramerate();
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		items.forEach(function(daItem:TextMenuItem)
		{
			if (items.selectedItem == daItem)
				daItem.x = 150;
			else
				daItem.x = 120;
		});

		for (i in 0...checkboxes.length)
		{
			var box = checkboxes[i];
			if (box != null)
				box.x = (items.selectedIndex == i) ? 30 : 0;
		}

		for (index => text in numberTexts)
		{
			var item = items.members[index];
			text.x = item.x - text.width - 30;
			text.y = item.y;
		}
	}

	private static function preferenceCheck(prefString:String, prefValue:Dynamic):Void
	{
		if (preferences.get(prefString) == null)
		{
			preferences.set(prefString, prefValue);
			trace('set preference!');
		}
	}
}

class CheckboxThingie extends FlxSprite
{
	public var daValue(default, set):Bool;

	public function new(x:Float, y:Float, daValue:Bool = false)
	{
		super(x, y);

		frames = Paths.getSparrowAtlas('checkboxThingie');
		animation.addByPrefix('static', 'Check Box unselected', 24, false);
		animation.addByPrefix('checked', 'Check Box selecting animation', 24, false);

		antialiasing = true;

		setGraphicSize(Std.int(width * 0.7));
		updateHitbox();

		this.daValue = daValue;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		switch (animation.curAnim.name)
		{
			case 'static':
				offset.set();
			case 'checked':
				offset.set(17, 70);
		}
	}

	function set_daValue(value:Bool):Bool
	{
		if (value)
			animation.play('checked', true);
		else
			animation.play('static');

		return value;
	}
}

typedef NumberPref =
{
	var pref:String;
	var min:Float;
	var max:Float;
	var step:Float;
	var decimals:Int;
}
