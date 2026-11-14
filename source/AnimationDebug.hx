package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.text.FlxText.FlxTextAlign;
import flixel.text.FlxText.FlxTextBorderStyle;
import flixel.util.FlxColor;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import openfl.net.FileReference;
import openfl.system.System;

using StringTools;

typedef AnimDbgSnapshot =
{
	var anim:String;
	var x:Float;
	var y:Float;
}

typedef AnimDbgButton =
{
	var bg:FlxSprite;
	var label:FlxText;
	var onClick:Void->Void;
	var isOn:Void->Bool;
}

class AnimationDebug extends FlxState
{
	static inline var LIST_W:Int = 320;
	static inline var ROW_H:Int = 22;
	static inline var LIST_TOP:Int = 62;
	static inline var HINT_H:Int = 78;
	static inline var INFO_W:Int = 300;
	static inline var INFO_H:Int = 380;
	static inline var MIN_ZOOM:Float = 0.25;
	static inline var MAX_ZOOM:Float = 8;

	var char:Character;
	var ghost:Character;
	var daAnim:String = 'spooky';
	var isDad:Bool = true;
	var animList:Array<String> = [];
	var curAnim:Int = 0;
	var isPlaying:Bool = true;
	var loopAnim:Bool = true;
	var loopTimer:Float = 0;
	var originalOffsets:Map<String, Array<Float>> = new Map();
	var dirty:Bool = false;
	var exitArmTimer:Float = 0;

	var onionOn:Bool = true;
	var refAnim:String = '';
	var ghostFrame:Int = 0;
	var ghostAlpha:Float = 0.5;
	var ghostInFront:Bool = false;

	var undoStack:Array<AnimDbgSnapshot> = [];
	var redoStack:Array<AnimDbgSnapshot> = [];
	var dragStart:AnimDbgSnapshot = null;

	var camGame:FlxCamera;
	var camHUD:FlxCamera;
	var camFollow:FlxObject;
	var targetZoom:Float = 1;
	var startZoom:Float = 1;

	var prevMX:Int = 0;
	var prevMY:Int = 0;
	var dragging:Bool = false;
	var panning:Bool = false;
	var dragAccX:Float = 0;
	var dragAccY:Float = 0;
	var arrowHold:Float = 0;
	var arrowRepeat:Float = 0;

	var maxRows:Int = 20;
	var listScroll:Int = 0;
	var rowNames:Array<FlxText> = [];
	var rowVals:Array<FlxText> = [];
	var selBar:FlxSprite;
	var hoverBar:FlxSprite;
	var infoX:Float = 0;
	var infoName:FlxText;
	var infoOffset:FlxText;
	var infoFrame:FlxText;
	var infoState:FlxText;
	var toast:FlxText;
	var toastTimer:Float = 0;
	var buttons:Array<AnimDbgButton> = [];

	public function new(daAnim:String = 'spooky')
	{
		super();
		this.daAnim = daAnim;
	}

