package;

import Section.SwagSection;
import Song.SwagSong;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUIDropDownMenu;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUINumericStepper;
import flixel.addons.ui.FlxUITabMenu;
import shaderslmfao.ColorSwap;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.sound.FlxSound;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import haxe.Json;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import openfl.geom.Rectangle;
import openfl.net.FileReference;
import Song.CamEvent;
#if sys
import sys.FileSystem;
import sys.io.File;
#end

using StringTools;

class ChartingState extends MusicBeatState
{
	var _file:FileReference;

	var UI_box:FlxUITabMenu;

	var curSection:Int = 0;

	public static var lastSection:Int = 0;

	var bpmTxt:FlxText;
	var statusTxt:FlxText;
	var statusTimer:Float = 0;

	var strumLine:FlxSprite;

	var CAM_X:Int = 0;
	var CAM_W:Int = 44;
	var camRendered:FlxTypedGroup<FlxSprite>;
	var curCamTarget:Int = 0;

	var curSelectedCam:CamEvent = null;
	var camEaseName:String = "CLASSIC";
	var camDurSteps:Float = 4;
	var camOffX:Float = 0;
	var camOffY:Float = 0;
	var updatingCamUI:Bool = false;
	var dropCamEase:FlxUIDropDownMenu;
	var stepperCamDur:FlxUINumericStepper;
	var stepperCamX:FlxUINumericStepper;
	var stepperCamY:FlxUINumericStepper;
	var camSelTxt:FlxText;

	var strumSprites:Array<FlxSprite> = [];
	var strumLit:Array<Bool> = [];
	var strumFlash:Array<Float> = [];
	var strumHoldUntil:Array<Float> = [];

	static var STRUM_DIRS:Array<String> = ['LEFT', 'DOWN', 'UP', 'RIGHT'];
	static var STRUM_NAMES:Array<String> = ['left', 'down', 'up', 'right'];

	static var CAM_EASES:Array<String> = [
		"CLASSIC",
		"INSTANT",
		"linear",
		"quadIn",
		"quadOut",
		"quadInOut",
		"cubeIn",
		"cubeOut",
		"cubeInOut",
		"sineIn",
		"sineOut",
		"sineInOut",
		"expoIn",
		"expoOut",
		"expoInOut",
		"smoothStepIn",
		"smoothStepOut",
		"smoothStepInOut",
		"smootherStepInOut",
		"backOut",
		"elasticOut",
		"bounceOut"
	];

	var GRID_SIZE:Int = 40;
	var GRID_W:Int = 320;
	var CHUNK_H:Int = 640;
	var GRID_X:Int = 160;
	var PLAYER_ON_RIGHT:Bool = true;
	var STRUM_SCREEN_Y:Int = 250;
	var dummyArrow:FlxSprite;
	var curRenderedNotes:FlxTypedGroup<Note>;
	var curRenderedSustains:FlxTypedGroup<FlxSprite>;
	var altAnimTexts:FlxTypedGroup<FlxText>;
	var noteLookup:Map<Note, Array<Dynamic>> = new Map<Note, Array<Dynamic>>();
	var noteSecLookup:Map<Note, Int> = new Map<Note, Int>();
	var gridGroup:FlxGroup;
	var gridChunks:Array<FlxSprite> = [];
	var markerLines:Array<FlxSprite> = [];
	var markerLabels:Array<FlxText> = [];
	var dirtyNotes:Bool = true;
	var renderedTop:Float = 1e9;
	var renderedBottom:Float = -1e9;
	var secTimes:Array<Float> = [];
	var secSteps:Array<Float> = [];
	var secStepMs:Array<Float> = [];
	var endTime:Float = 0;
	var endStep:Float = 0;
	var lastBpm:Float = 100;

	var songEndY:Float = 0;

	var _song:SwagSong;

	var typingShit:FlxUIInputText;

	var curSelectedNote:Array<Dynamic>;

	var curSelectedSec:Int = 0;

	var vocals:FlxSound;
	var playerVocals:FlxSound;

	var splitVocals:Bool = false;
	var muteOppVocals:Bool = false;
	var mutePlayerVocals:Bool = false;

	var hitsoundSide:Int = 0;

	var leftIcon:HealthIcon;
	var rightIcon:HealthIcon;

	var quantList:Array<Int> = [4, 8, 12, 16, 20, 24, 32, 48, 64, 96, 192];
	var quantIdx:Int = 3;

	var hitsoundsEnabled:Bool = false;
	var hitsoundPath:String = "";
	var lastHitTime:Float = 0;
	var playbackRate:Float = 1;

	var undoStack:Array<Array<Array<Dynamic>>> = [];
	var redoStack:Array<Array<Array<Dynamic>>> = [];

	var steppers:Array<FlxUINumericStepper> = [];
	var scrollHold:Float = 0;
	var autosaveTimer:Float = 0;

	var totalNotes:Int = 0;

	var curNoteType:Int = 0;
	var dropNoteType:FlxUIDropDownMenu;

	static var CUSTOM_TYPES:Array<String> = ['', 'begin', 'whisper', 'yell'];

	var curCustomType:String = '';
	var dropCustomType:FlxUIDropDownMenu;

	static inline var HELP_TEXT:String = "Click: place / remove note (right click removes too)\n"
		+ "Ctrl+Click on note: select | Ctrl+Click empty: both sides\n"
		+ "Space: play / pause | W/S / mouse wheel: scroll\n"
		+ "A/D: jump section (Shift = 4) | Left/Right: snap\n"
		+ "Q/E: sustain | X: alt anim | Delete: remove selected note\n"
		+ "Ctrl+Z / Ctrl+Y: undo / redo | Ctrl+S: save\n"
		+ "Enter: playtest | R: section start (Shift = song start)\n"
		+ "Camera lane (right of grid): click = new event / change target, right click = remove, 1/2/3 = Dad/BF/GF\n"
		+ "Ctrl+Click on a camera event: select it, then set ease / duration / offset in the Camera tab\n";

	override function create()
	{
		GRID_W = GRID_SIZE * 8;
		CHUNK_H = GRID_SIZE * 16;
		GRID_X = Std.int((FlxG.width / 2 - GRID_W) / 2);
		CAM_X = GRID_X + GRID_W + 6;

		altAnimTexts = new FlxTypedGroup<FlxText>();

		if (PlayState.SONG != null)
			_song = PlayState.SONG;
		else
		{
			_song = {
				song: 'Test',
				notes: [],
				bpm: 150,
				needsVoices: true,
				player1: 'bf',
				player2: 'dad',
				speed: 1,
				validScore: false
			};
		}

		if (_song.notes == null)
			_song.notes = [];

		lastBpm = _song.bpm;
		if (_song.notes.length == 0)
			addSection();

		Song.migrateCameraEvents(_song);

		rebuildTempo();
		Conductor.changeBPM(_song.bpm);
		Conductor.mapBPMChanges(_song);

		gridGroup = new FlxGroup();
		add(gridGroup);
		buildGridChunks();

		for (i in 0...12)
		{
			var line:FlxSprite = new FlxSprite(GRID_X, 0).makeGraphic(GRID_W, 2, 0xFF3B82F6);
			line.visible = false;
			add(line);
			markerLines.push(line);

			var label:FlxText = new FlxText(6, 0, GRID_X - 12, "", 12);
			label.color = 0xFF94A3B8;
			label.visible = false;
			add(label);
			markerLabels.push(label);
		}

		leftIcon = new HealthIcon('bf');
		rightIcon = new HealthIcon('dad');
		leftIcon.scrollFactor.set();
		rightIcon.scrollFactor.set();

		leftIcon.setGraphicSize(0, 45);
		rightIcon.setGraphicSize(0, 45);
		leftIcon.updateHitbox();
		rightIcon.updateHitbox();

		leftIcon.setPosition(GRID_X, 0);
		rightIcon.setPosition(GRID_X + GRID_W / 2, 0);

		curRenderedNotes = new FlxTypedGroup<Note>();
		curRenderedSustains = new FlxTypedGroup<FlxSprite>();

		FlxG.mouse.visible = true;

		hitsoundPath = Paths.sound('hitSound');
		if (!openfl.utils.Assets.exists(hitsoundPath))
			hitsoundPath = Paths.sound('scrollMenu');

		loadSong(_song.song);

		strumLine = new FlxSprite(GRID_X, 0).makeGraphic(GRID_W, 3, 0xFF38BDF8);
		add(strumLine);

		buildStrums();

		dummyArrow = new FlxSprite().makeGraphic(GRID_SIZE, GRID_SIZE);
		dummyArrow.alpha = 0.4;
		add(dummyArrow);

		add(curRenderedSustains);
		add(curRenderedNotes);
		add(altAnimTexts);

		var camBg:FlxSprite = new FlxSprite(CAM_X, 0).makeGraphic(CAM_W, FlxG.height, 0xAA0F172A);
		camBg.scrollFactor.set();
		add(camBg);

		var camLabel:FlxText = new FlxText(CAM_X - 4, 0, CAM_W + 8, "Camera", 10);
		camLabel.color = 0xFF94A3B8;
		camLabel.alignment = CENTER;
		camLabel.scrollFactor.set();
		add(camLabel);

		camRendered = new FlxTypedGroup<FlxSprite>();
		add(camRendered);

		add(leftIcon);
		add(rightIcon);

		bpmTxt = new FlxText(1000, 50, 0, "", 14);
		bpmTxt.color = 0xFFE2E8F0;
		bpmTxt.scrollFactor.set();
		add(bpmTxt);

		statusTxt = new FlxText(10, FlxG.height - 40, 0, "", 16);
		statusTxt.scrollFactor.set();
		statusTxt.color = 0xFF38BDF8;
		add(statusTxt);

		var tabs = [
			{name: "Song", label: 'Song'},
			{name: "Section", label: 'Section'},
			{name: "Note", label: 'Note'},
			{name: "Camera", label: 'Camera'}
		];

		UI_box = new FlxUITabMenu(null, tabs, true);

		UI_box.resize(300, 400);
		UI_box.x = FlxG.width / 2;
		UI_box.y = 20;
		add(UI_box);

		addSongUI();
		addSectionUI();
		addNoteUI();
		addCameraUI();

		if (lastSection > 0 && lastSection < _song.notes.length)
			seek(secTimes[lastSection]);

		curSection = sectionAtTime(FlxG.sound.music.time);
		applyConductorBPM();
		updateSectionUI();

		super.create();
	}

