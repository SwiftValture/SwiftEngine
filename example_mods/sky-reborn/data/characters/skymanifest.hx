char.isAdobeCharacter = true;
char.frames = FlxAnimateFrames.fromAnimate('characters/skyManifest');
char.antialiasing = true;
char.anim.addBySymbol('idle', 'Idle', 24, false);
char.anim.addBySymbol('singLEFT', 'Left', 24, false);
char.anim.addBySymbol('singDOWN', 'Down', 24, false);
char.anim.addBySymbol('singUP', 'Up', 24, false);
char.anim.addBySymbol('singRIGHT', 'Right', 24, false);
char.loadOffsetFile(char.curCharacter);