	override function create()
	{
		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();

		FlxG.mouse.visible = true;

		camGame = FlxG.camera;
		camGame.bgColor = 0xFF14141C;
		camHUD = new FlxCamera();
		camHUD.bgColor = FlxColor.TRANSPARENT;
		FlxG.cameras.add(camHUD, false);

		var grid:FlxSprite = FlxGridOverlay.create(50, 50, 2400, 2400, true, 0xFF22222C, 0xFF1D1D26);
		grid.screenCenter();
		add(grid);

		isDad = (daAnim != 'bf');

		char = createChar();
		char.screenCenter();

		ghost = createChar();
		ghost.setPosition(char.x, char.y);
		ghost.color = 0xFF66D9FF;
		ghost.alpha = ghostAlpha;

		var vLine:FlxSprite = new FlxSprite(char.x - 1, char.y - 1200);
		vLine.makeGraphic(2, 2400, 0x88FF5555);
		add(vLine);
		var hLine:FlxSprite = new FlxSprite(char.x - 1200, char.y - 1);
		hLine.makeGraphic(2400, 2, 0x8855FF55);
		add(hLine);

		add(ghost);
		add(char);

		for (anim in char.animOffsets.keys())
		{
			animList.push(anim);
			var o = char.animOffsets.get(anim);
			originalOffsets.set(anim, [o[0], o[1]]);
		}
		animList.sort(function(a:String, b:String):Int
		{
			var ka = animSortKey(a);
			var kb = animSortKey(b);
			if (ka != kb)
				return ka - kb;
			return a < b ? -1 : (a > b ? 1 : 0);
		});
		refAnim = animList.length > 0 ? animList[0] : '';

		camFollow = new FlxObject(0, 0, 2, 2);
		camFollow.screenCenter();
		add(camFollow);
		camGame.follow(camFollow);
		startZoom = camGame.zoom;
		targetZoom = startZoom;

		buildUI();

		if (animList.length > 0)
		{
			selectAnim(animList.length > 1 ? 1 : 0);
			refreshGhost();
			showToast("Loaded " + animList.length + " animations. Onion skin is ON (reference: " + refAnim + ").", 0xFF9DE0A5);
		}
		else
		{
			showToast("This character has no animations / offsets.", 0xFFFF7777);
		}

		super.create();
	}

	function animSortKey(a:String):Int
	{
		if (a.startsWith('idle'))
			return 0;
		if (a.startsWith('dance'))
			return 1;
		return 2;
	}

	function createChar():Character
	{
		var c:Character;
		if (isDad)
			c = new Character(0, 0, daAnim);
		else
			c = new Boyfriend(0, 0);
		c.debugMode = true;
		c.flipX = false;
		return c;
	}

	function makePanel(x:Float, y:Float, w:Int, h:Int, color:Int):FlxSprite
	{
		var s:FlxSprite = new FlxSprite(x, y);
		s.makeGraphic(w, h, color);
		s.scrollFactor.set();
		s.cameras = [camHUD];
		add(s);
		return s;
	}

	function makeText(x:Float, y:Float, w:Float, size:Int, color:Int = 0xFFFFFFFF):FlxText
	{
		var t:FlxText = new FlxText(x, y, w, "", size);
		t.color = color;
		t.scrollFactor.set();
		t.cameras = [camHUD];
		add(t);
		return t;
	}

	function addButton(label:String, x:Float, y:Float, w:Int, onClick:Void->Void, isOn:Void->Bool = null):Void
	{
		var bg:FlxSprite = makePanel(x, y, w, 28, 0xFFFFFFFF);
		bg.color = 0xFF2A2A3C;
		var t:FlxText = makeText(x, y + 7, w, 13);
		t.alignment = FlxTextAlign.CENTER;
		t.text = label;
		buttons.push({
			bg: bg,
			label: t,
			onClick: onClick,
			isOn: isOn
		});
	}

