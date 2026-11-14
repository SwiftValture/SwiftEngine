package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import shaderslmfao.ColorSwap;
import ui.PreferencesMenu;

using StringTools;

class Strums extends FlxTypedGroup<FlxSprite>
{
	public var playerStrums:FlxTypedGroup<FlxSprite>;

	public var baseX:Array<Float> = [];
	public var baseY:Array<Float> = [];
	public var baseAngle:Array<Float> = [];
	public var baseAlpha:Array<Float> = [];

	public var lastHit:Array<Float> = [-5000, -5000, -5000, -5000];

	public var holding:Array<Bool> = [false, false, false, false, false, false, false, false];

	public var skipIntroTween:Bool = false;

	public function new()
	{
		super();
		playerStrums = new FlxTypedGroup<FlxSprite>();
	}

	public function generate(player:Int, strumY:Float):Void
	{
		for (i in 0...4)
		{
			var skin:NoteSkin = NoteSkin.current;
			var babyArrow:FlxSprite = new FlxSprite(0, strumY);
			var colorswap:ColorSwap = new ColorSwap();
			babyArrow.shader = colorswap.shader;
			colorswap.update(Note.arrowColors[i]);

			if (skin.pixel)
			{
				babyArrow.loadGraphic(Paths.image(skin.image), true, 17, 17);
				babyArrow.animation.add('green', [6]);
				babyArrow.animation.add('red', [7]);
				babyArrow.animation.add('blue', [5]);
				babyArrow.animation.add('purplel', [4]);

				babyArrow.setGraphicSize(Std.int(babyArrow.width * skin.scale));
				babyArrow.updateHitbox();
				babyArrow.antialiasing = skin.antialiasing;

				switch (i)
				{
					case 0:
						babyArrow.x += Note.swagWidth * 0;
						babyArrow.animation.add('static', [0]);
						babyArrow.animation.add('pressed', [4, 8], 12, false);
						babyArrow.animation.add('confirm', [12, 16], 24, false);
					case 1:
						babyArrow.x += Note.swagWidth * 1;
						babyArrow.animation.add('static', [1]);
						babyArrow.animation.add('pressed', [5, 9], 12, false);
						babyArrow.animation.add('confirm', [13, 17], 24, false);
					case 2:
						babyArrow.x += Note.swagWidth * 2;
						babyArrow.animation.add('static', [2]);
						babyArrow.animation.add('pressed', [6, 10], 12, false);
						babyArrow.animation.add('confirm', [14, 18], 12, false);
					case 3:
						babyArrow.x += Note.swagWidth * 3;
						babyArrow.animation.add('static', [3]);
						babyArrow.animation.add('pressed', [7, 11], 12, false);
						babyArrow.animation.add('confirm', [15, 19], 24, false);
				}
			}
			else
			{
				babyArrow.frames = Paths.getMultiAtlas([skin.image, 'notes/confrimShit']);

				babyArrow.animation.addByPrefix('green', 'arrowUP');
				babyArrow.animation.addByPrefix('blue', 'arrowDOWN');
				babyArrow.animation.addByPrefix('purple', 'arrowLEFT');
				babyArrow.animation.addByPrefix('red', 'arrowRIGHT');

				babyArrow.antialiasing = skin.antialiasing;
				babyArrow.setGraphicSize(Std.int(babyArrow.width * skin.scale));

				switch (i)
				{
					case 0:
						babyArrow.x += Note.swagWidth * 0;
						babyArrow.animation.addByPrefix('static', 'arrow static instance 1');
						babyArrow.animation.addByPrefix('pressed', 'left press instance', 24, false);
						babyArrow.animation.addByIndices('confirm', 'left confirmA', [0, 1, 2, 3], '', 24, false);
					case 1:
						babyArrow.x += Note.swagWidth * 1;
						babyArrow.animation.addByPrefix('static', 'arrow static instance 2');
						babyArrow.animation.addByPrefix('pressed', 'down press instance', 24, false);
						babyArrow.animation.addByIndices('confirm', 'down confirmA', [0, 1, 2, 3], '', 24, false);
					case 2:
						babyArrow.x += Note.swagWidth * 2;
						babyArrow.animation.addByPrefix('static', 'arrow static instance 4');
						babyArrow.animation.addByPrefix('pressed', 'up press instance', 24, false);
						babyArrow.animation.addByIndices('confirm', 'up confirmA', [0, 1, 2, 3], '', 24, false);
					case 3:
						babyArrow.x += Note.swagWidth * 3;
						babyArrow.animation.addByPrefix('static', 'arrow static instance 3');
						babyArrow.animation.addByPrefix('pressed', 'right press instance', 24, false);
						babyArrow.animation.addByIndices('confirm', 'right confirmA', [0, 1, 2, 3], '', 24, false);
				}
			}

			babyArrow.updateHitbox();
			babyArrow.scrollFactor.set();

			if (!PlayState.isStoryMode && !skipIntroTween)
			{
				babyArrow.y -= 10;
				babyArrow.alpha = 0;
				FlxTween.tween(babyArrow, {y: babyArrow.y + 10, alpha: 1}, 1, {ease: FlxEase.circOut, startDelay: 0.5 + (0.2 * i)});
			}
			else
			{
				babyArrow.alpha = 1;
			}

			babyArrow.ID = i;

			if (player == 1)
				playerStrums.add(babyArrow);

			babyArrow.animation.play('static');

			if (PreferencesMenu.getPref('middlescroll'))
			{
				babyArrow.x -= 235;

				if (player == 0)
					babyArrow.visible = false;
			}
			else
			{
				babyArrow.x += 80;
			}

			babyArrow.x += ((FlxG.width / 2) * player);

			baseX.push(babyArrow.x);
			baseY.push(babyArrow.y);
			baseAngle.push(babyArrow.angle);
			baseAlpha.push(babyArrow.alpha);

			add(babyArrow);
		}
	}