	override function destroy()
	{
		if (FlxG.sound.music != null)
			FlxG.sound.music.pitch = 1;
		super.destroy();
	}

	function camName(t:Int):String
		return ["Dad", "BF", "GF"][t];

	function camColor(t:Int):Int
		return [0xFFEF4444, 0xFF3B82F6, 0xFFEC4899][t];

	function rebuildTempo():Void
	{
		secTimes = [];
		secSteps = [];
		secStepMs = [];

		var t:Float = 0;
		var s:Float = 0;
		var bpm:Float = _song.bpm;

		for (sec in _song.notes)
		{
			if (sec.changeBPM && sec.bpm > 0)
				bpm = sec.bpm;

			var ms:Float = 15000 / bpm;

			secTimes.push(t);
			secSteps.push(s);
			secStepMs.push(ms);

			t += sec.lengthInSteps * ms;
			s += sec.lengthInSteps;
		}

		endTime = t;
		endStep = s;
		lastBpm = bpm;
	}

	function tempoChanged():Void
	{
		rebuildTempo();
		Conductor.mapBPMChanges(_song);
		applyConductorBPM();
		dirtyNotes = true;
	}

	function applyConductorBPM():Void
	{
		if (curSection >= 0 && curSection < secStepMs.length)
			Conductor.changeBPM(15000 / secStepMs[curSection]);
	}

	function sectionAtTime(t:Float):Int
	{
		var lo:Int = 0;
		var hi:Int = secTimes.length - 1;
		while (lo < hi)
		{
			var mid:Int = (lo + hi + 1) >> 1;
			if (secTimes[mid] <= t)
				lo = mid;
			else
				hi = mid - 1;
		}
		return lo;
	}

	function sectionAtStep(st:Float):Int
	{
		var lo:Int = 0;
		var hi:Int = secSteps.length - 1;
		while (lo < hi)
		{
			var mid:Int = (lo + hi + 1) >> 1;
			if (secSteps[mid] <= st)
				lo = mid;
			else
				hi = mid - 1;
		}
		return lo;
	}

	function timeToStep(t:Float):Float
	{
		var i:Int = sectionAtTime(t);
		return secSteps[i] + (t - secTimes[i]) / secStepMs[i];
	}

	function stepToTime(st:Float):Float
	{
		var i:Int = sectionAtStep(st);
		return secTimes[i] + (st - secSteps[i]) * secStepMs[i];
	}

	function timeToY(t:Float):Float
	{
		return timeToStep(t) * GRID_SIZE;
	}

	function yToTime(y:Float):Float
	{
		return stepToTime(y / GRID_SIZE);
	}

	function ensureSectionFor(t:Float):Void
	{
		var guard:Int = 0;
		while (t >= endTime && guard < 5000)
		{
			addSection();
			rebuildTempo();
			guard++;
		}
	}

	private function addSection(lengthInSteps:Int = 16):Void
	{
		var prev:SwagSection = (_song.notes.length > 0) ? _song.notes[_song.notes.length - 1] : null;

		var sec:SwagSection = {
			lengthInSteps: lengthInSteps,
			bpm: lastBpm,
			changeBPM: false,
			mustHitSection: (prev != null) ? prev.mustHitSection : true,
			sectionNotes: [],
			typeOfSection: 0,
			altAnim: false
		};

		_song.notes.push(sec);
	}

	function buildGridChunks():Void
	{
		var base:FlxSprite = FlxGridOverlay.create(GRID_SIZE, GRID_SIZE, GRID_W, CHUNK_H, true, 0xFF090D16, 0xFF0F172A);

		var bd = base.pixels;
		for (b in 0...4)
		{
			var thick:Int = (b == 0) ? 2 : 1;
			var col:Int = (b == 0) ? 0xFF1E293B : 0xFF111827;
			bd.fillRect(new Rectangle(0, b * 4 * GRID_SIZE, GRID_W, thick), col);
		}
		bd.fillRect(new Rectangle(GRID_W / 2 - 1, 0, 2, CHUNK_H), 0xFF030712);
		base.pixels = bd;

		var needed:Int = Std.int(Math.ceil(FlxG.height / CHUNK_H)) + 2;

		for (i in 0...needed)
		{
			var chunk:FlxSprite = (i == 0) ? base : new FlxSprite().loadGraphicFromSprite(base);
			chunk.x = GRID_X;
			gridGroup.add(chunk);
			gridChunks.push(chunk);
		}
	}

	function updateGridChunks(camTop:Float):Void
	{
		var first:Int = Math.floor(camTop / CHUNK_H);

		for (i in 0...gridChunks.length)
		{
			var chunk:FlxSprite = gridChunks[i];
			chunk.y = (first + i) * CHUNK_H;

			chunk.visible = (chunk.y + CHUNK_H > 0) && (chunk.y < songEndY);
		}
	}

	function updateSectionMarkers(camTop:Float, camBottom:Float):Void
	{
		var first:Int = sectionAtTime(yToTime(camTop));
		var last:Int = sectionAtTime(yToTime(camBottom));
		var count:Int = 0;

		for (i in first...(last + 1))
		{
			if (count >= markerLines.length)
				break;

			var y:Float = timeToY(secTimes[i]);
			var sec:SwagSection = _song.notes[i];

			var line:FlxSprite = markerLines[count];
			line.visible = true;
			line.y = y - 1;

			var txt:String = "Section " + i + "\nLanes: " + (sec.mustHitSection ? _song.player1 : _song.player2);
			if (sec.changeBPM)
				txt += "\nBPM " + sec.bpm;

			var label:FlxText = markerLabels[count];
			label.visible = true;
			label.y = y - 1;
			if (label.text != txt)
				label.text = txt;

			count++;
		}

		for (i in count...markerLines.length)
		{
			markerLines[i].visible = false;
			markerLabels[i].visible = false;
		}
	}

	function wipe<T:FlxBasic>(group:FlxTypedGroup<T>):Void
	{
		for (m in group.members)
			if (m != null)
				m.destroy();
		group.clear();
	}

