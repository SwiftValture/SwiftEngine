package;

import flixel.FlxSprite;
import openfl.utils.Assets as OpenFlAssets;
import openfl.utils.AssetType;

using StringTools;

class HealthIcon extends FlxSprite
{
	public var sprTracker:FlxSprite;

	var char:String = '';
	var isPlayer:Bool = false;

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();

		this.isPlayer = isPlayer;
		normalIcon = char;

		changeIcon(char);
		antialiasing = !StringTools.startsWith(PlayState.curStage, "school");
		scrollFactor.set();
	}

	public var isOldIcon:Bool = false;

	var normalIcon:String = 'bf';

	public function swapOldIcon():Void
	{
		isOldIcon = !isOldIcon;

		if (isOldIcon)
			changeIcon('bf-old');
		else
			changeIcon(normalIcon);
	}

	public function changeIcon(newChar:String):Void
	{
		if (newChar == null || newChar == '')
			newChar = 'bf';

		newChar = resolveIconName(newChar.trim());

		if (newChar != char)
		{
			if (animation.getByName(newChar) == null)
			{
				var xmlPath:String = Paths.file('images/icons/icon-' + newChar + '.xml');

				if (OpenFlAssets.exists(xmlPath, TEXT))
				{
					frames = Paths.getSparrowAtlas('icons/icon-' + newChar);
					animation.addByNames(newChar, ['idle', 'losing'], 0, false, isPlayer);
				}
				else
				{
					loadGraphic(Paths.image('icons/icon-' + newChar), true, 150, 150);
					var f:Array<Int> = animation.numFrames > 1 ? [0, 1] : [0, 0];
					animation.add(newChar, f, 0, false, isPlayer);
				}
			}
			animation.play(newChar);
			char = newChar;
		}
	}

	function resolveIconName(name:String):String
	{
		if (iconExists(name))
			return name;

		var legacy:String = name.split('-')[0].trim();
		if (iconExists(legacy))
			return legacy;

		return 'face';
	}

	inline function iconExists(name:String):Bool
	{
		return OpenFlAssets.exists(Paths.image('icons/icon-' + name), IMAGE);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
