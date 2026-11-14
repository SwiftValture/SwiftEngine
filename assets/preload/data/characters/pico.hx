

var tex = null;

tex = Paths.getSparrowAtlas('characters/Pico_FNF_assetss');
char.frames = tex;
char.quickAnimAdd('idle', "Pico Idle Dance");
char.quickAnimAdd('singUP', 'pico Up note0');
char.quickAnimAdd('singDOWN', 'Pico Down Note0');
if (char.isPlayer)
{
	char.quickAnimAdd('singLEFT', 'Pico NOTE LEFT0');
	char.quickAnimAdd('singRIGHT', 'Pico Note Right0');
	char.quickAnimAdd('singRIGHTmiss', 'Pico Note Right Miss');
	char.quickAnimAdd('singLEFTmiss', 'Pico NOTE LEFT miss');
}
else
{
	
	char.quickAnimAdd('singLEFT', 'Pico Note Right0');
	char.quickAnimAdd('singRIGHT', 'Pico NOTE LEFT0');
	char.quickAnimAdd('singRIGHTmiss', 'Pico NOTE LEFT miss');
	char.quickAnimAdd('singLEFTmiss', 'Pico Note Right Miss');
}

char.quickAnimAdd('singUPmiss', 'pico Up note miss');
char.quickAnimAdd('singDOWNmiss', 'Pico Down Note MISS');

char.loadOffsetFile(char.curCharacter);

char.playAnim('idle');

char.flipX = true;

char.holdTime = 6.1;
