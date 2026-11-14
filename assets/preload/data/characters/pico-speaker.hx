


char.frames = Paths.getSparrowAtlas('characters/picoSpeaker');

char.quickAnimAdd('shoot1', "Pico shoot 1");
char.quickAnimAdd('shoot2', "Pico shoot 2");
char.quickAnimAdd('shoot3', "Pico shoot 3");
char.quickAnimAdd('shoot4', "Pico shoot 4");


char.loadOffsetFile(char.curCharacter);
char.playAnim('shoot1');

char.loadMappedAnims();

char.noDance = true;

function onUpdate(elapsed)
{
	if (char.animationNotes.length > 0)
	{
		if (Conductor.songPosition > char.animationNotes[0][0])
		{
			var shootAnim = 1;

			if (char.animationNotes[0][1] >= 2)
				shootAnim = 3;

			shootAnim += FlxG.random.int(0, 1);

			char.playAnim('shoot' + shootAnim, true);
			char.animationNotes.shift();
		}
	}

	if (char.animation.curAnim.finished)
	{
		char.playAnim(char.animation.curAnim.name, false, false, char.animation.curAnim.numFrames - 3);
	}
}