	public function getStrum(noteData:Int, mustPress:Bool):FlxSprite
	{
		return members[noteData + (mustPress ? 4 : 0)];
	}

	public function press(noteData:Int, time:Float):Void
	{
		lastHit[noteData] = time;
	}

	public function updateOpponent():Void
	{
		for (i in 0...4)
		{
			var strum = members[i];
			if (strum == null || strum.animation.curAnim == null)
				continue;

			if (strum.animation.curAnim.name == 'confirm'
				&& (lastHit[i] + (Conductor.crochet * 0.5) < Conductor.songPosition || lastHit[i] > Conductor.songPosition))
			{
				strum.animation.play('static');
				holding[i] = false;
			}
		}
	}

	public function updatePlayer(pressArray:Array<Bool>, holdArray:Array<Bool>, cpuControlled:Bool):Void
	{
		playerStrums.forEach(function(spr:FlxSprite)
		{
			if (!cpuControlled)
			{
				if (pressArray[spr.ID] && (spr.animation.curAnim == null || spr.animation.curAnim.name != 'confirm'))
					spr.animation.play('pressed', true);

				if (!holdArray[spr.ID])
					spr.animation.play('static');
			}
			else if (!holding[spr.ID + 4]
				&& spr.animation.curAnim != null
				&& spr.animation.curAnim.name == 'confirm'
				&& spr.animation.curAnim.finished)
			{
				spr.animation.play('static');
			}
		});

		updateOffsets();
	}

	public function updateOffsets():Void
	{
		forEach(function(spr:FlxSprite)
		{
			if (spr.animation.curAnim != null && spr.animation.curAnim.name == 'confirm' && !NoteSkin.current.pixel)
			{
				spr.centerOffsets();
				spr.offset.x -= 13;
				spr.offset.y -= 13;
			}
			else
				spr.centerOffsets();
		});
	}

	public function playStrumAnim(strum:FlxSprite, anim:String, force:Bool = false):Void
	{
		if (strum == null)
			return;

		strum.animation.play(anim, force);

		if (anim == 'static')
			strum.offset.set(0, 0);
	}

	public function confirmOpponent(noteData:Int):Void
	{
		var strum = members[noteData];

		if (strum != null)
		{
			lastHit[noteData] = Conductor.songPosition;
			strum.animation.play('confirm', true);
		}
	}

	public function confirmPlayer(noteData:Int):Void
	{
		playerStrums.forEach(function(spr:FlxSprite)
		{
			if (noteData == spr.ID)
				spr.animation.play('confirm', true);
		});
	}

	public function holdConfirm(noteData:Int, mustPress:Bool):Void
	{
		var idx:Int = noteData + (mustPress ? 4 : 0);
		var strum = members[idx];
		if (strum == null)
			return;

		holding[idx] = true;

		if (!mustPress)
			lastHit[noteData] = Conductor.songPosition;

		var cur = strum.animation.curAnim;
		if (cur == null || cur.name != 'confirm')
			strum.animation.play('confirm', true);
	}

	public function endHold(noteData:Int, mustPress:Bool, keyHeld:Bool):Void
	{
		var idx:Int = noteData + (mustPress ? 4 : 0);
		holding[idx] = false;
	}

	public function updateModchart(currentBeat:Float):Void
	{
		for (i in 0...4)
		{
			var n = members[i];

			if (n == null)
				continue;

			n.x = baseX[i] - 300 * Math.sin(currentBeat * 8) + 350;
			n.y = baseY[i] + 64 * Math.cos((currentBeat * 8 + i * 5) * Math.PI) + 10;
		}

		for (i in 0...4)
		{
			var index = i + 4;
			var n = members[index];

			if (n == null)
				continue;

			n.x = baseX[index] + 300 * Math.sin(currentBeat * 8) - 275;
			n.y = baseY[index] - 64 * Math.cos((currentBeat * 8 + index * 5) * Math.PI) + 10;
		}
	}

	public function clearStrums():Void
	{
		clear();
		playerStrums.clear();

		baseX.splice(0, baseX.length);
		baseY.splice(0, baseY.length);
		baseAngle.splice(0, baseAngle.length);
		baseAlpha.splice(0, baseAlpha.length);

		for (i in 0...holding.length)
			holding[i] = false;
	}
}
