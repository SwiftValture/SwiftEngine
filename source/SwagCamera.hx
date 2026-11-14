package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;

class SwagCamera extends FlxCamera
{
	var lerpElapsed:Float = 1 / 60;

	override function set_followLerp(Value:Float):Float
	{
		return followLerp = FlxMath.bound(Value, 0, 1);
	}

	override public function update(elapsed:Float):Void
	{
		lerpElapsed = elapsed;
		super.update(elapsed);
	}

	override public function updateFollow():Void
	{
		if (deadzone == null)
		{
			target.getMidpoint(_point);
			_point.addPoint(targetOffset);
			_scrollTarget.set(_point.x - width * 0.5, _point.y - height * 0.5);
		}
		else
		{
			var edge:Float;
			var targetX:Float = target.x + targetOffset.x;
			var targetY:Float = target.y + targetOffset.y;

			if (style == SCREEN_BY_SCREEN)
			{
				if (targetX >= (scroll.x + width))
					_scrollTarget.x += width;
				else if (targetX < scroll.x)
					_scrollTarget.x -= width;

				if (targetY >= (scroll.y + height))
					_scrollTarget.y += height;
				else if (targetY < scroll.y)
					_scrollTarget.y -= height;
			}
			else
			{
				edge = targetX - deadzone.x;
				if (_scrollTarget.x > edge)
					_scrollTarget.x = edge;
				edge = targetX + target.width - deadzone.x - deadzone.width;
				if (_scrollTarget.x < edge)
					_scrollTarget.x = edge;

				edge = targetY - deadzone.y;
				if (_scrollTarget.y > edge)
					_scrollTarget.y = edge;
				edge = targetY + target.height - deadzone.y - deadzone.height;
				if (_scrollTarget.y < edge)
					_scrollTarget.y = edge;
			}

			if ((target is FlxSprite))
			{
				if (_lastTargetPosition == null)
					_lastTargetPosition = FlxPoint.get(target.x, target.y);

				_scrollTarget.x += (target.x - _lastTargetPosition.x) * followLead.x;
				_scrollTarget.y += (target.y - _lastTargetPosition.y) * followLead.y;

				_lastTargetPosition.x = target.x;
				_lastTargetPosition.y = target.y;
			}
		}

		if (followLerp >= 1.0)
		{
			scroll.copyFrom(_scrollTarget);
		}
		else if (followLerp > 0.0)
		{
			final adjustedLerp:Float = 1.0 - Math.pow(1.0 - followLerp, lerpElapsed * 60);
			scroll.add((_scrollTarget.x - scroll.x) * adjustedLerp, (_scrollTarget.y - scroll.y) * adjustedLerp);
		}
	}
}
