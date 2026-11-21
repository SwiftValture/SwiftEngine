package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.tweens.FlxTween;

class ComboGroup extends FlxSpriteGroup
{
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
	}

	public function popRating(daRating:String, pixel:Bool, visibleRating:Bool = true):Void
	{
		var path:String = pixel ? 'weeb/pixelUI/' + daRating + '-pixel' : daRating;

		var rating:FlxSprite = new FlxSprite().loadGraphic(Paths.image(path));
		rating.x = -40;
		rating.y = -60;
		if (PlayState.windyCombo)
		{
			rating.acceleration.y = 550;
			rating.velocity.y = -FlxG.random.int(40, 70);
			rating.velocity.x = FlxG.random.int(450, 550);
		}
		else
		{
			rating.acceleration.y = 550;
			rating.velocity.y -= FlxG.random.int(140, 175);
			rating.velocity.x -= FlxG.random.int(0, 10);
		}
		if (pixel)
			rating.setGraphicSize(Std.int(rating.width * PlayState.daPixelZoom * 0.7));
		else
		{
			rating.setGraphicSize(Std.int(rating.width * 0.7));
			rating.antialiasing = true;
		}
		rating.updateHitbox();

		addPart(rating);
		rating.visible = visibleRating;

		FlxTween.tween(rating, {alpha: 0}, 0.2, {
			onComplete: function(_) removePart(rating),
			startDelay: Conductor.crochet * 0.001
		});
	}

	public function popNumbers(combo:Int, pixel:Bool):Void
	{
		var prefix:String = pixel ? 'weeb/pixelUI/' : '';
		var suffix:String = pixel ? '-pixel' : '';

		var digits:Array<Int> = [];
		var temp:Int = combo;
		while (temp != 0)
		{
			digits.push(temp % 10);
			temp = Std.int(temp / 10);
		}
		while (digits.length < 3)
			digits.push(0);

		var daLoop:Int = 1;
		for (i in digits)
		{
			var numScore:FlxSprite = new FlxSprite().loadGraphic(Paths.image(prefix + 'num' + Std.int(i) + suffix));
			numScore.y = 80;
			numScore.x = -(43 * daLoop) + 40;

			if (pixel)
				numScore.setGraphicSize(Std.int(numScore.width * PlayState.daPixelZoom * 0.8));
			else
			{
				numScore.antialiasing = true;
				numScore.setGraphicSize(Std.int(numScore.width * 0.5));
			}
			numScore.updateHitbox();

			if (PlayState.windyCombo)
			{
				numScore.acceleration.y = 550;
				numScore.velocity.y = -FlxG.random.int(40, 70);
				numScore.velocity.x = FlxG.random.int(450, 550);
			}
			else
			{
				numScore.acceleration.y = FlxG.random.int(200, 300);
				numScore.velocity.y -= FlxG.random.int(140, 160);
				numScore.velocity.x = FlxG.random.float(-5, 5);
			}

			addPart(numScore);

			FlxTween.tween(numScore, {alpha: 0}, 0.2, {
				onComplete: function(_) removePart(numScore),
				startDelay: Conductor.crochet * 0.002
			});

			daLoop++;
		}
	}

	function addPart(s:FlxSprite):Void
	{
		add(s);
		s.cameras = this.cameras;
	}

	function removePart(s:FlxSprite):Void
	{
		remove(s, true);
		s.destroy();
	}
}