	function buildUI():Void
	{
		makePanel(0, 0, LIST_W, FlxG.height, 0xE60F0F16);
		var title:FlxText = makeText(12, 10, LIST_W - 24, 18, 0xFFFFD866);
		title.text = "ANIMATIONS - " + daAnim;
		var sub:FlxText = makeText(12, 36, LIST_W - 24, 12, 0xFF8888A0);
		sub.text = "click or W / S to select   (* = changed)";

		maxRows = Std.int((FlxG.height - LIST_TOP - 10) / ROW_H);

		selBar = makePanel(6, LIST_TOP - 1, LIST_W - 12, ROW_H - 2, 0xFF3A5FA0);
		hoverBar = makePanel(6, LIST_TOP - 1, LIST_W - 12, ROW_H - 2, 0x33FFFFFF);
		hoverBar.visible = false;

		for (i in 0...maxRows)
		{
			var n:FlxText = makeText(12, LIST_TOP + i * ROW_H + 3, 210, 14, 0xFFB8B8C8);
			var v:FlxText = makeText(12, LIST_TOP + i * ROW_H + 3, LIST_W - 28, 14, 0xFFB8B8C8);
			v.alignment = FlxTextAlign.RIGHT;
			rowNames.push(n);
			rowVals.push(v);
		}

		infoX = FlxG.width - INFO_W - 10;
		makePanel(infoX, 10, INFO_W, INFO_H, 0xE60F0F16);
		infoName = makeText(infoX + 10, 18, INFO_W - 20, 22, 0xFFFFD866);
		infoOffset = makeText(infoX + 10, 50, INFO_W - 20, 20, 0xFFFFFFFF);
		infoFrame = makeText(infoX + 10, 80, INFO_W - 20, 14, 0xFFB8B8C8);
		infoState = makeText(infoX + 10, 106, INFO_W - 20, 13, 0xFFB8B8C8);

		var bw:Int = Std.int((INFO_W - 30) / 2);
		var bx:Float = infoX + 10;
		var bx2:Float = bx + bw + 10;
		var by:Float = 190;
		addButton("Play / Pause", bx, by, bw, togglePlay, function() return isPlaying);
		addButton("Restart", bx2, by, bw, restartAnim);
		addButton("Onion", bx, by + 36, bw, toggleOnion, function() return onionOn);
		addButton("Set Ref", bx2, by + 36, bw, setRefToCurrent);
		addButton("Loop", bx, by + 72, bw, toggleLoop, function() return loopAnim);
		addButton("Reset Anim", bx2, by + 72, bw, resetCurrent);
		addButton("Undo", bx, by + 108, bw, undo);
		addButton("Redo", bx2, by + 108, bw, redo);
		addButton("Save", bx, by + 144, bw, saveFile);
		addButton("Copy", bx2, by + 144, bw, copyOffsets);

		makePanel(LIST_W, FlxG.height - HINT_H, FlxG.width - LIST_W, HINT_H, 0xE60F0F16);
		var hints:FlxText = makeText(LIST_W + 10, FlxG.height - HINT_H + 6, FlxG.width - LIST_W - 20, 12, 0xFF9A9AB0);
		hints.text = "W/S select anim  |  ARROWS nudge offset (SHIFT = x10)  |  LEFT-DRAG move character  |  WHEEL / Q / E zoom  |  CTRL+DRAG or IJKL pan  |  F reset view\n"
			+ "SPACE play/pause  |  ENTER restart  |  , and . step frames  |  P loop  |  BACKSPACE reset anim  |  CTRL+Z / CTRL+Y undo / redo\n"
			+
			"O onion on/off  |  R use current frame as onion reference  |  1/2 ghost opacity  |  3/4 ghost frame  |  B ghost front/back  |  CTRL+S save  |  CTRL+C copy  |  ESC exit";

		toast = makeText(LIST_W, FlxG.height - HINT_H - 34, FlxG.width - LIST_W - INFO_W - 20, 16, 0xFFFFFFFF);
		toast.alignment = FlxTextAlign.CENTER;
		toast.setBorderStyle(FlxTextBorderStyle.OUTLINE, 0xFF000000, 2);
		toast.alpha = 0;
	}

	function inRect(px:Float, py:Float, x:Float, y:Float, w:Float, h:Float):Bool
	{
		return px >= x && px < x + w && py >= y && py < y + h;
	}

	function isOverUI(mx:Int, my:Int):Bool
	{
		return mx < LIST_W || inRect(mx, my, infoX, 10, INFO_W, INFO_H) || my >= FlxG.height - HINT_H;
	}

	function fmt(v:Float):String
	{
		return Std.string(Math.round(v * 100) / 100);
	}

	function showToast(msg:String, color:Int = 0xFFFFFFFF):Void
	{
		toast.text = msg;
		toast.color = color;
		toastTimer = 2.5;
		toast.alpha = 1;
	}

