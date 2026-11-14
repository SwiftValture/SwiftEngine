package;

import flixel.FlxCamera;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import openfl.utils.Assets;
import ui.PreferencesMenu;

using StringTools;

typedef HoldCoverAnimData =
{
	var name:String;
	var prefix:String;
	var fps:Int;
	var loop:Bool;
	var x:Float;
	var y:Float;
}

typedef HoldCoverConfig =
{
	var sprite:String;
	var scale:Float;
	var alpha:Float;
	var antialiasing:Bool;
	var strums:Map<Int, Array<HoldCoverAnimData>>;
}

class HoldCover extends FlxSprite
{
	public var mustPress:Bool;
	public var lane:Int;
	public var styleKey:String = null;
	public var endTime:Float = Math.POSITIVE_INFINITY;

	public var baseOffsetX:Float = 0;

	public var baseOffsetY:Float = 0;

	var animOffsets:Map<String, Array<Float>> = new Map();

	public function new(mustPress:Bool, lane:Int)
	{
		super();
		this.mustPress = mustPress;
		this.lane = lane;
	}

	public function clearAnims():Void
	{
		animation.destroyAnimations();
		animOffsets.clear();
	}

	public function addOffset(name:String, x:Float, y:Float):Void
		animOffsets.set(name, [x, y]);

	public function playAnim(name:String, force:Bool = true):Void
	{
		if (!animation.exists(name))
			return;

		animation.play(name, force);
		var o = animOffsets.get(name);
		var s:Float = HoldCovers.animOffsetSign;
		if (o != null)
			offset.set(baseOffsetX + o[0] * s, baseOffsetY + o[1] * s);
		else
			offset.set(baseOffsetX, baseOffsetY);
	}

	public function currentAnimName():String
		return animation.curAnim != null ? animation.curAnim.name : "";
}

class HoldCovers extends FlxTypedGroup<HoldCover>
{
	public static var allowHoldCovers:Bool = true;

	public static var animOffsetSign:Float = 1;

	static final DIRECTIONS:Array<String> = ["left", "down", "up", "right"];

	var covers:Array<HoldCover> = [for (_ in 0...8) null];

	var configs:Map<String, HoldCoverConfig> = new Map();
	var atlases:Map<String, FlxAtlasFrames> = new Map();

	var getStrum:Bool->Int->FlxSprite;
	var hudCamera:FlxCamera;

	public function new(getStrum:Bool->Int->FlxSprite, ?hudCamera:FlxCamera, ?preloadStyles:Array<String>)
	{
		super();
		this.getStrum = getStrum;
		this.hudCamera = hudCamera;

		if (preloadStyles == null)
			preloadStyles = ["default", "pixel-default"];

		for (style in preloadStyles)
		{
			var cfg = getConfig(style);
			if (cfg != null)
				getAtlas(cfg.sprite);
		}
	}

	public function noteHit(mustPress:Bool, lane:Int, strumTime:Float, sustainLength:Float, ?style:String):Void
	{
		if (!allowHoldCovers || sustainLength <= 1)
			return;

		lane = lane % 4;
		var key:String = (style == null || style == "") ? "default" : style;
		var cfg = getConfig(key);
		if (cfg == null)
			return;

		var idx:Int = (mustPress ? 4 : 0) + lane;
		var cover:HoldCover = covers[idx];

		if (cover == null)
		{
			cover = new HoldCover(mustPress, lane);
			if (hudCamera != null)
				cover.cameras = [hudCamera];

			cover.animation.finishCallback = function(animName:String)
			{
				if (animName.startsWith("start"))
					cover.playAnim("holding" + DIRECTIONS[cover.lane]);
				else if (animName.startsWith("end"))
					cover.kill();
			};

			cover.kill();
			add(cover);
			covers[idx] = cover;
		}

		if (cover.styleKey != key)
		{
			cover.styleKey = key;
			cover.frames = getAtlas(cfg.sprite);
			cover.clearAnims();

			var anims = cfg.strums.get(lane);
			if (anims != null)
			{
				for (a in anims)
				{
					cover.animation.addByPrefix(a.name, a.prefix, a.fps, a.loop);
					cover.addOffset(a.name, a.x, a.y);
				}
			}

			cover.alpha = cfg.alpha;
			cover.antialiasing = cfg.antialiasing;
		}

		cover.endTime = strumTime + sustainLength;
		cover.revive();
		cover.alpha = cfg.alpha;

		var startAnim:String = "start" + DIRECTIONS[lane];
		cover.playAnim(startAnim);

		cover.scale.set(cfg.scale, cfg.scale);
		cover.updateHitbox();
		cover.baseOffsetX = cover.offset.x;
		cover.baseOffsetY = cover.offset.y;
		cover.playAnim(startAnim);
		updateCoverPosition(cover);
	}