	function refreshNotes(top:Float, bottom:Float):Void
	{
		dirtyNotes = false;
		renderedTop = top;
		renderedBottom = bottom;

		wipe(curRenderedNotes);
		wipe(curRenderedSustains);
		wipe(altAnimTexts);
		wipe(camRendered);
		noteLookup.clear();
		noteSecLookup.clear();

		var tMin:Float = yToTime(top);
		var tMax:Float = yToTime(bottom);

		totalNotes = 0;

		for (si in 0..._song.notes.length)
		{
			var sec:SwagSection = _song.notes[si];
			totalNotes += sec.sectionNotes.length;

			for (n in sec.sectionNotes)
			{
				var arr:Array<Dynamic> = n;
				var strumTime:Float = arr[0];
				var lane:Int = Std.int(arr[1]);
				var sus:Float = (arr[2] == null) ? 0 : arr[2];

				if (strumTime > tMax || strumTime + sus < tMin)
					continue;

				var startStep:Float = timeToStep(strumTime);

				var note:Note = new Note(strumTime, lane % 4);
				note.sustainLength = sus;
				note.setGraphicSize(GRID_SIZE, GRID_SIZE);
				note.updateHitbox();
				note.x = GRID_X + laneToCol(lane, sec.mustHitSection) * GRID_SIZE;
				note.y = Math.floor(startStep * GRID_SIZE);

				if (arr == curSelectedNote)
					note.color = 0xFFFACC15;

				curRenderedNotes.add(note);
				noteLookup.set(note, arr);
				noteSecLookup.set(note, si);

				if (sus > 0)
				{
					var susSteps:Float = timeToStep(strumTime + sus) - startStep;
					var susHeight:Int = Std.int(Math.max(1, susSteps * GRID_SIZE));
					var sustainVis:FlxSprite = new FlxSprite(note.x + (GRID_SIZE / 2) - 4, note.y + GRID_SIZE / 2).makeGraphic(8, susHeight, 0xFF38BDF8);
					sustainVis.alpha = 0.5;
					curRenderedSustains.add(sustainVis);
				}

				var type:Int = getNoteType(arr);
				if (type != 0)
				{
					var altText:FlxText = new FlxText(note.x, note.y, GRID_SIZE, (type == 1) ? "1" : "N", 16);
					altText.alignment = CENTER;
					altText.color = FlxColor.WHITE;
					altAnimTexts.add(altText);
				}
				var ct:String = getCustomType(arr);
				if (ct != '')
				{
					var ctText:FlxText = new FlxText(note.x, note.y + GRID_SIZE - 14, GRID_SIZE, ct.substr(0, 4), 10);
					ctText.alignment = CENTER;
					ctText.color = 0xFF38BDF8;
					altAnimTexts.add(ctText);
				}
				if (type == 2 && arr != curSelectedNote)
					note.alpha = 0.5;
			}
		}

		for (ev in _song.cameraEvents)
		{
			var isTween:Bool = Song.camIsTween(ev);
			var dur:Float = isTween ? Song.camDuration(ev) : 0;
			var endT:Float = (dur > 0) ? stepToTime(timeToStep(ev.time) + dur) : ev.time;

			if (ev.time > tMax || endT < tMin)
				continue;

			var evY:Float = Math.floor(timeToStep(ev.time) * GRID_SIZE);

			if (dur > 0)
			{
				var bar:FlxSprite = new FlxSprite(CAM_X + CAM_W - 7, evY).makeGraphic(5, Std.int(Math.max(1, dur * GRID_SIZE)), camColor(ev.target));
				bar.alpha = 0.5;
				camRendered.add(bar);
			}

			if (ev == curSelectedCam)
			{
				var outline:FlxSprite = new FlxSprite(CAM_X - 2, evY - 1).makeGraphic(CAM_W + 4, GRID_SIZE, 0xFFFACC15);
				camRendered.add(outline);
			}

			var spr:FlxSprite = new FlxSprite(CAM_X, evY).makeGraphic(CAM_W, GRID_SIZE - 2, camColor(ev.target));
			spr.alpha = 0.85;
			camRendered.add(spr);

			var txt:FlxText = new FlxText(CAM_X, spr.y + (isTween ? 4 : 12), CAM_W, camName(ev.target), 12);
			txt.color = 0xFFFFFFFF;
			txt.alignment = CENTER;
			camRendered.add(txt);

			if (isTween)
			{
				var easeTxt:FlxText = new FlxText(CAM_X, spr.y + 22, CAM_W, ev.ease, 8);
				easeTxt.color = 0xFFE2E8F0;
				easeTxt.alignment = CENTER;
				camRendered.add(easeTxt);
			}
		}
	}

	function mouseWX():Float
	{
		return FlxG.mouse.screenX + FlxG.camera.scroll.x;
	}

	function mouseWY():Float
	{
		return FlxG.mouse.screenY + FlxG.camera.scroll.y;
	}

	function mouseInGrid(mx:Float, my:Float):Bool
	{
		return mx >= GRID_X && mx < GRID_X + GRID_W && my >= 0 && my < songEndY;
	}

	function laneToCol(lane:Int, mustHit:Bool):Int
	{
		var swap:Bool = (mustHit == PLAYER_ON_RIGHT);
		return swap ? (lane + 4) % 8 : lane;
	}

	function snappedStep(my:Float):Float
	{
		var step:Float = my / GRID_SIZE;
		if (FlxG.keys.pressed.SHIFT)
			return step;

		var snapSteps:Float = 16 / quant();
		return Math.floor(step / snapSteps) * snapSteps;
	}

