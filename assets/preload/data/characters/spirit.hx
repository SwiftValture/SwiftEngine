


char.frames = Paths.getPackerAtlas('characters/spirit');
char.quickAnimAdd('idle', "idle spirit_");
char.quickAnimAdd('singUP', "up_");
char.quickAnimAdd('singRIGHT', "right_");
char.quickAnimAdd('singLEFT', "left_");
char.quickAnimAdd('singDOWN', "spirit down_");

char.loadOffsetFile(char.curCharacter);

char.setGraphicSize(Std.int(char.width * 6));
char.updateHitbox();

char.playAnim('idle');

char.antialiasing = false;