	function isModified(anim:String):Bool
	{
		var o = char.animOffsets.get(anim);
		var orig = originalOffsets.get(anim);
		if (o == null || orig == null)
			return false;
		var ox:Float = o[0];
		var oy:Float = o[1];
		return ox != orig[0] || oy != orig[1];
	}

	function snapshotOf(anim:String):AnimDbgSnapshot
	{
		var o = char.animOffsets.get(anim);
		var x:Float = o[0];
		var y:Float = o[1];
		return {anim: anim, x: x, y: y};
	}

	function refreshList():Void
	{
		var n:Int = animList.length;
		for (i in 0...maxRows)
		{
			var idx:Int = listScroll + i;
			var nt:FlxText = rowNames[i];
			var vt:FlxText = rowVals[i];
			if (idx >= n)
			{
				nt.visible = false;
				vt.visible = false;
				continue;
			}
			nt.visible = true;
			vt.visible = true;

			var a:String = animList[idx];
			var o = char.animOffsets.get(a);
			var mod:Bool = isModified(a);
			nt.text = a + (a == refAnim ? "  (ref)" : "") + (mod ? " *" : "");
			vt.text = fmt(o[0]) + ", " + fmt(o[1]);

			var c:Int = 0xFFB8B8C8;
			if (mod)
				c = 0xFFFFB84D;
			if (idx == curAnim)
				c = 0xFFFFFFFF;
			nt.color = c;
			vt.color = c;
		}

		var si:Int = curAnim - listScroll;
		selBar.visible = si >= 0 && si < maxRows && n > 0;
		selBar.y = LIST_TOP + si * ROW_H - 1;
	}

	function scrollList(d:Int):Void
	{
		var maxScroll:Float = Math.max(0, animList.length - maxRows);
		listScroll = Std.int(FlxMath.bound(listScroll + d, 0, maxScroll));
		refreshList();
	}

	function ensureVisible():Void
	{
		if (curAnim < listScroll)
			listScroll = curAnim;
		else if (curAnim >= listScroll + maxRows)
			listScroll = curAnim - maxRows + 1;
	}

	function selectAnim(i:Int):Void
	{
		var n:Int = animList.length;
		if (n == 0)
			return;
		curAnim = ((i % n) + n) % n;
		restartAnim();
		ensureVisible();
		refreshList();
	}

	function restartAnim():Void
	{
		if (animList.length == 0)
			return;
		char.playAnim(animList[curAnim], true);
		isPlaying = true;
		loopTimer = 0;
	}

	function togglePlay():Void
	{
		var a = char.animation.curAnim;
		if (a == null)
			return;
		if (isPlaying)
		{
			isPlaying = false;
			a.pause();
		}
		else if (a.finished)
		{
			restartAnim();
		}
		else
		{
			isPlaying = true;
			a.resume();
		}
	}

	function stepFrame(d:Int):Void
	{
		var a = char.animation.curAnim;
		if (a == null)
			return;
		isPlaying = false;
		a.pause();
		var n:Int = a.frames.length;
		a.curFrame = (a.curFrame + d + n) % n;
	}

	function toggleLoop():Void
	{
		loopAnim = !loopAnim;
		showToast("Loop " + (loopAnim ? "ON" : "OFF"));
	}

	function refreshGhost():Void
	{
		var ok:Bool = onionOn && refAnim != '' && ghost.animation.exists(refAnim) && char.animOffsets.exists(refAnim);
		ghost.visible = ok;
		if (!ok)
			return;

		var a = ghost.animation.getByName(refAnim);
		ghostFrame = Std.int(FlxMath.bound(ghostFrame, 0, a.frames.length - 1));
		ghost.animation.play(refAnim, true, false, ghostFrame);
		ghost.animation.pause();

		var o = char.animOffsets.get(refAnim);
		ghost.offset.set(o[0], o[1]);
		ghost.alpha = ghostAlpha;
	}