	function addSongUI():Void
	{
		var UI_songTitle = new FlxUIInputText(10, 10, 70, _song.song, 8);
		typingShit = UI_songTitle;

		var check_voices = new FlxUICheckBox(10, 25, null, null, "Has voice track", 100);
		check_voices.checked = _song.needsVoices;
		check_voices.callback = function()
		{
			_song.needsVoices = check_voices.checked;
		};

		var check_mute_inst = new FlxUICheckBox(10, 200, null, null, "Mute Instrumental (in editor)", 100);
		check_mute_inst.checked = false;
		check_mute_inst.callback = function()
		{
			FlxG.sound.music.volume = check_mute_inst.checked ? 0 : 1;
		};

		var check_hitsounds = new FlxUICheckBox(10, 225, null, null, "Hitsounds (in editor)", 100);
		check_hitsounds.checked = hitsoundsEnabled;
		check_hitsounds.callback = function()
		{
			hitsoundsEnabled = check_hitsounds.checked;
		};

		var saveButton:FlxButton = new FlxButton(110, 8, "Save", function()
		{
			saveLevel();
		});

		var reloadSong:FlxButton = new FlxButton(saveButton.x + saveButton.width + 10, saveButton.y, "Reload Audio", function()
		{
			loadSong(_song.song);
		});

		var reloadSongJson:FlxButton = new FlxButton(reloadSong.x, saveButton.y + 30, "Reload JSON", function()
		{
			loadJson(_song.song.toLowerCase());
		});

		var loadAutosaveBtn:FlxButton = new FlxButton(reloadSongJson.x, reloadSongJson.y + 30, 'Load autosave', loadAutosave);

		var stepperSpeed:FlxUINumericStepper = new FlxUINumericStepper(10, 80, 0.1, 1, 0.1, 10, 2);
		stepperSpeed.value = _song.speed;
		stepperSpeed.name = 'song_speed';
		steppers.push(stepperSpeed);

		var stepperBPM:FlxUINumericStepper = new FlxUINumericStepper(10, 65, 1, 100, 1, 999, 3);
		stepperBPM.value = _song.bpm;
		stepperBPM.name = 'song_bpm';
		steppers.push(stepperBPM);

		var stepperRate:FlxUINumericStepper = new FlxUINumericStepper(10, 135, 0.25, 1, 0.25, 3, 2);
		stepperRate.value = playbackRate;
		stepperRate.name = 'song_rate';
		steppers.push(stepperRate);

		var characters:Array<String> = Character.getCharacterList();
		if (characters.length == 0)
			return;

		var player1DropDown = new FlxUIDropDownMenu(10, 100, FlxUIDropDownMenu.makeStrIdLabelArray(characters, true), function(character:String)
		{
			_song.player1 = characters[Std.parseInt(character)];
			updateHeads();
		});
		player1DropDown.selectedLabel = _song.player1;

		var player2DropDown = new FlxUIDropDownMenu(140, 100, FlxUIDropDownMenu.makeStrIdLabelArray(characters, true), function(character:String)
		{
			_song.player2 = characters[Std.parseInt(character)];
			updateHeads();
		});
		player2DropDown.selectedLabel = _song.player2;

		var check_mute_opp = new FlxUICheckBox(10, 160, null, null, "Mute opponent vocals", 120);
		check_mute_opp.checked = muteOppVocals;
		check_mute_opp.callback = function()
		{
			muteOppVocals = check_mute_opp.checked;
			applyVocalMute();
			if (!splitVocals)
				showStatus("This song has no split vocals");
		};

		var check_mute_player = new FlxUICheckBox(10, 180, null, null, "Mute player vocals", 120);
		check_mute_player.checked = mutePlayerVocals;
		check_mute_player.callback = function()
		{
			mutePlayerVocals = check_mute_player.checked;
			applyVocalMute();
			if (!splitVocals)
				showStatus("This song has no split vocals");
		};

		var hitsoundSideNames:Array<String> = ["Both", "Opponent only", "Player only"];
		var dropHitsoundSide = new FlxUIDropDownMenu(150, 222, FlxUIDropDownMenu.makeStrIdLabelArray(hitsoundSideNames, true), function(id:String)
		{
			hitsoundSide = Std.parseInt(id);
		});
		dropHitsoundSide.selectedLabel = hitsoundSideNames[hitsoundSide];

		var tab_group_song = new FlxUI(null, UI_box);
		tab_group_song.name = "Song";
		tab_group_song.add(UI_songTitle);

		tab_group_song.add(check_voices);
		tab_group_song.add(check_mute_inst);
		tab_group_song.add(check_hitsounds);
		tab_group_song.add(saveButton);
		tab_group_song.add(reloadSong);
		tab_group_song.add(reloadSongJson);
		tab_group_song.add(loadAutosaveBtn);
		tab_group_song.add(stepperBPM);
		tab_group_song.add(stepperSpeed);
		tab_group_song.add(stepperRate);

		var txtBpm = new FlxText(stepperBPM.x + 70, stepperBPM.y, 0, "BPM", 8);
		txtBpm.color = 0xFFE2E8F0;
		tab_group_song.add(txtBpm);
		var txtSpd = new FlxText(stepperSpeed.x + 70, stepperSpeed.y, 0, "Scroll speed", 8);
		txtSpd.color = 0xFFE2E8F0;
		tab_group_song.add(txtSpd);
		var txtRat = new FlxText(stepperRate.x + 70, stepperRate.y, 0, "Playback rate", 8);
		txtRat.color = 0xFFE2E8F0;
		tab_group_song.add(txtRat);
		var txtHelp = new FlxText(10, 255, 280, HELP_TEXT, 8);
		txtHelp.color = 0xFF94A3B8;
		tab_group_song.add(txtHelp);

		tab_group_song.add(check_mute_opp);
		tab_group_song.add(check_mute_player);
		tab_group_song.add(player1DropDown);
		tab_group_song.add(player2DropDown);
		tab_group_song.add(dropHitsoundSide);

		UI_box.addGroup(tab_group_song);
		UI_box.scrollFactor.set();
	}

	var stepperLength:FlxUINumericStepper;
	var check_mustHitSection:FlxUICheckBox;
	var check_changeBPM:FlxUICheckBox;
	var stepperSectionBPM:FlxUINumericStepper;
	var check_altAnim:FlxUICheckBox;

	function addSectionUI():Void
	{
		var tab_group_section = new FlxUI(null, UI_box);
		tab_group_section.name = 'Section';

		stepperLength = new FlxUINumericStepper(10, 10, 4, 16, 4, 999, 0);
		stepperLength.value = 16;
		stepperLength.name = "section_length";
		steppers.push(stepperLength);

		stepperSectionBPM = new FlxUINumericStepper(10, 80, 1, _song.bpm, 1, 999, 3);
		stepperSectionBPM.value = _song.bpm;
		stepperSectionBPM.name = 'section_bpm';
		steppers.push(stepperSectionBPM);

		var stepperCopy:FlxUINumericStepper = new FlxUINumericStepper(110, 130, 1, 1, 1, 999, 0);
		steppers.push(stepperCopy);

		var copyButton:FlxButton = new FlxButton(10, 130, "Copy last section", function()
		{
			copySection(Std.int(stepperCopy.value));
		});

		var clearSectionButton:FlxButton = new FlxButton(10, 150, "Clear", clearSection);

		var swapSection:FlxButton = new FlxButton(10, 170, "Swap section", function()
		{
			pushUndo();
			for (n in _song.notes[curSection].sectionNotes)
			{
				var arr:Array<Dynamic> = n;
				arr[1] = (Std.int(arr[1]) + 4) % 8;
			}
			dirtyNotes = true;
			autosaveSong();
		});

		check_mustHitSection = new FlxUICheckBox(10, 30, null, null, "Must hit section", 100);
		check_mustHitSection.name = 'check_mustHit';
		check_mustHitSection.checked = true;

		check_altAnim = new FlxUICheckBox(10, 105, null, null, "Alt Animation", 100);
		check_altAnim.name = 'check_altAnim';

		check_changeBPM = new FlxUICheckBox(10, 60, null, null, 'Change BPM', 100);
		check_changeBPM.name = 'check_changeBPM';

		tab_group_section.add(stepperLength);
		var txtLen = new FlxText(stepperLength.x + 70, stepperLength.y, 0, "Length (steps)", 8);
		txtLen.color = 0xFFE2E8F0;
		tab_group_section.add(txtLen);
		tab_group_section.add(stepperSectionBPM);
		tab_group_section.add(stepperCopy);
		tab_group_section.add(check_mustHitSection);
		tab_group_section.add(check_altAnim);
		tab_group_section.add(check_changeBPM);
		tab_group_section.add(copyButton);
		tab_group_section.add(clearSectionButton);
		tab_group_section.add(swapSection);
		var txtSecInfo = new FlxText(10, 200, 280, "These settings apply to the section the strum line is currently in.", 8);
		txtSecInfo.color = 0xFF94A3B8;
		tab_group_section.add(txtSecInfo);

		UI_box.addGroup(tab_group_section);
	}

	var stepperSusLength:FlxUINumericStepper;

	var check_noteAltAnim:FlxUICheckBox;

	function addNoteUI():Void
	{
		var tab_group_note = new FlxUI(null, UI_box);
		tab_group_note.name = 'Note';

		stepperSusLength = new FlxUINumericStepper(10, 10, Conductor.stepCrochet / 2, 0, 0, Conductor.stepCrochet * 16);
		stepperSusLength.value = 0;
		stepperSusLength.name = 'note_susLength';
		steppers.push(stepperSusLength);

		check_noteAltAnim = new FlxUICheckBox(10, 40, null, null, "Alt Animation Note", 100);
		check_noteAltAnim.name = 'check_noteAltAnim';

		tab_group_note.add(stepperSusLength);
		var txtSus = new FlxText(stepperSusLength.x + 80, stepperSusLength.y, 0, "Sustain (ms)", 8);
		txtSus.color = 0xFFE2E8F0;
		tab_group_note.add(txtSus);
		tab_group_note.add(check_noteAltAnim);

		UI_box.addGroup(tab_group_note);

		var noteTypeNames:Array<String> = ["Normal", "Alt Animation", "No Animation"];
		dropNoteType = new FlxUIDropDownMenu(10, 90, FlxUIDropDownMenu.makeStrIdLabelArray(noteTypeNames, true), function(id:String)
		{
			curNoteType = Std.parseInt(id);
		});
		dropNoteType.selectedLabel = noteTypeNames[0];

		var txtPlace = new FlxText(10, 75, 0, "Place new notes as:", 8);
		txtPlace.color = 0xFFE2E8F0;
		tab_group_note.add(txtPlace);
		tab_group_note.add(dropNoteType);

		var txtCust = new FlxText(10, 125, 0, "Custom note type:", 8);
		txtCust.color = 0xFFE2E8F0;
		tab_group_note.add(txtCust);
		tab_group_note.add(new FlxButton(150, 140, "Set on selected", function()
		{
			if (curSelectedNote != null)
			{
				pushUndo();
				setCustomType(curSelectedNote, curCustomType);
				dirtyNotes = true;
			}
		}));
		dropCustomType = new FlxUIDropDownMenu(10, 140, FlxUIDropDownMenu.makeStrIdLabelArray(CUSTOM_TYPES, true), function(id:String)
		{
			curCustomType = CUSTOM_TYPES[Std.parseInt(id)];
		});
		dropCustomType.selectedLabel = CUSTOM_TYPES[0];
		tab_group_note.add(dropCustomType);
	}

