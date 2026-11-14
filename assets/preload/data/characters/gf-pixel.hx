

var tex = null;

tex = Paths.getSparrowAtlas('characters/gfPixel');
char.frames = tex;
char.animation.addByIndices('singUP', 'GF IDLE', [2], "", 24, false);
char.animation.addByIndices('danceLeft', 'GF IDLE', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
char.animation.addByIndices('danceRight', 'GF IDLE', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

char.loadOffsetFile(char.curCharacter);

char.playAnim('danceRight');

char.setGraphicSize(Std.int(char.width * PlayState.daPixelZoom));
char.updateHitbox();
char.antialiasing = false;

char.holdTime = 4;

char.danceSides = true;
