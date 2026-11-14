var bg;
var clouds;
var grass;
var spaceCooldown = 0.0;
var boobs;
var txt;
var bodies;
var handsA = [];
var handsASize = [];
var handsABool = [];
var handsB = [];
var handsBSize = [];
var handsBBool = [];
var maxHands = 3;
var vin = null;
var blur = null;
var newBlur = 3;
var oldBlur = 1;
var allowShit = false;

function create()
{
	stage.defaultCamZoom = 1;

	var l_ = 'stages/SM/';

	bg = new FlxSprite().loadGraphic(Paths.image(l_ + 'sky'));
	bg.scrollFactor.set(0, 0);
	bg.screenCenter();
	bg.antialiasing = true;
	add(bg);

	clouds = new FlxBackdrop(Paths.image(l_ + 'clouds'), FlxAxes.X);
	clouds.velocity.x = 10;
	clouds.scrollFactor.set(0, 0);
	clouds.antialiasing = true;
	add(clouds);

	for (i in 0...maxHands)
	{
		handsASize[i] = FlxG.random.float(0.7, 1.3);

		handsA.push(new FlxSprite(0, 0));
		handsA[i].frames = Paths.getSparrowAtlas(l_ + 'hand');
		handsA[i].animation.addByPrefix('handsmall', 'handsmall', 18, false);
		handsA[i].scrollFactor.set(0, 0);
		handsA[i].screenCenter();
		handsA[i].x = FlxG.random.int(30 + (i * 400), 400 + (i * 400));
		handsA[i].y += 60 - (handsASize[i] * 15);
		handsA[i].scale.set(handsASize[i], handsASize[i]);
		handsA[i].updateHitbox();
		handsA[i].flipX = FlxG.random.bool(50);
		handsA[i].antialiasing = true;
		add(handsA[i]);
	}

	for (i in 0...maxHands)
	{
		handsBSize[i] = FlxG.random.float(0.7, 1.3);

		handsB.push(new FlxSprite(0, 0));
		handsB[i].frames = Paths.getSparrowAtlas(l_ + 'hand2');
		handsB[i].animation.addByPrefix('handsmall2', 'handsmall2', 18, false);
		handsB[i].scrollFactor.set(0, 0);
		handsB[i].screenCenter();
		handsB[i].x = FlxG.random.int(30 + (i * 400), 400 + (i * 400));
		handsB[i].y += 100 - (handsBSize[i] * 10);
		handsB[i].scale.set(handsBSize[i], handsBSize[i]);
		handsB[i].updateHitbox();
		handsB[i].flipX = FlxG.random.bool(50);
		handsB[i].antialiasing = true;
		add(handsB[i]);
	}

	bodies = new FlxSprite().loadGraphic(Paths.image(l_ + 'bodies'));
	bodies.scrollFactor.set(0, 0);
	bodies.setGraphicSize(1280, 720);
	bodies.screenCenter();
	bodies.alpha = 0;
	bodies.antialiasing = true;
	add(bodies);

	add(dad);

	grass = new FlxAnimate(0, 0, Paths.getAnimateAtlas('stages/SM/grass'));
	grass.scrollFactor.set(0, 0);
	grass.anim.addBySymbol('grasssmall', 'grasssmall', 18, true);
	grass.anim.play('grasssmall');
	grass.screenCenter();
	grass.x += 150;
	grass.y += 250;
	grass.antialiasing = true;
	add(grass);

	boobs = new FlxSprite(0, 0).makeGraphic(1280, 720, FlxColor.BLACK);
	boobs.alpha = 0;
	boobs.scrollFactor.set(0, 0);
	add(boobs);

	txt = new FlxSprite().loadGraphic(Paths.image(l_ + 'spacebar'));
	txt.scrollFactor.set(0, 0);
	txt.screenCenter();
	txt.x -= 90;
	txt.y += 90;
	txt.alpha = 0;
	txt.antialiasing = true;
	add(txt);

	vin = new Vinegar();
	vin.strength.value = [3.0];
	blur = new GausianBlur();
	blur.fuck.value = [0.05];

	FlxG.camera.filters = [new ShaderFilter(vin), new ShaderFilter(blur)];
}

function positionCharacters(dad, gf, boyfriend, gfName)
{
	dad.x += 300;
	dad.y += 100;
	stage.cameraOffsetbfX = -500;
	dad.scrollFactor.set(0, 0);

	gf.alpha = 0;
	boyfriend.alpha = 0;
}

function beatHit(curBeat)
{
	switch (curBeat)
	{
		case 224:
			boobs.alpha = txt.alpha = 1;
		case 240:
			boobs.alpha = txt.alpha = 0;
			for (i in 0...maxHands)
			{
				handsA[i].animation.play('handsmall');
				handsB[i].animation.play('handsmall2');
			}
			allowShit = true;
			newBlur = 3;
		case 303:
			allowShit = false;
			newBlur = 3;
		case 396:
			camGame.fade(FlxColor.BLACK, stepCrochet / 1000 * 16.5, false);
		case 400:
			bodies.alpha = 1;
			camGame.stopFX();
			camGame.flash(FlxColor.WHITE, 1);
		case 528:
			camGame.alpha = camHUD.alpha = 0;
	}
}

function update(elapsed:Float)
{
	if (newBlur < 3)
		vin.strength.value = [fpsLerp(oldBlur, newBlur, 0.05)];
	else if (vin.strength.value[0] < 3)
		vin.strength.value = [fpsLerp(oldBlur, 3, 0.05)];

	oldBlur = vin.strength.value[0];

	if (vin.strength.value[0] >= 3)
		vin.strength.value = [3];

	if (vin.strength.value[0] < 0)
		PlayState.instance.health = 0;

	if (allowShit)
	{
		spaceCooldown -= elapsed;
		if (spaceCooldown <= 0)
			newBlur -= 0.2 * elapsed;
		if (FlxG.keys.justPressed.SPACE)
		{
			newBlur += 0.2;
			spaceCooldown = 0.5;
		}
	}

	var hp = PlayState.instance.health;
	var targetBlur:Float = 0.05;
	if (hp <= 0.5)
		targetBlur = (0.5 - hp) + 0.05;

	if (blur?.fuck?.value != null && blur.fuck.value.length > 0)
		blur.fuck.value = [fpsLerp(blur.fuck.value[0], targetBlur, 0.5)];
}