	public function keepAlive(mustPress:Bool, lane:Int, endTime:Float, ?style:String):Void
	{
		if (!allowHoldCovers)
			return;

		lane = lane % 4;
		var cover:HoldCover = covers[(mustPress ? 4 : 0) + lane];

		if (cover != null && cover.alive)
			return;

		if (Conductor.songPosition >= endTime)
			return;

		noteHit(mustPress, lane, 0, endTime, style);
	}

	public function sustainHit(mustPress:Bool, lane:Int, isLast:Bool, ?style:String):Void
	{
		if (!allowHoldCovers)
			return;

		lane = lane % 4;
		var idx:Int = (mustPress ? 4 : 0) + lane;
		var cover:HoldCover = covers[idx];

		if (cover == null || !cover.alive)
		{
			noteHit(mustPress, lane, 0, 2, style);
			cover = covers[idx];
			if (cover == null)
				return;
		}

		cover.endTime = Math.POSITIVE_INFINITY;

		if (isLast)
		{
			if (!mustPress)
				cover.kill();
			else if (!cover.currentAnimName().startsWith("end"))
				cover.playAnim("end" + DIRECTIONS[lane]);
		}
	}

	public function keyReleased(lane:Int):Void
		killLane(true, lane);

	public function killLane(mustPress:Bool, lane:Int):Void
	{
		var cover = covers[(mustPress ? 4 : 0) + (lane % 4)];
		if (cover == null || !cover.alive)
			return;

		if (!cover.currentAnimName().startsWith("end"))
		{
			cover.kill();
		}

		cover.endTime = Math.POSITIVE_INFINITY;
	}

	public function killAllCovers():Void
	{
		for (c in covers)
		{
			if (c != null)
			{
				c.kill();
				c.endTime = Math.POSITIVE_INFINITY;
			}
		}
	}

	override function update(elapsed:Float):Void
	{
		super.update(elapsed);

		for (cover in covers)
		{
			if (cover == null || !cover.alive)
				continue;

			if (Conductor.songPosition >= cover.endTime)
			{
				if (!cover.mustPress)
					cover.kill();
				else
					cover.playAnim("end" + DIRECTIONS[cover.lane]);

				cover.endTime = Math.POSITIVE_INFINITY;
			}

			if (cover.alive)
				updateCoverPosition(cover);
		}

		visible = PreferencesMenu.getPref('show splashes');
	}

	function updateCoverPosition(cover:HoldCover):Void
	{
		var strum:FlxSprite = getStrum(cover.mustPress, cover.lane);
		if (strum == null)
			return;

		cover.visible = strum.visible;
		cover.setPosition(strum.x + (strum.width - cover.width) * 0.5, strum.y + (strum.height - cover.height) * 0.5);
		cover.angle = strum.angle;
	}

	function getConfig(type:String):HoldCoverConfig
	{
		if (type == null || type == "")
			type = "default";

		if (configs.exists(type))
			return configs.get(type);

		var path:String = Paths.xml("holdcovers/" + type);
		if (!Assets.exists(path))
			path = Paths.xml("holdcovers/default");

		var config:HoldCoverConfig = null;

		if (Assets.exists(path))
		{
			var xml:Xml = Xml.parse(Assets.getText(path)).firstElement();

			config = {
				sprite: attr(xml, "sprite", "game/holdcovers/default"),
				scale: Std.parseFloat(attr(xml, "scale", "1")),
				alpha: Std.parseFloat(attr(xml, "alpha", "1")),
				antialiasing: attr(xml, "antialiasing", "true").toLowerCase() == "true",
				strums: new Map<Int, Array<HoldCoverAnimData>>()
			};

			for (strumNode in xml.elements())
			{
				if (strumNode.nodeName != "strum")
					continue;

				var animations:Array<HoldCoverAnimData> = [];
				for (animNode in strumNode.elements())
				{
					if (animNode.nodeName != "anim")
						continue;

					animations.push({
						name: animNode.get("name"),
						prefix: animNode.get("anim"),
						fps: Std.parseInt(attr(animNode, "fps", "24")),
						loop: attr(animNode, "loop", "false").toLowerCase() == "true",
						x: Std.parseFloat(attr(animNode, "x", "0")),
						y: Std.parseFloat(attr(animNode, "y", "0"))
					});
				}
				config.strums.set(Std.parseInt(strumNode.get("id")), animations);
			}
		}

		configs.set(type, config);
		return config;
	}

	function getAtlas(sprite:String):FlxAtlasFrames
	{
		if (!atlases.exists(sprite))
		{
			var key:String = Assets.exists(Paths.image(sprite)) ? sprite : "game/holdcovers/default";
			atlases.set(sprite, Paths.getSparrowAtlas(key));
		}
		return atlases.get(sprite);
	}

	static function attr(xml:Xml, name:String, def:String):String
	{
		var v:String = xml.get(name);
		return v == null ? def : v;
	}
}