	function addCameraUI():Void
	{
		var tab_group_cam = new FlxUI(null, UI_box);
		tab_group_cam.name = 'Camera';

		camSelTxt = new FlxText(10, 10, 280, "", 8);
		camSelTxt.color = 0xFFE2E8F0;

		stepperCamDur = new FlxUINumericStepper(10, 85, 1, camDurSteps, 0, 256, 1);
		stepperCamDur.value = camDurSteps;
		stepperCamDur.name = 'cam_duration';
		steppers.push(stepperCamDur);

		stepperCamX = new FlxUINumericStepper(10, 115, 10, camOffX, -3000, 3000, 0);
		stepperCamX.value = camOffX;
		stepperCamX.name = 'cam_x';
		steppers.push(stepperCamX);

		stepperCamY = new FlxUINumericStepper(10, 145, 10, camOffY, -3000, 3000, 0);
		stepperCamY.value = camOffY;
		stepperCamY.name = 'cam_y';
		steppers.push(stepperCamY);

		tab_group_cam.add(camSelTxt);
		var txtEaseInfo = new FlxText(10, 30, 280, "Ease (CLASSIC = normal lerp follow, everything else = tween like V-Slice)", 8);
		txtEaseInfo.color = 0xFF94A3B8;
		tab_group_cam.add(txtEaseInfo);
		tab_group_cam.add(stepperCamDur);
		var txtDur = new FlxText(stepperCamDur.x + 70, stepperCamDur.y, 0, "Duration (steps)", 8);
		txtDur.color = 0xFFE2E8F0;
		tab_group_cam.add(txtDur);
		tab_group_cam.add(stepperCamX);
		var txtOffX = new FlxText(stepperCamX.x + 70, stepperCamX.y, 0, "Offset X", 8);
		txtOffX.color = 0xFFE2E8F0;
		tab_group_cam.add(txtOffX);
		tab_group_cam.add(stepperCamY);
		var txtOffY = new FlxText(stepperCamY.x + 70, stepperCamY.y, 0, "Offset Y", 8);
		txtOffY.color = 0xFFE2E8F0;
		tab_group_cam.add(txtOffY);
		var txtDurInfo = new FlxText(10, 180, 280,
			"Duration / offset only matter for tween eases. INSTANT = hard cut. " + "Changes apply to the selected event, new events use the current values.",
			8);
		txtDurInfo.color = 0xFF94A3B8;
		tab_group_cam.add(txtDurInfo);

		dropCamEase = new FlxUIDropDownMenu(10, 55, FlxUIDropDownMenu.makeStrIdLabelArray(CAM_EASES, true), function(id:String)
		{
			if (updatingCamUI)
				return;

			camEaseName = CAM_EASES[Std.parseInt(id)];
			applyCamUI();
		});
		dropCamEase.selectedLabel = camEaseName;
		tab_group_cam.add(dropCamEase);

		UI_box.addGroup(tab_group_cam);

		updateCamUI();
	}

	function setCamEventMode(ev:CamEvent):Void
	{
		if (camEaseName == Song.CAM_CLASSIC)
		{
			Reflect.deleteField(ev, "ease");
			Reflect.deleteField(ev, "duration");
			Reflect.deleteField(ev, "x");
			Reflect.deleteField(ev, "y");
		}
		else
		{
			ev.ease = camEaseName;
			ev.duration = camDurSteps;
			ev.x = camOffX;
			ev.y = camOffY;
		}
	}

	function makeCamEvent(time:Float, target:Int):CamEvent
	{
		var ev:CamEvent = {time: time, target: target};
		setCamEventMode(ev);
		return ev;
	}

	function applyCamUI():Void
	{
		if (curSelectedCam == null)
			return;

		setCamEventMode(curSelectedCam);
		dirtyNotes = true;
		autosaveSong();
	}

	function updateCamUI():Void
	{
		updatingCamUI = true;

		if (curSelectedCam != null)
		{
			camEaseName = Song.camIsTween(curSelectedCam) ? curSelectedCam.ease : Song.CAM_CLASSIC;
			camDurSteps = Song.camDuration(curSelectedCam);
			camOffX = (curSelectedCam.x == null) ? 0 : curSelectedCam.x;
			camOffY = (curSelectedCam.y == null) ? 0 : curSelectedCam.y;
		}

		dropCamEase.selectedLabel = camEaseName;
		stepperCamDur.value = camDurSteps;
		stepperCamX.value = camOffX;
		stepperCamY.value = camOffY;

		if (curSelectedCam != null)
			camSelTxt.text = "Selected: " + camName(curSelectedCam.target) + " @ " + FlxMath.roundDecimal(curSelectedCam.time, 1) + " ms";
		else
			camSelTxt.text = "No camera event selected (Ctrl+Click one in the camera lane). The values below are used for new events.";

		updatingCamUI = false;
	}

	override function getEvent(id:String, sender:Dynamic, data:Dynamic, ?params:Array<Dynamic>)
	{
		if (id == FlxUICheckBox.CLICK_EVENT)
		{
			var check:FlxUICheckBox = cast sender;
			var label = check.getLabel().text;
			switch (label)
			{
				case 'Must hit section':
					_song.notes[curSection].mustHitSection = check.checked;
					updateHeads();
					dirtyNotes = true;

				case 'Change BPM':
					_song.notes[curSection].changeBPM = check.checked;
					tempoChanged();

				case "Alt Animation":
					_song.notes[curSection].altAnim = check.checked;

				case "Alt Animation Note":
					if (curSelectedNote != null)
					{
						setNoteType(curSelectedNote, check.checked ? 1 : 0);
						dirtyNotes = true;
					}
			}
		}
		else if (id == FlxUINumericStepper.CHANGE_EVENT && (sender is FlxUINumericStepper))
		{
			var nums:FlxUINumericStepper = cast sender;
			var wname = nums.name;

			if (wname == 'section_length')
			{
				var newLen:Int = Std.int(nums.value);
				if (newLen >= 1 && _song.notes[curSection].lengthInSteps != newLen)
				{
					_song.notes[curSection].lengthInSteps = newLen;
					tempoChanged();
				}
			}
			else if (wname == 'song_speed')
			{
				_song.speed = nums.value;
			}
			else if (wname == 'song_bpm')
			{
				if (_song.bpm != nums.value)
				{
					_song.bpm = nums.value;
					tempoChanged();
				}
			}
			else if (wname == 'song_rate')
			{
				playbackRate = nums.value;
				applyRate();
			}
			else if (wname == 'note_susLength')
			{
				if (curSelectedNote != null)
				{
					curSelectedNote[2] = nums.value;
					dirtyNotes = true;
				}
			}
			else if (wname == 'cam_duration' || wname == 'cam_x' || wname == 'cam_y')
			{
				if (!updatingCamUI)
				{
					if (wname == 'cam_duration')
						camDurSteps = nums.value;
					else if (wname == 'cam_x')
						camOffX = nums.value;
					else
						camOffY = nums.value;

					applyCamUI();
				}
			}
			else if (wname == 'section_bpm')
			{
				if (_song.notes[curSection].bpm != nums.value)
				{
					_song.notes[curSection].bpm = nums.value;
					tempoChanged();
				}
			}
		}
	}

	function updateSectionUI():Void
	{
		var sec = _song.notes[curSection];

		stepperLength.value = sec.lengthInSteps;
		check_mustHitSection.checked = sec.mustHitSection;
		check_altAnim.checked = sec.altAnim;
		check_changeBPM.checked = sec.changeBPM;
		stepperSectionBPM.value = sec.bpm;

		updateHeads();
	}

	function updateHeads():Void
	{
		leftIcon.changeIcon(PLAYER_ON_RIGHT ? _song.player2 : _song.player1);
		rightIcon.changeIcon(PLAYER_ON_RIGHT ? _song.player1 : _song.player2);
	}

