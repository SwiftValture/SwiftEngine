var phillyCityLights = null;
var phillyTrain = null;
var lightFadeShader = null;
var curLight = 0;
var curColor = 0;
var colors = [0xFF31A2FD, 0xFF31FD8C, 0xFFFB33F5, 0xFFFD4531, 0xFFFBA633];
var light = null;
var trainFrameTiming = 0.0;
var trainCars = 8;
var trainFinishing = false;
var trainCooldown = 0;
var startedMoving = false;
var colorShader = null;

function create()
{
	stage.defaultCamZoom = 1.1;

	var bg = new FlxSprite(-100, 0);
	bg.loadGraphic(Paths.image('philly/erect/sky'));
	bg.scrollFactor.set(0.1, 0.1);
	bg.antialiasing = true;
	add(bg);

	var city = new FlxSprite(-255, 45);
	city.loadGraphic(Paths.image('philly/erect/city'));
	city.setGraphicSize(Std.int(city.width * 0.9));
	city.updateHitbox();
	city.scrollFactor.set(0.3, 0.3);
	city.antialiasing = true;
	add(city);

	lightFadeShader = new BuildingShaders();
	phillyCityLights = new FlxTypedGroup();
	add(phillyCityLights);

	light = new FlxSprite(-255, 45).loadGraphic(Paths.image('philly/erect/win'));
	light.scrollFactor.set(0.3, 0.3);
	light.visible = false;
	light.setGraphicSize(Std.int(light.width * 0.9));
	light.updateHitbox();
	light.antialiasing = true;
	light.color = colors[curColor];
	phillyCityLights.add(light);

	var streetBehind = new FlxSprite(-299, 144);
	streetBehind.loadGraphic(Paths.image('philly/erect/behindTrain'));
	streetBehind.scrollFactor.set(1, 1);
	streetBehind.antialiasing = true;
	add(streetBehind);

	phillyTrain = new FlxSprite(2000, 360);
	phillyTrain.loadGraphic(Paths.image('philly/train'));
	phillyTrain.scrollFactor.set(1, 1);
	phillyTrain.antialiasing = true;
	add(phillyTrain);

	var street = new FlxSprite(-299, 144);
	street.loadGraphic(Paths.image('philly/erect/street'));
	street.scrollFactor.set(1, 1);
	street.antialiasing = true;
	add(street);

	stage.trainSound = new FlxSound().loadEmbedded(Paths.sound('train_passes'));
	FlxG.sound.list.add(stage.trainSound);

	colorShader = new AdjustColorShader();
	colorShader.hue.value = [-26];
	colorShader.saturation.value = [-16];
	colorShader.contrast.value = [0];
	colorShader.brightness.value = [-5];
}

function positionCharacters(dad, gf, boyfriend, gfName)
{
	stage.cameraOffsetbfX = -100;
	stage.cameraOffsetbfY = -50;
}

function finishSetup(gf, dad, boyfriend)
{
	gf.shader = colorShader;
	dad.shader = colorShader;
	boyfriend.shader = colorShader;
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

	var curBeatFloat = songPosition / crochet;

	if (songPosition > 0)
		light.alpha = 1 - (FlxEase.cubeIn((curBeatFloat / 4) % 1) * 0.85);
	else
		light.alpha = 0;
}

function beatHit(curBeat)
{
	if (!stage.trainMoving)
		trainCooldown += 1;

	if (curBeat % 4 == 0)
	{
		lightFadeShader.reset();

		phillyCityLights.forEach(function(l)
		{
			l.visible = false;
		});

		curLight = FlxG.random.int(0, phillyCityLights.length - 1);
		phillyCityLights.members[curLight].visible = true;

		var newColor = FlxG.random.int(0, colors.length - 2);
		if (newColor >= curColor)
			newColor++;
		curColor = newColor;
		light.color = colors[curColor];
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
