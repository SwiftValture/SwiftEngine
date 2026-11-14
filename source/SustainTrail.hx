package;

import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.graphics.tile.FlxDrawTrianglesItem.DrawData;
import flixel.math.FlxMath;

class SustainTrail extends FlxSprite
{
	public static inline var PIXELS_PER_MS:Float = 0.45;

	static final TRIANGLE_VERTEX_INDICES:Array<Int> = [0, 1, 2, 1, 2, 3, 4, 5, 6, 5, 6, 7];

	public var strumTime:Float = 0;
	public var noteDirection:Int = 0;
	public var sustainLength(default, set):Float = 0;
	public var scrollSpeed(default, set):Float = 1.0;

	public var mustPress:Bool = false;
	public var hit:Bool = false;
	public var dropped:Bool = false;

	public var holding:Bool = false;
	public var clipTime:Float = 0;

	public var vertices:DrawData<Float> = new DrawData<Float>();
	public var indices:DrawData<Int> = new DrawData<Int>();
	public var uvtData:DrawData<Float> = new DrawData<Float>();

	public var zoom:Float = 1;
	public var endOffset:Float = 0.5;
	public var bottomClip:Float = 0.9;

	public var graphicWidth:Float = 0;
	public var graphicHeight:Float = 0;

	public function new(noteDirection:Int, sustainLength:Float, strip:FlxGraphic, capFraction:Float, zoom:Float = 1.0, isPixel:Bool = false)
	{
		super(0, 0);

		this.zoom = zoom;
		loadGraphic(strip);
		antialiasing = !isPixel;

		endOffset = bottomClip = capFraction;

		graphicWidth = graphic.width / 8 * zoom;

		this.noteDirection = noteDirection;
		this.sustainLength = sustainLength;

		setIndices(TRIANGLE_VERTEX_INDICES);
		this.active = false;
		alpha = 0.6;
		triggerRedraw();
	}

	function setIndices(arr:Array<Int>):Void
	{
		if (indices.length == arr.length)
			for (i in 0...arr.length)
				indices[i] = arr[i];
		else
			indices = new DrawData<Int>(arr.length, false, arr);
	}

	public static inline function sustainHeight(susLength:Float, scroll:Float):Float
		return susLength * PIXELS_PER_MS * scroll;

	function set_scrollSpeed(v:Float):Float
	{
		if (scrollSpeed != v)
		{
			scrollSpeed = v;
			triggerRedraw();
		}
		return v;
	}

	function set_sustainLength(s:Float):Float
	{
		if (s < 0.0)
			s = 0.0;
		sustainLength = s;
		triggerRedraw();
		return s;
	}

	function triggerRedraw():Void
	{
		if (graphic == null)
			return;
		graphicHeight = sustainHeight(sustainLength, scrollSpeed);
		updateClipping(strumTime);
	}

	public function updateClipping(songTime:Float):Void
	{
		if (graphic == null)
			return;

		var clipHeight:Float = FlxMath.bound(sustainHeight(sustainLength - (songTime - strumTime), scrollSpeed), 0, graphicHeight);
		if (clipHeight <= 0.1)
		{
			visible = false;
			return;
		}
		visible = true;

		var bottomHeight:Float = graphic.height * zoom * endOffset;
		var partHeight:Float = clipHeight - bottomHeight;

		vertices[0] = 0.0;
		vertices[1] = flipY ? clipHeight : graphicHeight - clipHeight;

		vertices[2] = graphicWidth;
		vertices[3] = vertices[1];

		vertices[4] = 0.0;
		vertices[5] = if (partHeight > 0) (flipY ? 0.0 + bottomHeight : vertices[1] + partHeight) else vertices[1];

		vertices[6] = graphicWidth;
		vertices[7] = vertices[5];

		uvtData[0] = 1 / 4 * (noteDirection % 4);
		uvtData[1] = (-partHeight) / graphic.height / zoom;

		uvtData[2] = uvtData[0] + 1 / 8;
		uvtData[3] = uvtData[1];

		uvtData[4] = uvtData[0];
		uvtData[5] = 0.0;

		uvtData[6] = uvtData[2];
		uvtData[7] = uvtData[5];

		vertices[8] = vertices[4];
		vertices[9] = vertices[5];

		vertices[10] = vertices[6];
		vertices[11] = vertices[7];

		vertices[12] = vertices[4];
		vertices[13] = flipY ? (graphic.height * (-bottomClip + endOffset) * zoom) : (graphicHeight + graphic.height * (bottomClip - endOffset) * zoom);

		vertices[14] = vertices[6];
		vertices[15] = vertices[13];

		uvtData[8] = uvtData[4] + 1 / 8;
		uvtData[9] = if (partHeight > 0) 0 else (bottomHeight - clipHeight) / zoom / graphic.height;

		uvtData[10] = uvtData[8] + 1 / 8;
		uvtData[11] = uvtData[9];

		uvtData[12] = uvtData[8];
		uvtData[13] = bottomClip;

		uvtData[14] = uvtData[10];
		uvtData[15] = uvtData[13];
	}

	@:access(flixel.FlxCamera)
	override public function draw():Void
	{
		if (alpha == 0 || graphic == null || vertices == null || !visible)
			return;

		for (camera in cameras)
		{
			if (!camera.visible || !camera.exists)
				continue;

			getScreenPosition(_point, camera);
			camera.drawTriangles(graphic, vertices, indices, uvtData, null, _point, blend, true, antialiasing, colorTransform, shader);
		}
	}

	override public function destroy():Void
	{
		vertices = null;
		indices = null;
		uvtData = null;
		super.destroy();
	}
}