	function toggleOnion():Void
	{
		onionOn = !onionOn;
		refreshGhost();
		showToast("Onion skin " + (onionOn ? "ON" : "OFF"));
	}

	function setRefToCurrent():Void
	{
		var a = char.animation.curAnim;
		if (a == null || animList.length == 0)
			return;
		refAnim = animList[curAnim];
		ghostFrame = a.curFrame;
		onionOn = true;
		refreshGhost();
		refreshList();
		showToast("Onion reference: " + refAnim + " (frame " + (ghostFrame + 1) + ")", 0xFF9DE0A5);
	}

	function changeGhostAlpha(d:Float):Void
	{
		ghostAlpha = FlxMath.bound(ghostAlpha + d, 0.1, 0.9);
		refreshGhost();
		showToast("Ghost opacity " + Std.int(ghostAlpha * 100) + "%");
	}

	function changeGhostFrame(d:Int):Void
	{
		ghostFrame += d;
		refreshGhost();
		showToast("Ghost frame " + (ghostFrame + 1));
	}

	function toggleGhostLayer():Void
	{
		ghostInFront = !ghostInFront;
		remove(ghost, true);
		var idx:Int = members.indexOf(char);
		insert(ghostInFront ? idx + 1 : idx, ghost);
		showToast("Ghost is " + (ghostInFront ? "in front of" : "behind") + " the character");
	}

	function beginEdit():Void
	{
		if (animList.length == 0)
			return;
		undoStack.push(snapshotOf(animList[curAnim]));
		if (undoStack.length > 300)
			undoStack.shift();
		redoStack = [];
	}

	function moveOffset(dx:Float, dy:Float):Void
	{
		if (animList.length == 0)
			return;
		var o = char.animOffsets.get(animList[curAnim]);
		var x:Float = o[0];
		var y:Float = o[1];
		o[0] = x + dx;
		o[1] = y + dy;
		offsetsChanged();
	}

	function offsetsChanged():Void
	{
		var o = char.animOffsets.get(animList[curAnim]);
		char.offset.set(o[0], o[1]);
		dirty = true;
		exitArmTimer = 0;
		refreshGhost();
		refreshList();
	}

	function resetCurrent():Void
	{
		if (animList.length == 0)
			return;
		var a:String = animList[curAnim];
		if (!isModified(a))
		{
			showToast("Nothing to reset");
			return;
		}
		beginEdit();
		var orig = originalOffsets.get(a);
		var o = char.animOffsets.get(a);
		o[0] = orig[0];
		o[1] = orig[1];
		offsetsChanged();
		showToast("Reset " + a);
	}

	function undo():Void
	{
		if (undoStack.length == 0)
		{
			showToast("Nothing to undo");
			return;
		}
		var s:AnimDbgSnapshot = undoStack.pop();
		redoStack.push(snapshotOf(s.anim));
		applySnapshot(s);
		showToast("Undo");
	}

	function redo():Void
	{
		if (redoStack.length == 0)
		{
			showToast("Nothing to redo");
			return;
		}
		var s:AnimDbgSnapshot = redoStack.pop();
		undoStack.push(snapshotOf(s.anim));
		applySnapshot(s);
		showToast("Redo");
	}

	function applySnapshot(s:AnimDbgSnapshot):Void
	{
		var o = char.animOffsets.get(s.anim);
		o[0] = s.x;
		o[1] = s.y;
		var i:Int = animList.indexOf(s.anim);
		if (i >= 0 && i != curAnim)
			selectAnim(i);
		offsetsChanged();
	}

	function buildOutput():String
	{
		var lines:Array<String> = [];
		for (a in animList)
		{
			var o = char.animOffsets.get(a);
			lines.push(a + " " + fmt(o[0]) + " " + fmt(o[1]));
		}
		return lines.join("\n");
	}

	function copyOffsets():Void
	{
		System.setClipboard(buildOutput());
		showToast("Offsets copied to clipboard", 0xFF9DE0A5);
	}

