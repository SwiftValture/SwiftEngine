

var tex = null;

tex = Paths.getSparrowAtlas('characters/boyf');
char.frames = tex;
char.animation.addByPrefix('idle', 'IDLE', 24, false);
char.animation.addByPrefix('singDOWN', 'DOWN', 24, false);
char.animation.addByPrefix('singRIGHT', 'LEFT', 24, false);
char.animation.addByPrefix('singLEFT', 'RIGHT', 24, false);
char.animation.addByPrefix('singUP', 'UP', 24, false);

char.animation.addByPrefix('singUpmiss', 'upmiss', 24, false);
char.animation.addByPrefix('singLEFTmiss', 'leftmiss', 24, false);
char.animation.addByPrefix('singDOWNmiss', 'downmiss', 24, false);
char.animation.addByPrefix('singRIGHTmiss', 'misright', 24, false);

char.animation.addByPrefix('singLEFT-alt', 'b4', 24, false);
char.animation.addByPrefix('singDOWN-alt', 'b1', 24, false);
char.animation.addByPrefix('singUP-alt', 'b2', 24, false);
char.animation.addByPrefix('singRIGHT-alt', 'b3', 24, false);

char.loadOffsetFile(char.curCharacter);

char.playAnim('idle');

char.holdTime = 6.1;
char.flipX = true;

char.healthIcon = 'boyf';
