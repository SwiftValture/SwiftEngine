

var tex = null;


tex = Paths.getSparrowAtlas('characters/DADDY_DEAREST');
char.frames = tex;
char.quickAnimAdd('idle', 'Dad idle dance');
char.quickAnimAdd('singUP', 'Dad Sing Note UP');
char.quickAnimAdd('singRIGHT', 'Dad Sing Note RIGHT');
char.quickAnimAdd('singDOWN', 'Dad Sing Note DOWN');
char.quickAnimAdd('singLEFT', 'Dad Sing Note LEFT');

char.loadOffsetFile(char.curCharacter);

char.playAnim('idle');

char.holdTime = 6.1;
