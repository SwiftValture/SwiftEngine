package ui;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import ui.OptionsState.OptionsMenu;
import ui.OptionsState.Page;
import ui.OptionsState.PageName;

class OptionsSubState extends MusicBeatSubstate
{
	var pages = new Map<PageName, Page>();
	var currentName:PageName = PageName.Options;
	var optCam:FlxCamera;
	var wasInSongMode:Bool;
	var options:OptionsMenu;
	var ready:Bool = false;

	public function new()
	{
		super();

		wasInSongMode = PreferencesMenu.inSongMode;
		PreferencesMenu.inSongMode = false;

		optCam = new FlxCamera();
		optCam.bgColor = 0xFF000000;
		FlxG.cameras.add(optCam, false);

		var menuBG = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		menuBG.color = 0xFFea71fd;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.scrollFactor.set(0, 0);
		menuBG.cameras = [optCam];
		add(menuBG);

		options = cast addPage(PageName.Options, new OptionsMenu(false));
		options.cameras = [optCam];
		options.enabled = false;
		var preferences = addPage(PageName.Preferences, new PreferencesMenu());
		var controls = addPage(PageName.Controls, new ControlsMenu());

		options.onExit.add(closeOptions);
		preferences.onExit.add(switchPage.bind(PageName.Options));
		controls.onExit.add(switchPage.bind(PageName.Options));
	}

	function addPage<T:Page>(name:PageName, page:T):T
	{
		page.onSwitch.add(switchPage);
		pages[name] = page;
		add(page);
		page.exists = currentName == name;
		return page;
	}

	function switchPage(name:PageName)
	{
		pages[currentName].exists = false;
		currentName = name;
		pages[currentName].exists = true;
	}

	function closeOptions()
	{
		FlxG.save.flush();
		close();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (!ready)
		{
			ready = true;
			options.enabled = true;
		}
	}

	override function destroy()
	{
		super.destroy();

		PreferencesMenu.inSongMode = wasInSongMode;

		if (FlxG.cameras.list.contains(optCam))
			FlxG.cameras.remove(optCam);
	}
}