	var _file:FileReference;

	function saveFile():Void
	{
		var saveString:String = buildOutput();
		if (saveString.length > 0)
		{
			_file = new FileReference();
			_file.addEventListener(Event.COMPLETE, onSaveComplete);
			_file.addEventListener(Event.CANCEL, onSaveCancel);
			_file.addEventListener(IOErrorEvent.IO_ERROR, onSaveError);
			_file.save(saveString, daAnim + "Offsets.txt");
		}
	}

	function cleanupFile():Void
	{
		if (_file == null)
			return;
		_file.removeEventListener(Event.COMPLETE, onSaveComplete);
		_file.removeEventListener(Event.CANCEL, onSaveCancel);
		_file.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
		_file = null;
	}

	function onSaveComplete(_):Void
	{
		cleanupFile();
		dirty = false;
		showToast("Saved " + daAnim + "Offsets.txt", 0xFF9DE0A5);
	}

	function onSaveCancel(_):Void
	{
		cleanupFile();
	}

	function onSaveError(_):Void
	{
		cleanupFile();
		showToast("Problem saving offsets!", 0xFFFF7777);
	}

	override function update(elapsed:Float)
	{
		var mx:Int = FlxG.mouse.screenX;
		var my:Int = FlxG.mouse.screenY;

		handleMouse(mx, my);
		handleKeyboard(elapsed);
		updatePlayback(elapsed);
		updateCamera(elapsed, mx, my);
		updateHud(elapsed, mx, my);

		prevMX = mx;
		prevMY = my;

		super.update(elapsed);
	}

	function handleMouse(mx:Int, my:Int):Void
	{
		var overUI:Bool = isOverUI(mx, my);

		var wheel:Int = FlxG.mouse.wheel;
		if (wheel != 0)
		{
			if (mx < LIST_W)
				scrollList(-wheel);
			else if (!overUI)
				targetZoom = FlxMath.bound(targetZoom * (1 + wheel * 0.1), MIN_ZOOM, MAX_ZOOM);
		}

		if (FlxG.mouse.justPressed)
		{
			var handled:Bool = false;

			for (b in buttons)
			{
				if (inRect(mx, my, b.bg.x, b.bg.y, b.bg.width, b.bg.height))
				{
					b.onClick();
					handled = true;
					break;
				}
			}

			if (!handled && mx < LIST_W)
			{
				if (my >= LIST_TOP && my < LIST_TOP + maxRows * ROW_H)
				{
					var idx:Int = listScroll + Std.int((my - LIST_TOP) / ROW_H);
					if (idx < animList.length)
						selectAnim(idx);
				}
			}
			else if (!handled && !overUI && animList.length > 0)
			{
				if (FlxG.keys.pressed.CONTROL)
				{
					panning = true;
				}
				else
				{
					dragging = true;
					dragAccX = 0;
					dragAccY = 0;
					beginEdit();
					dragStart = snapshotOf(animList[curAnim]);
				}
			}
		}

		#if FLX_MOUSE_ADVANCED
		if ((FlxG.mouse.justPressedMiddle || FlxG.mouse.justPressedRight) && !overUI)
			panning = true;
		#end

		if (dragging)
		{
			if (FlxG.mouse.pressed)
			{
				dragAccX += (mx - prevMX) / camGame.zoom;
				dragAccY += (my - prevMY) / camGame.zoom;
				var sx:Int = Std.int(dragAccX);
				var sy:Int = Std.int(dragAccY);
				if (sx != 0 || sy != 0)
				{
					dragAccX -= sx;
					dragAccY -= sy;
					moveOffset(-sx, -sy);
				}
			}
			else
			{
				dragging = false;
				if (dragStart != null)
				{
					var cur:AnimDbgSnapshot = snapshotOf(dragStart.anim);
					if (cur.x == dragStart.x && cur.y == dragStart.y)
						undoStack.pop();
					dragStart = null;
				}
			}
		}

		if (panning)
		{
			var held:Bool = FlxG.mouse.pressed;
			#if FLX_MOUSE_ADVANCED
			held = held || FlxG.mouse.pressedMiddle || FlxG.mouse.pressedRight;
			#end
			if (held)
			{
				camFollow.x -= (mx - prevMX) / camGame.zoom;
				camFollow.y -= (my - prevMY) / camGame.zoom;
			}
			else
				panning = false;
		}
	}

