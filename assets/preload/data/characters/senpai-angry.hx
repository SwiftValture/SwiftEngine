


char.frames = Paths.getSparrowAtlas('characters/senpai');
char.quickAnimAdd('idle', 'Angry Senpai Idle');
char.quickAnimAdd('singUP', 'Angry Senpai UP NOTE');
char.quickAnimAdd('singLEFT', 'Angry Senpai LEFT NOTE');
char.quickAnimAdd('singRIGHT', 'Angry Senpai RIGHT NOTE');
char.quickAnimAdd('singDOWN', 'Angry Senpai DOWN NOTE');

char.loadOffsetFile(char.curCharacter);

char.playAnim('idle');

char.setGraphicSize(Std.int(char.width * 6));
char.updateHitbox();

char.antialiasing = false;
