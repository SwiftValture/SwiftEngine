

var tex = null;


tex = Paths.getSparrowAtlas('characters/GF_assets');
char.frames = tex;
char.quickAnimAdd('cheer', 'GF Cheer');
char.quickAnimAdd('singLEFT', 'GF left note');
char.quickAnimAdd('singRIGHT', 'GF Right Note');
char.quickAnimAdd('singUP', 'GF Up Note');
char.quickAnimAdd('singDOWN', 'GF Down Note');
char.animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
char.animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
char.animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
char.animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
char.animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
char.animation.addByPrefix('scared', 'GF FEAR', 24, true);

char.loadOffsetFile(char.curCharacter);

char.playAnim('danceRight');

char.holdTime = 4;

char.healthIcon = 'dad';

char.danceSides = true;

function onUpdate(elapsed)
{
	if (char.animation.curAnim.name == 'hairFall' && char.animation.curAnim.finished)
		char.playAnim('danceRight');
}
