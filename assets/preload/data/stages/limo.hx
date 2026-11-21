var grpLimoDancers = null;
var fastCar = null;
var fastCarCanDrive = true;

function create()
{
	stage.curStage = 'limo';
	stage.gfVersion = 'gf-car';
	stage.defaultCamZoom = 0.90;

	var skyBG = new FlxSprite(-120, -50).loadGraphic(Paths.image('limo/limoSunset'));
	skyBG.scrollFactor.set(0.1, 0.1);
	skyBG.antialiasing = true;
	add(skyBG);

	var bgLimo = new FlxSprite(-200, 480);
	bgLimo.frames = Paths.getSparrowAtlas('limo/bgLimo');
	bgLimo.animation.addByPrefix('drive', "background limo pink", 24);
	bgLimo.animation.play('drive');
	bgLimo.scrollFactor.set(0.4, 0.4);
	bgLimo.antialiasing = true;
	add(bgLimo);

	grpLimoDancers = new FlxTypedGroup();
	add(grpLimoDancers);

	for (i in 0...5)
	{
		var dancer = new BackgroundDancer((370 * i) + 130, bgLimo.y - 400);
		dancer.scrollFactor.set(0.4, 0.4);
		grpLimoDancers.add(dancer);
	}

	var overlayShit = new FlxSprite(-500, -600).loadGraphic(Paths.image('limo/limoOverlay'));
	overlayShit.alpha = 0.5;

	var limo = new FlxSprite(-120, 550);
	limo.frames = Paths.getSparrowAtlas('limo/limoDrive');
	limo.animation.addByPrefix('drive', "Limo stage", 24);
	limo.animation.play('drive');
	limo.antialiasing = true;
	stage.limo = limo;

	fastCar = new FlxSprite(-300, 160).loadGraphic(Paths.image('limo/fastCarLol'));

	// PlayState.windyCombo = true;
}

function positionCharacters(dad, gf, boyfriend, gfName)
{
	boyfriend.y -= 220;
	boyfriend.x += 260;

	resetFastCar();
	add(fastCar);
}

function beatHit(curBeat)
{
	grpLimoDancers.forEach(function(dancer)
	{
		dancer.dance();
	});

	if (FlxG.random.bool(10) && fastCarCanDrive)
		fastCarDrive();
}

function resetFastCar()
{
	fastCar.x = -12600;
	fastCar.y = FlxG.random.int(140, 250);
	fastCar.velocity.x = 0;
	fastCarCanDrive = true;
}

function fastCarDrive()
{
	FlxG.sound.play(Paths.soundRandom('carPass', 0, 1), 0.7);

	fastCar.velocity.x = (FlxG.random.int(170, 220) / FlxG.elapsed) * 3;
	fastCarCanDrive = false;
	new FlxTimer().start(2, function(tmr)
	{
		resetFastCar();
	});
}
