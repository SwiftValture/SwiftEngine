

var tex = null;

tex = Paths.getSparrowAtlas('characters/darnell');
char.frames = tex;
char.animation.addByIndices('idle', 'Idle', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
char.quickAnimAdd('singUP', 'Pose Up');
char.quickAnimAdd('singRIGHT', 'Pose Right');
char.quickAnimAdd('singDOWN', 'Pose Down');
char.quickAnimAdd('singLEFT', 'Pose Left');

char.loadOffsetFile(char.curCharacter);

char.playAnim('idle');

char.holdTime = 6.1;