	function updateNoteUI():Void
	{
		if (curSelectedNote != null)
		{
			stepperSusLength.value = (curSelectedNote[2] == null) ? 0 : curSelectedNote[2];
			check_noteAltAnim.checked = (getNoteType(curSelectedNote) == 1);
		}
	}

	function showStatus(msg:String):Void
	{
		statusTxt.text = msg;
		statusTimer = 4;
	}

	function isTyping():Bool
	{
		if (typingShit != null && typingShit.hasFocus)
			return true;

		for (s in steppers)
		{
			for (m in s.members)
			{
				if (m != null && Std.isOfType(m, FlxUIInputText))
				{
					var field:FlxUIInputText = cast m;
					if (field.hasFocus)
						return true;
				}
			}
		}

		return false;
	}

	function loadSong(daSong:String):Void
	{
		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();

		if (vocals != null)
			vocals.stop();

		if (playerVocals != null)
			playerVocals.stop();

		FlxG.sound.playMusic(Paths.inst(daSong), 1.0);

		var oppVoices:String = Paths.voices(daSong, '-opponent');
		var playerVoices:String = Paths.voices(daSong, '-player');
		var plainVoices:String = Paths.voices(daSong);
		splitVocals = Paths.useSplitVocals(daSong, PlayState.difficulty);

		if (splitVocals)
		{
			vocals = openfl.utils.Assets.exists(oppVoices) ? new FlxSound().loadEmbedded(oppVoices) : new FlxSound();
			playerVocals = openfl.utils.Assets.exists(playerVoices) ? new FlxSound().loadEmbedded(playerVoices) : new FlxSound();
		}
		else
		{
			vocals = openfl.utils.Assets.exists(plainVoices) ? new FlxSound().loadEmbedded(plainVoices) : new FlxSound();
			playerVocals = new FlxSound();
		}

		FlxG.sound.list.add(vocals);
		FlxG.sound.list.add(playerVocals);

		pauseAll();
		applyRate();
		applyVocalMute();

		FlxG.sound.music.onComplete = function()
		{
			seek(0);
		};
	}

	function applyRate():Void
	{
		if (FlxG.sound.music != null)
			FlxG.sound.music.pitch = playbackRate;
		if (vocals != null)
			vocals.pitch = playbackRate;
		if (playerVocals != null)
			playerVocals.pitch = playbackRate;
	}

	function applyVocalMute():Void
	{
		if (vocals != null)
			vocals.volume = (splitVocals && muteOppVocals) ? 0 : 1;
		if (playerVocals != null)
			playerVocals.volume = (splitVocals && mutePlayerVocals) ? 0 : 1;
	}

	function isPlayerNote(lane:Int, mustHit:Bool):Bool
	{
		return (lane < 4) == mustHit;
	}

	function buildStrums():Void
	{
		var skin:NoteSkin = NoteSkin.current;

		var staticNames:Array<String> = [
			'arrow static instance 1',
			'arrow static instance 2',
			'arrow static instance 4',
			'arrow static instance 3'
		];
		var confirmNames:Array<String> = ['left confirm', 'down confirm', 'up confirm', 'right confirm'];

		for (col in 0...8)
		{
			var i:Int = col % 4;

			var spr:FlxSprite = new FlxSprite(GRID_X + col * GRID_SIZE, STRUM_SCREEN_Y);

			var colorswap:ColorSwap = new ColorSwap();
			spr.shader = colorswap.shader;
			colorswap.update(Note.arrowColors[i]);

			if (skin.pixel)
			{
				spr.loadGraphic(Paths.image(skin.image), true, 17, 17);
				spr.animation.add('static', [i]);
				spr.animation.add('confirm', [12 + i, 16 + i], 24, false);
			}
			else
			{
				spr.frames = Paths.getSparrowAtlas(skin.image);
				spr.animation.addByPrefix('static', staticNames[i]);
				spr.animation.addByPrefix('confirm', confirmNames[i], 24, false);
			}

			spr.antialiasing = skin.antialiasing;
			spr.animation.play('static');
			spr.setGraphicSize(GRID_SIZE, 0);
			spr.scrollFactor.set();
			add(spr);

			strumSprites.push(spr);
			strumLit.push(false);
			strumFlash.push(0);
			strumHoldUntil.push(0);

			setStrumAnim(col, 'static', true);
		}
	}

	function setStrumAnim(col:Int, name:String, force:Bool = false):Void
	{
		var spr:FlxSprite = strumSprites[col];
		spr.animation.play(name, force);
		spr.updateHitbox();
		spr.x = GRID_X + col * GRID_SIZE + (GRID_SIZE - spr.width) / 2;
		spr.y = STRUM_SCREEN_Y + (GRID_SIZE - spr.height) / 2;
		spr.alpha = (name == 'confirm') ? 1 : 0.6;
	}

	function lightStrum(col:Int, holdUntil:Float):Void
	{
		strumFlash[col] = 0.12;
		strumHoldUntil[col] = Math.max(strumHoldUntil[col], holdUntil);
		strumLit[col] = true;
		setStrumAnim(col, 'confirm', true);
	}

	function updateStrums(elapsed:Float, songPos:Float, playing:Bool):Void
	{
		for (col in 0...strumSprites.length)
		{
			if (!playing)
			{
				strumFlash[col] = 0;
				strumHoldUntil[col] = 0;
			}
			else
			{
				strumFlash[col] = Math.max(0, strumFlash[col] - elapsed);
			}

			var lit:Bool = strumFlash[col] > 0 || (playing && songPos < strumHoldUntil[col]);

			if (strumLit[col] && !lit)
			{
				strumLit[col] = false;
				setStrumAnim(col, 'static', true);
			}
		}
	}

	function pauseAll():Void
	{
		FlxG.sound.music.pause();
		vocals.pause();
		playerVocals.pause();
	}

	function stopAll():Void
	{
		FlxG.sound.music.stop();
		vocals.stop();
		playerVocals.stop();
	}

	function togglePlay():Void
	{
		if (FlxG.sound.music.playing)
		{
			pauseAll();
		}
		else
		{
			var t:Float = FlxG.sound.music.time;
			vocals.time = t;
			playerVocals.time = t;
			lastHitTime = t;

			vocals.play();
			playerVocals.play();
			FlxG.sound.music.play();
		}
	}

	function seek(t:Float):Void
	{
		t = FlxMath.bound(t, 0, FlxG.sound.music.length);

		pauseAll();

		FlxG.sound.music.time = t;
		vocals.time = t;
		playerVocals.time = t;

		Conductor.songPosition = t;
		lastHitTime = t;
	}

	function quant():Int
	{
		return quantList[quantIdx];
	}

	function snapTime():Float
	{
		return Conductor.stepCrochet * 16 / quant();
	}

	function jumpSections(amount:Int):Void
	{
		var target:Int = curSection + amount;

		if (target < 0)
			target = 0;

		if (target >= _song.notes.length)
		{
			if (endTime >= FlxG.sound.music.length)
				return;

			while (_song.notes.length <= target)
				addSection();
			rebuildTempo();
		}

		seek(secTimes[target]);
	}

	function copySection(sectionNum:Int):Void
	{
		var from:Int = curSection - sectionNum;

		if (sectionNum < 1 || from < 0 || _song.notes[from] == null)
		{
			showStatus("No section to copy from");
			return;
		}

		pushUndo();

		var offset:Float = secTimes[curSection] - secTimes[from];

		for (n in _song.notes[from].sectionNotes)
		{
			var arr:Array<Dynamic> = n;
			var copied:Array<Dynamic> = arr.copy();
			var t:Float = arr[0];
			copied[0] = t + offset;

			if (_song.notes[from].mustHitSection != _song.notes[curSection].mustHitSection)
				copied[1] = (Std.int(arr[1]) + 4) % 8;
			_song.notes[curSection].sectionNotes.push(copied);
		}

		dirtyNotes = true;
		autosaveSong();
	}

	function clearSection():Void
	{
		pushUndo();
		_song.notes[curSection].sectionNotes = [];
		curSelectedNote = null;

		dirtyNotes = true;
		autosaveSong();
	}

