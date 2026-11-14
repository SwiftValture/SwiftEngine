

var tex = null;

tex = Paths.getSparrowAtlas('characters/spooky_kids_assets');
char.frames = tex;
char.quickAnimAdd('singUP', 'spooky UP NOTE');
char.quickAnimAdd('singDOWN', 'spooky DOWN note');
char.quickAnimAdd('singLEFT', 'note sing left');
char.quickAnimAdd('singRIGHT', 'spooky sing right');
char.animation.addByIndices('danceLeft', 'spooky dance idle', [0, 2, 6], "", 12, false);
char.animation.addByIndices('danceRight', 'spooky dance idle', [8, 10, 12, 14], "", 12, false);

char.loadOffsetFile(char.curCharacter);

char.playAnim('danceRight');

char.holdTime = 6.1;

char.danceSides = true;