	function handleKeyboard(elapsed:Float):Void
	{
		var ctrl:Bool = FlxG.keys.pressed.CONTROL;
		var shift:Bool = FlxG.keys.pressed.SHIFT;

		if (FlxG.keys.justPressed.ESCAPE)
		{
			if (dirty && exitArmTimer <= 0)
			{
				exitArmTimer = 3;
				showToast("Unsaved changes! Press ESC again to leave, or CTRL+S to save.", 0xFFFFB84D);
			}
			else
			{
				FlxG.switchState(new MainMenuState());
			}
			return;
		}

		if (ctrl)
		{
			if (FlxG.keys.justPressed.Z)
			{
				if (shift)
					redo();
				else
					undo();
			}
			if (FlxG.keys.justPressed.Y)
				redo();
			if (FlxG.keys.justPressed.S)
				saveFile();
			if (FlxG.keys.justPressed.C)
				copyOffsets();
			return;
		}

		if (animList.length == 0)
			return;

		if (FlxG.keys.justPressed.W)
			selectAnim(curAnim - 1);
		if (FlxG.keys.justPressed.S)
			selectAnim(curAnim + 1);
		if (FlxG.keys.justPressed.SPACE)
			togglePlay();
		if (FlxG.keys.justPressed.ENTER)
			restartAnim();
		if (FlxG.keys.justPressed.COMMA)
			stepFrame(-1);
		if (FlxG.keys.justPressed.PERIOD)
			stepFrame(1);
		if (FlxG.keys.justPressed.P)
			toggleLoop();
		if (FlxG.keys.justPressed.O)
			toggleOnion();
		if (FlxG.keys.justPressed.R)
			setRefToCurrent();
		if (FlxG.keys.justPressed.ONE)
			changeGhostAlpha(-0.1);
		if (FlxG.keys.justPressed.TWO)
			changeGhostAlpha(0.1);
		if (FlxG.keys.justPressed.THREE)
			changeGhostFrame(-1);
		if (FlxG.keys.justPressed.FOUR)
			changeGhostFrame(1);
		if (FlxG.keys.justPressed.B)
			toggleGhostLayer();
		if (FlxG.keys.justPressed.BACKSPACE)
			resetCurrent();

		if (FlxG.keys.justPressed.E)
			targetZoom = FlxMath.bound(targetZoom * 1.25, MIN_ZOOM, MAX_ZOOM);
		if (FlxG.keys.justPressed.Q)
			targetZoom = FlxMath.bound(targetZoom / 1.25, MIN_ZOOM, MAX_ZOOM);
		if (FlxG.keys.justPressed.F)
		{
			targetZoom = startZoom;
			camFollow.screenCenter();
		}

		var panSpeed:Float = 500 * elapsed / camGame.zoom * (shift ? 3 : 1);
		if (FlxG.keys.pressed.I)
			camFollow.y -= panSpeed;
		if (FlxG.keys.pressed.K)
			camFollow.y += panSpeed;
		if (FlxG.keys.pressed.J)
			camFollow.x -= panSpeed;
		if (FlxG.keys.pressed.L)
			camFollow.x += panSpeed;

		var jx:Int = (FlxG.keys.justPressed.LEFT ? 1 : 0) - (FlxG.keys.justPressed.RIGHT ? 1 : 0);
		var jy:Int = (FlxG.keys.justPressed.UP ? 1 : 0) - (FlxG.keys.justPressed.DOWN ? 1 : 0);
		var hx:Int = (FlxG.keys.pressed.LEFT ? 1 : 0) - (FlxG.keys.pressed.RIGHT ? 1 : 0);
		var hy:Int = (FlxG.keys.pressed.UP ? 1 : 0) - (FlxG.keys.pressed.DOWN ? 1 : 0);
		var mult:Int = shift ? 10 : 1;

		if (jx != 0 || jy != 0)
		{
			beginEdit();
			arrowHold = 0;
			arrowRepeat = 0;
			moveOffset(jx * mult, jy * mult);
		}
		else if (hx != 0 || hy != 0)
		{
			arrowHold += elapsed;
			if (arrowHold > 0.4)
			{
				arrowRepeat += elapsed;
				while (arrowRepeat >= 0.03)
				{
					arrowRepeat -= 0.03;
					moveOffset(hx * mult, hy * mult);
				}
			}
		}
		else
		{
			arrowHold = 0;
			arrowRepeat = 0;
		}
	}

