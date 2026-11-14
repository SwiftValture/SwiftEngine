package;

import flixel.FlxG;
import Controls.Control;
import Controls.Device;
import openfl.events.KeyboardEvent;
import flixel.input.keyboard.FlxKey;
import flixel.group.FlxGroup.FlxTypedGroup;
import ui.PreferencesMenu;

using StringTools;

class NoteInput
{
	public var holdArray:Array<Bool> = [false, false, false, false];
	public var pressArray:Array<Bool> = [false, false, false, false];
	public var releaseArray:Array<Bool> = [false, false, false, false];

	public var perfectMode:Bool = false;

	var controls:Controls;
	var onNoteHit:Note->Void;
	var onNoteMiss:Int->Void;

	var pressLatch:Array<Bool> = [false, false, false, false];
	var releaseLatch:Array<Bool> = [false, false, false, false];
	var keyDown:Array<Bool> = [false, false, false, false];
	var keyToLane:Map<Int, Int> = new Map();

	private static inline final LANE_COUNT:Int = 4;

	public function new(controls:Controls, onNoteHit:Note->Void, onNoteMiss:Int->Void)
	{
		this.controls = controls;
		this.onNoteHit = onNoteHit;
		this.onNoteMiss = onNoteMiss;

		rebuildKeyMap();
		FlxG.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		FlxG.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
	}

	public function destroy():Void
	{
		FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		FlxG.stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
	}

	public function rebuildKeyMap():Void
	{
		keyToLane.clear();
		var ctrls = [Control.NOTE_LEFT, Control.NOTE_DOWN, Control.NOTE_UP, Control.NOTE_RIGHT];
		for (lane in 0...LANE_COUNT)
		{
			for (key in controls.getInputsFor(ctrls[lane], Device.Keys))
			{
				if (key != FlxKey.NONE)
					keyToLane.set(key, lane);
			}
		}
	}

	function onKeyDown(e:KeyboardEvent):Void
	{
		var lane = keyToLane.get(e.keyCode);
		if (lane == null || keyDown[lane])
			return;

		keyDown[lane] = true;
		pressLatch[lane] = true;
	}

	function onKeyUp(e:KeyboardEvent):Void
	{
		var lane = keyToLane.get(e.keyCode);
		if (lane == null)
			return;

		keyDown[lane] = false;
		releaseLatch[lane] = true;
	}

	public function update(notes:FlxTypedGroup<Note>, boyfriend:Boyfriend, cpuControlled:Bool, generatedMusic:Bool):Void
	{
		updateArrays();

		for (i in 0...LANE_COUNT)
		{
			pressLatch[i] = false;
			releaseLatch[i] = false;
		}

		if (cpuControlled || !generatedMusic)
			return;

		handleSustains(notes, boyfriend);
		handlePresses(notes);
	}

	private function updateArrays():Void
	{
		holdArray[0] = controls.NOTE_LEFT || pressLatch[0];
		holdArray[1] = controls.NOTE_DOWN || pressLatch[1];
		holdArray[2] = controls.NOTE_UP || pressLatch[2];
		holdArray[3] = controls.NOTE_RIGHT || pressLatch[3];

		pressArray[0] = controls.NOTE_LEFT_P || pressLatch[0];
		pressArray[1] = controls.NOTE_DOWN_P || pressLatch[1];
		pressArray[2] = controls.NOTE_UP_P || pressLatch[2];
		pressArray[3] = controls.NOTE_RIGHT_P || pressLatch[3];

		releaseArray[0] = controls.NOTE_LEFT_R || releaseLatch[0];
		releaseArray[1] = controls.NOTE_DOWN_R || releaseLatch[1];
		releaseArray[2] = controls.NOTE_UP_R || releaseLatch[2];
		releaseArray[3] = controls.NOTE_RIGHT_R || releaseLatch[3];
	}

	private function handleSustains(notes:FlxTypedGroup<Note>, boyfriend:Boyfriend):Void
	{
		if (!holdArray.contains(true))
			return;

		for (daNote in notes.members)
		{
			if (daNote != null && daNote.alive && daNote.isSustainNote && daNote.canBeHit && daNote.mustPress && holdArray[daNote.noteData])
			{
				onNoteHit(daNote);
				boyfriend.holdTimer = 0;
			}
		}
	}

	private function handlePresses(notes:FlxTypedGroup<Note>):Void
	{
		if (!pressArray.contains(true))
			return;

		var possibleNotes:Array<Note> = [];
		var directionList:Array<Int> = [];
		var dumbNotes:Array<Note> = [];

		for (daNote in notes.members)
		{
			if (daNote == null || !daNote.alive)
				continue;

			if (daNote.canBeHit && daNote.mustPress && !daNote.tooLate && !daNote.wasGoodHit)
			{
				if (directionList.contains(daNote.noteData))
				{
					for (coolNote in possibleNotes)
					{
						if (coolNote.noteData == daNote.noteData)
						{
							if (Math.abs(daNote.strumTime - coolNote.strumTime) < 10)
							{
								dumbNotes.push(daNote);
								break;
							}
							else if (daNote.strumTime < coolNote.strumTime)
							{
								possibleNotes.remove(coolNote);
								possibleNotes.push(daNote);
								break;
							}
						}
					}
				}
				else
				{
					possibleNotes.push(daNote);
					directionList.push(daNote.noteData);
				}
			}
		}

		for (note in dumbNotes)
		{
			note.kill();
			notes.remove(note, true);
			note.destroy();
		}

		possibleNotes.sort((a, b) -> Std.int(a.strumTime - b.strumTime));

		if (perfectMode)
		{
			if (possibleNotes.length > 0)
				onNoteHit(possibleNotes[0]);
		}
		else if (possibleNotes.length > 0)
		{
			for (i in 0...pressArray.length)
			{
				if (pressArray[i] && !directionList.contains(i))
					onNoteMiss(i);
			}

			for (coolNote in possibleNotes)
			{
				if (pressArray[coolNote.noteData])
					onNoteHit(coolNote);
			}
		}
		else
		{
			if (!PreferencesMenu.getPref('ghost Tapping'))
			{
				for (i in 0...pressArray.length)
				{
					if (pressArray[i])
						onNoteMiss(i);
				}
			}
		}
	}

	private function handleHoldTimers(boyfriend:Boyfriend):Void
	{
		var sustainHeld = holdArray.contains(true); // ich schwoere es euch ich schiese mich ab wenn es noch immer input drops gibt und die animationen nicht gescheit gehen

		if (sustainHeld)
		{
			boyfriend.holdTimer = 0;
		}
		else if (boyfriend.holdTimer > Conductor.stepCrochet * boyfriend.holdTime / 1000)
		{
			if (boyfriend.animation.curAnim != null
				&& boyfriend.animation.curAnim.name.startsWith('sing')
				&& !boyfriend.animation.curAnim.name.endsWith('miss'))
			{
				boyfriend.playAnim('idle');
				boyfriend.holdTimer = 0;
			}
		}
	}
}
