package;

import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.math.FlxRect;
import flixel.util.FlxDestroyUtil;
import shaderslmfao.ColorSwap;
import ui.PreferencesMenu;

class Note extends FlxSprite
{
	public static inline var SICK_WINDOW:Float = 45.0;
	public static inline var GOOD_WINDOW:Float = 90.0;
	public static inline var BAD_WINDOW:Float = 135.0;

	static var laneNames:Array<String> = ['purple', 'blue', 'green', 'red'];

	static var scrollPrefix = ['purple instance', 'blue instance', 'green instance', 'red instance'];
	static var holdEndPrefix = ['pruple end hold', 'blue hold end', 'green hold end', 'red hold end'];
	static var holdPrefix = ['purple hold piece', 'blue hold piece', 'green hold piece', 'red hold piece'];

	public var strumTime:Float = 0;

	public var mustPress:Bool = false;
	public var noteData:Int = 0;
	public var canBeHit:Bool = false;
	public var tooLate:Bool = false;
	public var wasGoodHit:Bool = false;
	public var prevNote:Note;
	public var hitHandled:Bool = false;

	public var noteType:String = '';

	private var willMiss:Bool = false;

	public var altNote:Bool = false;
	public var invisNote:Bool = false;

	public var sustainLength:Float = 0;
	public var isSustainNote:Bool = false;
	public var extraSustain:Bool = false;

	public var trail:SustainTrail = null;

	public var colorSwap:ColorSwap;
	public var noteScore:Float = 1;

	public static var swagWidth:Float = 160 * 0.7;
	public static var PURP_NOTE:Int = 0;
	public static var GREEN_NOTE:Int = 2;
	public static var BLUE_NOTE:Int = 1;
	public static var RED_NOTE:Int = 3;

	public static var arrowColors:Array<Float> = [1, 1, 1, 1];

	public var isLastSustain:Bool = false;

	var graphicScale:Float = 1;

	public var noAnimation:Bool = false;

	public function new(strumTime:Float, noteData:Int, ?prevNote:Note, ?sustainNote:Bool = false, createdFrom:Dynamic = null)
	{
		super();

		if (prevNote == null)
			prevNote = this;

		this.prevNote = prevNote;
		isSustainNote = sustainNote;

		x += 50;
		y -= 2000;
		this.strumTime = strumTime;

		this.noteData = noteData;

		var skin:NoteSkin = NoteSkin.current;

		if (skin.pixel)
		{
			loadGraphic(Paths.image(skin.image), true, 17, 17);

			animation.add('greenScroll', [6]);
			animation.add('redScroll', [7]);
			animation.add('blueScroll', [5]);
			animation.add('purpleScroll', [4]);

			if (isSustainNote)
			{
				loadGraphic(Paths.image(skin.holdImage), true, 7, 6);

				animation.add('purpleholdend', [4]);
				animation.add('greenholdend', [6]);
				animation.add('redholdend', [7]);
				animation.add('blueholdend', [5]);

				animation.add('purplehold', [0]);
				animation.add('greenhold', [2]);
				animation.add('redhold', [3]);
				animation.add('bluehold', [1]);
			}
		}
		else
		{
			frames = Paths.getSparrowAtlas(skin.image);

			if (noteData >= 0 && noteData < 4)
			{
				var n = laneNames[noteData];
				if (isSustainNote)
				{
					animation.addByPrefix(n + 'holdend', holdEndPrefix[noteData]);
					animation.addByPrefix(n + 'hold', holdPrefix[noteData]);
				}
				else
					animation.addByPrefix(n + 'Scroll', scrollPrefix[noteData]);
			}
		}

		setGraphicSize(Std.int(width * skin.scale));
		updateHitbox();
		antialiasing = skin.antialiasing;
		graphicScale = scale.y;

		colorSwap = null;

		var validLane:Bool = noteData >= 0 && noteData < laneNames.length;

		if (validLane)
		{
			x += swagWidth * noteData;
			animation.play(laneNames[noteData] + 'Scroll');
		}

		if (isSustainNote && prevNote != null)
		{
			alpha = 0.6;
			if (PreferencesMenu.getPref('downscroll'))
				angle = 180;
			x += width / 2;
			if (validLane)
				animation.play(laneNames[noteData] + 'holdend');
			updateHitbox();
			x -= width / 2;
			if (skin.pixel)
			{
				x += 30;
			}
			if (prevNote.isSustainNote)
			{
				if (prevNote.noteData >= 0 && prevNote.noteData < laneNames.length)
					prevNote.animation.play(laneNames[prevNote.noteData] + 'hold');
				var stepPx:Float = Conductor.stepCrochet * 0.45 * FlxMath.roundDecimal(PlayState.SONG.speed, 2);
				prevNote.scale.y = (stepPx + 2) / prevNote.frameHeight;
				prevNote.updateHitbox();
			}
		}
	}

	public function updateColors():Void
	{
		if (colorSwap != null)
			colorSwap.update(arrowColors[noteData]);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		var songPos:Float = Conductor.getTimeWithDelta();

		if (mustPress)
		{
			if (willMiss && !wasGoodHit)
			{
				tooLate = true;
				canBeHit = false;
			}
			else
			{
				if (strumTime > songPos - Conductor.safeZoneOffset)
				{
					if (strumTime < songPos + (Conductor.safeZoneOffset * 0.5))
						canBeHit = true;
				}
				else
				{
					canBeHit = true;
					willMiss = true;
				}
			}
		}
		else
		{
			canBeHit = false;

			if (strumTime <= songPos)
				wasGoodHit = true;
		}

		if (tooLate)
		{
			if (alpha > 0.3)
				alpha = 0.3;
		}
	}

	var __lastSustainClipT:Float = -1.0;

	public function setSustainClip(t:Float):Void
	{
		if (t <= 0)
		{
			if (clipRect != null)
				clipRect = null;
			return;
		}
		if (t >= 1)
		{
			visible = false;
			return;
		}
		if (t == __lastSustainClipT && _frame != null)
			return;
		__lastSustainClipT = t;

		@:bypassAccessor
		{
			if (clipRect == null)
				clipRect = FlxRect.get();
			clipRect.set(0, frameHeight * t, frameWidth, frameHeight * (1 - t));
		}
		@:privateAccess
		{
			if (frame != null && _frame != null)
				_frame = frame.clipTo(clipRect, _frame);
		}
	}

	@:noCompletion
	override function set_clipRect(rect:FlxRect):FlxRect
	{
		@:bypassAccessor clipRect = rect;
		__lastSustainClipT = -1.0;
		@:privateAccess if (frame != null)
		{
			if (rect != null && _frame != null)
				_frame = frame.clipTo(rect, _frame);
			else if (_frame != null)
				_frame = frame.copyTo(_frame);
			dirty = true;
		}
		return rect;
	}

	override function destroy()
	{
		super.destroy();
		clipRect = FlxDestroyUtil.put(clipRect);
	}
}