	function noteExistsAt(time:Float, lane:Int):Bool
	{
		var si:Int = sectionAtTime(time);
		var from:Int = Std.int(Math.max(0, si - 1));
		var to:Int = Std.int(Math.min(_song.notes.length, si + 2));

		for (i in from...to)
		{
			for (n in _song.notes[i].sectionNotes)
			{
				var arr:Array<Dynamic> = n;
				var t:Float = arr[0];
				if (Math.abs(t - time) < 1 && Std.int(arr[1]) == lane)
					return true;
			}
		}
		return false;
	}

	function getNoteType(arr:Array<Dynamic>):Int
	{
		if (arr[4] == true)
			return 2;
		if (arr[3] == true)
			return 1;
		return 0;
	}

	function getCustomType(arr:Array<Dynamic>):String
	{
		return (arr.length > 5 && arr[5] != null) ? Std.string(arr[5]) : '';
	}

	function setCustomType(arr:Array<Dynamic>, t:String):Void
	{
		if (t == '' && arr.length <= 5)
			return;
		while (arr.length < 5)
			arr.push(false);
		arr[5] = t;
	}

	function setNoteType(arr:Array<Dynamic>, type:Int):Void
	{
		arr[3] = (type == 1);
		arr[4] = (type == 2);
	}

	private function addNote(mx:Float, my:Float):Void
	{
		var noteStrum:Float = FlxMath.roundDecimal(stepToTime(snappedStep(my)), 3);
		var col:Int = Std.int(FlxMath.bound(Math.floor((mx - GRID_X) / GRID_SIZE), 0, 7));

		if (noteStrum < 0)
			return;

		ensureSectionFor(noteStrum);
		var si:Int = sectionAtTime(noteStrum);
		var sec:SwagSection = _song.notes[si];
		var noteData:Int = laneToCol(col, sec.mustHitSection);

		if (noteExistsAt(noteStrum, noteData))
			return;

		pushUndo();

		var newNote:Array<Dynamic> = [noteStrum, noteData, 0, curNoteType == 1, curNoteType == 2];
		sec.sectionNotes.push(newNote);
		curSelectedNote = newNote;
		curSelectedSec = si;

		setCustomType(newNote, curCustomType);
		if (FlxG.keys.pressed.CONTROL)
		{
			var mirrorLane:Int = (noteData + 4) % 8;
			if (!noteExistsAt(noteStrum, mirrorLane))
			{
				var mirrored:Array<Dynamic> = [noteStrum, mirrorLane, 0, curNoteType == 1, curNoteType == 2];
				sec.sectionNotes.push(mirrored);
			}
		}

		dirtyNotes = true;
		updateNoteUI();
		autosaveSong();
	}

	function selectNote(note:Note):Void
	{
		var data:Array<Dynamic> = noteLookup.get(note);
		if (data == null)
			return;

		curSelectedNote = data;
		curSelectedSec = noteSecLookup.get(note);

		dirtyNotes = true;
		updateNoteUI();
	}

	function deleteNote(note:Note):Void
	{
		var data:Array<Dynamic> = noteLookup.get(note);
		if (data == null)
			return;

		pushUndo();

		_song.notes[noteSecLookup.get(note)].sectionNotes.remove(data);
		if (curSelectedNote == data)
			curSelectedNote = null;

		dirtyNotes = true;
		autosaveSong();
	}

	function deleteSelectedNote():Void
	{
		if (curSelectedNote == null)
			return;

		pushUndo();

		_song.notes[curSelectedSec].sectionNotes.remove(curSelectedNote);
		curSelectedNote = null;

		dirtyNotes = true;
		autosaveSong();
	}

	function changeNoteSustain(value:Float):Void
	{
		if (curSelectedNote != null)
		{
			pushUndo();

			var cur:Float = (curSelectedNote[2] == null) ? 0 : curSelectedNote[2];
			curSelectedNote[2] = Math.max(cur + value, 0);

			updateNoteUI();
			dirtyNotes = true;
		}
	}

	function toggleAltAnimNote():Void
	{
		if (curSelectedNote != null)
		{
			pushUndo();
			setNoteType(curSelectedNote, (getNoteType(curSelectedNote) + 1) % 3);
			updateNoteUI();
			dirtyNotes = true;
		}
	}

	function snapshot():Array<Array<Dynamic>>
	{
		var snap:Array<Array<Dynamic>> = [];

		for (sec in _song.notes)
		{
			var notes:Array<Dynamic> = [];
			for (n in sec.sectionNotes)
			{
				var arr:Array<Dynamic> = n;
				notes.push(arr.copy());
			}
			snap.push(notes);
		}

		return snap;
	}

	function restoreSnapshot(snap:Array<Array<Dynamic>>):Void
	{
		for (i in 0..._song.notes.length)
		{
			if (i < snap.length)
				_song.notes[i].sectionNotes = snap[i];
			else
				_song.notes[i].sectionNotes = [];
		}

		curSelectedNote = null;
		dirtyNotes = true;
		autosaveSong();
	}

	function pushUndo():Void
	{
		undoStack.push(snapshot());
		if (undoStack.length > 100)
			undoStack.shift();

		redoStack = [];
	}

	function undo():Void
	{
		if (undoStack.length == 0)
		{
			showStatus("Nothing to undo");
			return;
		}

		redoStack.push(snapshot());
		restoreSnapshot(undoStack.pop());
		showStatus("Undo");
	}

	function redo():Void
	{
		if (redoStack.length == 0)
		{
			showStatus("Nothing to redo");
			return;
		}

		undoStack.push(snapshot());
		restoreSnapshot(redoStack.pop());
		showStatus("Redo");
	}

	override function update(elapsed:Float)
	{
		var music = FlxG.sound.music;

		Conductor.songPosition = music.time;
		_song.song = typingShit.text;

		var songPos:Float = Conductor.songPosition;
		var typing:Bool = isTyping();
		var ctrl:Bool = FlxG.keys.pressed.CONTROL;
		var shift:Bool = FlxG.keys.pressed.SHIFT;

		songEndY = timeToY(music.length);

		var newSec:Int = sectionAtTime(songPos);
		if (newSec != curSection)
		{
			curSection = newSec;
			applyConductorBPM();
			updateSectionUI();
		}

		curStep = Std.int(Math.floor(Math.max(0, timeToStep(songPos))));
		updateBeat();

		strumLine.y = timeToY(songPos);
		FlxG.camera.scroll.set(0, strumLine.y - STRUM_SCREEN_Y);

		var camTop:Float = FlxG.camera.scroll.y;
		var camBottom:Float = camTop + FlxG.height;

		updateGridChunks(camTop);
		updateSectionMarkers(camTop, camBottom);

		if (dirtyNotes || camTop < renderedTop + 600 || camBottom > renderedBottom - 600)
			refreshNotes(camTop - 2400, camBottom + 2400);

		if (statusTimer > 0)
		{
			statusTimer -= elapsed;
			if (statusTimer <= 0)
				statusTxt.text = "";
		}

		autosaveTimer += elapsed;
		if (autosaveTimer >= 60)
		{
			autosaveTimer = 0;
			autosaveSong();
		}

		if (music.playing)
		{
			var played:Bool = false;
			var from:Int = Std.int(Math.max(0, curSection - 1));
			var to:Int = Std.int(Math.min(_song.notes.length, curSection + 2));

			for (si in from...to)
			{
				var mustHit:Bool = _song.notes[si].mustHitSection;

				for (n in _song.notes[si].sectionNotes)
				{
					var arr:Array<Dynamic> = n;
					var t:Float = arr[0];

					if (t > lastHitTime && t <= songPos)
					{
						var lane:Int = Std.int(arr[1]);
						var sus:Float = (arr[2] == null) ? 0 : arr[2];
						var isPlayer:Bool = isPlayerNote(lane, mustHit);

						if (hitsoundSide == 0 || (hitsoundSide == 1 && !isPlayer) || (hitsoundSide == 2 && isPlayer))
							played = true;

						lightStrum(laneToCol(lane, mustHit), t + sus);
					}
				}
			}

			if (played && hitsoundsEnabled)
				FlxG.sound.play(hitsoundPath, 1.0);
		}
		lastHitTime = songPos;

		updateStrums(elapsed, songPos, music.playing);

		var mx:Float = mouseWX();
		var my:Float = mouseWY();

		if (FlxG.mouse.justPressed || FlxG.mouse.justPressedRight)
		{
			var hitNote:Note = null;
			for (note in curRenderedNotes.members)
			{
				if (note != null && note.exists && mx >= note.x && mx < note.x + GRID_SIZE && my >= note.y && my < note.y + GRID_SIZE)
				{
					hitNote = note;
					break;
				}
			}

			if (hitNote != null)
			{
				if (FlxG.mouse.justPressed && ctrl)
					selectNote(hitNote);
				else
					deleteNote(hitNote);
			}
			else if (FlxG.mouse.justPressed && mouseInGrid(mx, my))
			{
				addNote(mx, my);
			}
		}

		if ((FlxG.mouse.justPressed || FlxG.mouse.justPressedRight)
			&& mx >= CAM_X
			&& mx < CAM_X + CAM_W
			&& my >= 0
			&& my < songEndY)
		{
			var hitEv:CamEvent = null;
			for (ev in _song.cameraEvents)
			{
				var ey:Float = timeToY(ev.time);
				if (my >= ey && my < ey + GRID_SIZE)
				{
					hitEv = ev;
					break;
				}
			}

			if (FlxG.mouse.justPressedRight)
			{
				if (hitEv != null)
				{
					_song.cameraEvents.remove(hitEv);
					if (curSelectedCam == hitEv)
					{
						curSelectedCam = null;
						updateCamUI();
					}
				}
			}
			else if (hitEv != null)
			{
				if (ctrl)
				{
					curSelectedCam = hitEv;
					updateCamUI();
					showStatus("Camera event selected (Camera tab)");
				}
				else
					hitEv.target = (hitEv.target + 1) % 3;
			}
			else
			{
				var evTime:Float = FlxMath.roundDecimal(stepToTime(snappedStep(my)), 3);
				var newEv:CamEvent = makeCamEvent(evTime, curCamTarget);
				_song.cameraEvents.push(newEv);
				_song.cameraEvents.sort(function(a, b) return Std.int(a.time - b.time));
				curSelectedCam = newEv;
				updateCamUI();
			}

			dirtyNotes = true;
			autosaveSong();
		}

		if (mouseInGrid(mx, my))
		{
			dummyArrow.visible = true;
			dummyArrow.x = GRID_X + Math.floor((mx - GRID_X) / GRID_SIZE) * GRID_SIZE;
			dummyArrow.y = snappedStep(my) * GRID_SIZE;
		}
		else
		{
			dummyArrow.visible = false;
		}

		if (ctrl)
		{
			if (FlxG.keys.justPressed.S)
				saveLevel();

			if (!typing)
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
			}
		}