	function updatePlayback(elapsed:Float):Void
	{
		var a = char.animation.curAnim;
		if (a == null || !isPlaying || !loopAnim)
			return;

		if (a.finished)
		{
			loopTimer += elapsed;
			if (loopTimer >= 0.45)
			{
				char.playAnim(animList[curAnim], true);
				loopTimer = 0;
			}
		}
		else
			loopTimer = 0;
	}

	function updateCamera(elapsed:Float, mx:Int, my:Int):Void
	{
		camGame.zoom += (targetZoom - camGame.zoom) * Math.min(1, elapsed * 14);
	}

	function updateHud(elapsed:Float, mx:Int, my:Int):Void
	{
		var hover:Int = -1;
		if (mx < LIST_W && my >= LIST_TOP && my < LIST_TOP + maxRows * ROW_H)
		{
			var r:Int = Std.int((my - LIST_TOP) / ROW_H);
			if (listScroll + r < animList.length)
				hover = r;
		}
		hoverBar.visible = hover >= 0;
		if (hover >= 0)
			hoverBar.y = LIST_TOP + hover * ROW_H - 1;

		for (b in buttons)
		{
			var hot:Bool = inRect(mx, my, b.bg.x, b.bg.y, b.bg.width, b.bg.height);
			var on:Bool = b.isOn != null && b.isOn();
			var c:Int = hot ? 0xFF42425F : 0xFF2A2A3C;
			if (on)
				c = hot ? 0xFF3C8A4D : 0xFF2E6B3A;
			b.bg.color = c;
		}
		if (animList.length > 0)
		{
			var name:String = animList[curAnim];
			var o = char.animOffsets.get(name);
			infoName.text = name;
			infoOffset.text = "X: " + fmt(o[0]) + "    Y: " + fmt(o[1]);

			var a = char.animation.curAnim;
			if (a != null)
				infoFrame.text = "Frame " + (a.curFrame + 1) + " / " + a.frames.length + (isPlaying ? "    [playing]" : "    [paused]");
		}
		else
		{
			infoName.text = "(no animations)";
			infoOffset.text = "";
			infoFrame.text = "";
		}

		infoState.text = "Loop: " + (loopAnim ? "ON" : "OFF") + "     Zoom: " + Std.int(camGame.zoom * 100) + "%\n" + "Onion: " + (onionOn ? "ON" : "OFF")
			+ "     ref: " + refAnim + "\n" + "Ghost frame: " + (ghostFrame + 1) + "   opacity: " + Std.int(ghostAlpha * 100) + "%   "
			+ (ghostInFront ? "front" : "back");
		if (toastTimer > 0)
		{
			toastTimer -= elapsed;
			toast.alpha = Math.min(1, toastTimer);
		}
		else
			toast.alpha = 0;

		if (exitArmTimer > 0)
			exitArmTimer -= elapsed;
	}
}
