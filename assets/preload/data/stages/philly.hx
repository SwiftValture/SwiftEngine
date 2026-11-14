var phillyCityLights = null;
var phillyTrain = null;
var lightFadeShader = null;
var curLight = 0;
var trainFrameTiming = 0.0;
var trainCars = 8;
var trainFinishing = false;
var trainCooldown = 0;
var startedMoving = false;

function create()
{
	var bg = new FlxSprite(-100).loadGraphic(Paths.image('philly/sky'));
	bg.scrollFactor.set(0.1, 0.1);
	bg.antialiasing = true;
	add(bg);

	var city = new FlxSprite(-10).loadGraphic(Paths.image('philly/city'));
	city.scrollFactor.set(0.3, 0.3);
	city.setGraphicSize(Std.int(city.width * 0.85));
	city.updateHitbox();
	city.antialiasing = true;
	add(city);

	lightFadeShader = new BuildingShaders();
	phillyCityLights = new FlxTypedGroup();
	add(phillyCityLights);

	for (i in 0...5)
	{
		var light = new FlxSprite(city.x).loadGraphic(Paths.image('philly/win' + i));
		light.scrollFactor.set(0.3, 0.3);
		light.visible = false;
		light.setGraphicSize(Std.int(light.width * 0.85));
		light.updateHitbox();
		light.antialiasing = true;
		light.shader = lightFadeShader.shader;
		phillyCityLights.add(light);
	}

	var streetBehind = new FlxSprite(-40, 50).loadGraphic(Paths.image('philly/behindTrain'));
	streetBehind.antialiasing = true;
	add(streetBehind);

	phillyTrain = new FlxSprite(2000, 360).loadGraphic(Paths.image('philly/train'));
	phillyTrain.antialiasing = true;
	add(phillyTrain);

	stage.trainSound = new FlxSound().loadEmbedded(Paths.sound('train_passes'));
	FlxG.sound.list.add(stage.trainSound);

	var street = new FlxSprite(-40, streetBehind.y).loadGraphic(Paths.image('philly/street'));
	street.antialiasing = true;
	add(street);
}

function update(elapsed, inCutscene)
{
	if (stage.trainMoving)
	{
		trainFrameTiming += elapsed;

		if (trainFrameTiming >= 1 / 24)
		{
			updateTrainPos();
			trainFrameTiming = 0;
		}
	}

	lightFadeShader.update((crochet / 1000) * FlxG.elapsed * 1.5);
}

function beatHit(curBeat)
{
	if (!stage.trainMoving)
		trainCooldown += 1;

	if (curBeat % 4 == 0)
	{
		lightFadeShader.reset();

		phillyCityLights.forEach(function(light)
		{
			light.visible = false;
		});

		curLight = FlxG.random.int(0, phillyCityLights.length - 1);
		phillyCityLights.members[curLight].visible = true;
	}

	if (curBeat % 8 == 4 && FlxG.random.bool(30) && !stage.trainMoving && trainCooldown > 8)
	{
		trainCooldown = FlxG.random.int(-4, 0);
		trainStart();
	}
}

function trainStart()
{
	stage.trainMoving = true;
	stage.trainSound.play(true);
}

function updateTrainPos()
{
	if (stage.trainSound.time >= 4700)
	{
		startedMoving = true;
		gf.playAnim('hairBlow');
	}

	if (startedMoving)
	{
		phillyTrain.x -= 400;

		if (phillyTrain.x < -2000 && !trainFinishing)
		{
			phillyTrain.x = -1150;
			trainCars -= 1;

			if (trainCars <= 0)
				trainFinishing = true;
		}

		if (phillyTrain.x < -4000 && trainFinishing)
			trainReset();
	}
}

function trainReset()
{
	gf.playAnim('hairFall');
	phillyTrain.x = FlxG.width + 200;
	stage.trainMoving = false;
	trainCars = 8;
	trainFinishing = false;
	startedMoving = false;
}