		if (!typing)
		{
			if (FlxG.keys.justPressed.ENTER)
			{
				lastSection = curSection;
				autosaveSong();

				PlayState.startPosition = shift ? music.time : 0;

				PlayState.SONG = _song;
				music.pitch = 1;
				stopAll();
				FlxG.switchState(new PlayState());
				return;
			}

			if (FlxG.keys.justPressed.X)
				toggleAltAnimNote();

			if (FlxG.keys.justPressed.E)
				changeNoteSustain(Conductor.stepCrochet);
			if (FlxG.keys.justPressed.Q)
				changeNoteSustain(-Conductor.stepCrochet);

			if (FlxG.keys.justPressed.DELETE)
				deleteSelectedNote();

			if (FlxG.keys.justPressed.TAB)
			{
				if (shift)
				{
					UI_box.selected_tab -= 1;
					if (UI_box.selected_tab < 0)
						UI_box.selected_tab = 3;
				}
				else
				{
					UI_box.selected_tab += 1;
					if (UI_box.selected_tab >= 4)
						UI_box.selected_tab = 0;
				}
			}

			if (FlxG.keys.justPressed.SPACE)
				togglePlay();

			if (FlxG.keys.justPressed.R && !ctrl)
				seek(shift ? 0 : secTimes[curSection]);

			if (FlxG.keys.justPressed.RIGHT)
			{
				quantIdx = Std.int(Math.min(quantIdx + 1, quantList.length - 1));
				showStatus("Snap: 1/" + quant());
			}
			if (FlxG.keys.justPressed.LEFT)
			{
				quantIdx = Std.int(Math.max(quantIdx - 1, 0));
				showStatus("Snap: 1/" + quant());
			}

			var sectionJump:Int = shift ? 4 : 1;
			if (FlxG.keys.justPressed.D)
				jumpSections(sectionJump);
			if (FlxG.keys.justPressed.A)
				jumpSections(-sectionJump);

			if (FlxG.mouse.wheel != 0)
				seek(music.time - (FlxG.mouse.wheel * Conductor.stepCrochet * 0.4));

			if (!ctrl)
			{
				if (FlxG.keys.justPressed.W || FlxG.keys.justPressed.S)
				{
					var dirJ:Int = FlxG.keys.justPressed.W ? -1 : 1;
					seek(music.time + dirJ * snapTime());
					scrollHold = 0;
				}
				else if (FlxG.keys.pressed.W || FlxG.keys.pressed.S)
				{
					scrollHold += elapsed;
					if (scrollHold > 0.3)
					{
						var dir:Int = FlxG.keys.pressed.W ? -1 : 1;
						var speed:Float = shift ? 4000 : 1000;
						seek(music.time + dir * speed * elapsed);
					}
				}
				else
				{
					scrollHold = 0;
				}
			}

			if (FlxG.keys.justPressed.ONE)
			{
				curCamTarget = 0;
				showStatus("New camera events: Dad");
			}
			if (FlxG.keys.justPressed.TWO)
			{
				curCamTarget = 1;
				showStatus("New camera events: BF");
			}
			if (FlxG.keys.justPressed.THREE)
			{
				curCamTarget = 2;
				showStatus("New camera events: GF");
			}
		}

		bpmTxt.text = Std.string(FlxMath.roundDecimal(Conductor.songPosition / 1000, 2))
			+ " / "
			+ Std.string(FlxMath.roundDecimal(music.length / 1000, 2))
			+ "\nSection: "
			+ curSection
			+ "\nStep: "
			+ curStep
			+ " | Beat: "
			+ curBeat
			+ "\nBPM: "
			+ Conductor.bpm
			+ "\nSnap: 1/"
			+ quant()
			+ "\nRate: "
			+ playbackRate
			+ "x"
			+ "\nNotes: "
			+ totalNotes;

		super.update(elapsed);
	}

	function loadJson(song:String):Void
	{
		PlayState.SONG = Song.loadFromJson(song.toLowerCase(), song.toLowerCase());
		LoadingState.loadAndSwitchState(new ChartingState());
	}

	function loadAutosave():Void
	{
		if (FlxG.save.data.autosave == null)
		{
			showStatus("No autosave found");
			return;
		}

		PlayState.SONG = Song.parseJSONshit(FlxG.save.data.autosave);
		FlxG.resetState();
	}

	function autosaveSong():Void
	{
		FlxG.save.data.autosave = Json.stringify({
			"song": _song
		});
		FlxG.save.flush();
	}

	private function saveLevel()
	{
		var json = {
			"song": _song
		};

		var data:String = Json.stringify(json, "\t");

		if ((data != null) && (data.length > 0))
		{
			var suffix:String = CoolUtil.chartSuffix(PlayState.difficulty);

			var fileName:String = _song.song.toLowerCase() + suffix + ".json";

			#if sys
			var dir:String = "assets/data/songs/" + _song.song.toLowerCase();
			var path:String = dir + "/" + fileName;

			try
			{
				if (!FileSystem.exists(dir))
					FileSystem.createDirectory(dir);

				File.saveContent(path, data.trim());
				showStatus("Saved: " + path);
				FlxG.log.notice("Saved successfully to: " + path);
			}
			catch (e:Dynamic)
			{
				showStatus("Error while saving: " + e);
				FlxG.log.error("Error while saving: " + e);
			}
			#else
			_file = new FileReference();
			_file.addEventListener(Event.COMPLETE, onSaveComplete);
			_file.addEventListener(Event.CANCEL, onSaveCancel);
			_file.addEventListener(IOErrorEvent.IO_ERROR, onSaveError);
			_file.save(data.trim(), fileName);
			#end
		}
	}

	function releaseFile():Void
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
		releaseFile();
		showStatus("Level data saved");
	}

	function onSaveCancel(_):Void
	{
		releaseFile();
	}

	function onSaveError(_):Void
	{
		releaseFile();
		showStatus("Problem saving level data");
	}
}
