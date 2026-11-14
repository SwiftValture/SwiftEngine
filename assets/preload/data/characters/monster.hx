

var tex = null;

tex = Paths.getSparrowAtlas('characters/Monster_Assets');
char.frames = tex;
char.quickAnimAdd('idle', 'monster idle');
char.quickAnimAdd('singUP', 'monster up note');
char.quickAnimAdd('singDOWN', 'monster down');
char.quickAnimAdd('singLEFT', 'Monster left note');
char.quickAnimAdd('singRIGHT', 'Monster Right note');

char.loadOffsetFile(char.curCharacter);

char.playAnim('idle');
