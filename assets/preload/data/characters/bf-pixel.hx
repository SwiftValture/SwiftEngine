


char.frames = Paths.getSparrowAtlas('characters/bfPixel');
char.quickAnimAdd('idle', 'BF IDLE');
char.quickAnimAdd('singUP', 'BF UP NOTE');
char.quickAnimAdd('singLEFT', 'BF LEFT NOTE');
char.quickAnimAdd('singRIGHT', 'BF RIGHT NOTE');
char.quickAnimAdd('singDOWN', 'BF DOWN NOTE');
char.quickAnimAdd('singUPmiss', 'BF UP MISS');
char.quickAnimAdd('singLEFTmiss', 'BF LEFT MISS');
char.quickAnimAdd('singRIGHTmiss', 'BF RIGHT MISS');
char.quickAnimAdd('singDOWNmiss', 'BF DOWN MISS');

char.loadOffsetFile(char.curCharacter);

char.setGraphicSize(Std.int(char.width * 6));
char.updateHitbox();

char.playAnim('idle');

char.width -= 100;
char.height -= 100;

char.antialiasing = false;

char.flipX = true;
