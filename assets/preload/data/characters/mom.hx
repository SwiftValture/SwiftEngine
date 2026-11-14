

var tex = null;

tex = Paths.getSparrowAtlas('characters/Mom_Assets');
char.frames = tex;

char.quickAnimAdd('idle', "Mom Idle");
char.quickAnimAdd('singUP', "Mom Up Pose");
char.quickAnimAdd('singDOWN', "MOM DOWN POSE");
char.quickAnimAdd('singLEFT', 'Mom Left Pose');



char.quickAnimAdd('singRIGHT', 'Mom Pose Left');

char.loadOffsetFile(char.curCharacter);

char.playAnim('idle');

char.holdTime = 6.1;
