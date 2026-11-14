var scary:FlxSprite;

function create()
{
	stage.gfVersion = 'gf-pixel';

	var posX = 400;
	var posY = 200;

	var bg = new FlxSprite(posX, posY);
	bg.frames = Paths.getSparrowAtlas('weeb/animatedEvilSchool');
	bg.animation.addByPrefix('idle', 'background 2', 24);
	bg.animation.play('idle');
	bg.scrollFactor.set(0.8, 0.9);
	bg.scale.set(6, 6);
	add(bg);

	scary = new FlxSprite(posX, posY + 250);
	scary.frames = Paths.getSparrowAtlas('weeb/bgGhouls');
	scary.animation.addByPrefix('idle', 'BG freaks glitch instance 1', 24, false);
	scary.scrollFactor.set(0.8, 0.9);
	scary.scale.set(6, 6);
	scary.alpha = 0;
	add(scary);
}

function beatHit(curBeat)
{
	if (curBeat % 2 == 0 && scary.alpha > 0)
		scary.animation.play('idle', true);

	switch (curBeat)
	{
		case 65:
			scary.alpha = 1;
			scary.animation.play('idle', true);
		case 96:
			scary.alpha = 0;
		case 160:
			scary.alpha = 1;
			scary.animation.play('idle', true);
		case 192:
			scary.alpha = 0;
		case 257:
			scary.alpha = 1;
			scary.animation.play('idle', true);
		case 288:
			scary.alpha = 0;
	}
}

function positionCharacters(dad, gf, boyfriend, gfName)
{
	var evilTrail = new FlxTrail(dad, null, 4, 24, 0.3, 0.069);
	add(evilTrail);

	boyfriend.x += 200;
	boyfriend.y += 220;
	gf.x += 180;
	gf.y += 300;
}
