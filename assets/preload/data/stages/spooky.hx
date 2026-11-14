var halloweenBG = null;
var lightningStrikeBeat = 0;
var lightningOffset = 8;

function create()
{
	var hallowTex = Paths.getSparrowAtlas('halloween_bg');

	halloweenBG = new FlxSprite(-200, -100);
	halloweenBG.frames = hallowTex;
	halloweenBG.animation.addByPrefix('idle', 'halloweem bg0');
	halloweenBG.animation.addByPrefix('lightning', 'halloweem bg lightning strike', 24, false);
	halloweenBG.animation.play('idle');
	halloweenBG.antialiasing = true;
	add(halloweenBG);
}

function beatHit(curBeat)
{
	if (FlxG.random.bool(10) && curBeat > lightningStrikeBeat + lightningOffset)
		lightningStrike(curBeat);
}

function lightningStrike(curBeat)
{
	FlxG.sound.play(Paths.soundRandom('thunder_', 1, 2));
	halloweenBG.animation.play('lightning');

	lightningStrikeBeat = curBeat;
	lightningOffset = FlxG.random.int(8, 24);

	boyfriend.playAnim('scared', true);
	gf.playAnim('scared', true);
}
