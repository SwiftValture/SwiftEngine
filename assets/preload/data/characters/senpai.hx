


char.frames = Paths.getSparrowAtlas('characters/senpai');
char.quickAnimAdd('idle', 'Senpai Idle');





char.quickAnimAdd('singUP', 'SENPAI UP NOTE');
char.quickAnimAdd('singLEFT', 'SENPAI LEFT NOTE');
char.quickAnimAdd('singRIGHT', 'SENPAI RIGHT NOTE');
char.quickAnimAdd('singDOWN', 'SENPAI DOWN NOTE');

char.loadOffsetFile(char.curCharacter);

char.playAnim('idle');

char.setGraphicSize(Std.int(char.width * 6));
char.updateHitbox();

char.antialiasing = false;
