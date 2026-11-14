package;

import Section.SwagSection;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;

using StringTools;

class HoldNote
{
	public static function generate(noteData:Array<SwagSection>, unspawnNotes:Array<Note>, sortFunction:Note->Note->Int):Void
	{
		for (section in noteData)
		{
			for (songNotes in section.sectionNotes)
			{
				var daStrumTime:Float = songNotes[0];
				var daNoteData:Int = Std.int(songNotes[1] % 4);

				var gottaHitNote:Bool = section.mustHitSection;

				if (songNotes[1] > 3)
					gottaHitNote = !section.mustHitSection;

				var oldNote:Note = unspawnNotes.length > 0 ? unspawnNotes[unspawnNotes.length - 1] : null;

				var swagNote:Note = new Note(daStrumTime, daNoteData, oldNote);

				swagNote.sustainLength = songNotes[2];
				swagNote.altNote = (songNotes[3] == true);
				swagNote.noAnimation = (songNotes[4] == true);
				swagNote.noteType = (songNotes[5] != null) ? Std.string(songNotes[5]) : '';
				swagNote.scrollFactor.set(0, 0);

				var susLength:Float = swagNote.sustainLength;
				susLength /= Conductor.stepCrochet;

				var susCount:Int = Math.floor(susLength);
				if (susCount == 1)
					susCount = 2;

				unspawnNotes.push(swagNote);

				var trail:SustainTrail = null;
				if (susCount > 0)
				{
					var skin:NoteSkin = NoteSkin.current;
					var strip = SustainStrip.get(skin);
					trail = new SustainTrail(daNoteData, swagNote.sustainLength, strip, SustainStrip.capFraction, skin.scale, skin.pixel);
					trail.strumTime = daStrumTime;
					trail.mustPress = gottaHitNote;
					swagNote.trail = trail;
				}

				for (susNote in 0...susCount)
				{
					oldNote = unspawnNotes[unspawnNotes.length - 1];

					var sustainNote:Note = new Note(daStrumTime + (Conductor.stepCrochet * susNote) + Conductor.stepCrochet, daNoteData, oldNote, true);
					sustainNote.trail = trail;
					sustainNote.altNote = swagNote.altNote;
					sustainNote.noAnimation = swagNote.noAnimation;
					sustainNote.noteType = swagNote.noteType;
					sustainNote.isLastSustain = susNote == susCount - 1;
					sustainNote.scrollFactor.set();
					unspawnNotes.push(sustainNote);
					sustainNote.mustPress = gottaHitNote;

					if (sustainNote.mustPress)
						sustainNote.x += FlxG.width / 2;
				}

				swagNote.mustPress = gottaHitNote;

				if (swagNote.mustPress)
					swagNote.x += FlxG.width / 2;
			}
		}

		unspawnNotes.sort(sortFunction);
	}
}
