var colorShaderBf = null;
var colorShaderGf = null;
var colorShaderDad = null;
var rainShader = null;
var time = 0.0;
var phillySkyline:FlxSprite;
var scrollingSky:FlxTiledSprite;
var paperInterruptable:Bool = true;
var paper:FlxSprite;
var cars2:FlxSprite;
var cars1:FlxSprite;
var phillyTraffic_lightmap = null;
var trafficLights:FLxSprite;
var lightsStop:Bool = false;
var lastChange:Int = 0;
var changeInterval:Int = 8;
var carWaiting:Bool = false;
var carInterruptable:Bool = true;
var car2Interruptable:Bool = true;

var mistData:Array<Dynamic> = [
	['Mid', -650, -100, 1.2, 1, 0.6, 172],
	['Mid', -650, -100, 1.1, 1, 0.6, 150],
	['Back', -650, -100, 1.2, 1, 0.8, -80],
	['Mid', -650, -100, 0.95, 0.8, 0.5, -50],
	['Back', -650, -100, 0.8, 0.7, 1, 40],
	['Mid', -650, -100, 0.5, 1.1, 1, 20]
];

function create()
{
	stage.defaultCamZoom = 0.77;

	scrollingSky = new FlxTiledSprite(Paths.image('phillyStreets/erect/phillySkybox'), 2922, 718, true, false);
	scrollingSky.setPosition(-650, -375);
	scrollingSky.scrollFactor.set(0.1, 0.1);
	scrollingSky.scale.set(0.65, 0.65);
	add(scrollingSky);

	phillySkyline = new FlxSprite(-545, -273);
	phillySkyline.loadGraphic(Paths.image('phillyStreets/erect/phillySkyline'));
	phillySkyline.scrollFactor.set(0.2, 0.2);
	phillySkyline.antialiasing = true;
	add(phillySkyline);

	var phillyForegroundCity = new FlxSprite(600, 69);
	phillyForegroundCity.loadGraphic(Paths.image('phillyStreets/erect/phillyForegroundCity'));
	phillyForegroundCity.scrollFactor.set(0.3, 0.3);
	phillyForegroundCity.antialiasing = true;
	add(phillyForegroundCity);

	var phillyForegroundCity2 = new FlxSprite(1860, 185);
	phillyForegroundCity2.loadGraphic(Paths.image('phillyStreets/erect/phillyForegroundCity'));
	phillyForegroundCity2.scrollFactor.set(0.3, 0.3);
	phillyForegroundCity2.angle = 5;
	phillyForegroundCity2.flipX = true;
	phillyForegroundCity2.antialiasing = true;
	add(phillyForegroundCity2);

	var phillyConstruction2 = new FlxSprite(1795, 360);
	phillyConstruction2.loadGraphic(Paths.image('phillyStreets/erect/phillyConstruction'));
	phillyConstruction2.scrollFactor.set(0.7, 1);
	phillyConstruction2.antialiasing = true;
	add(phillyConstruction2);

	var phillyHighwayLights = new FlxSprite(122, 201);
	phillyHighwayLights.loadGraphic(Paths.image('phillyStreets/erect/phillyHighwayLights'));
	phillyHighwayLights.scrollFactor.set(0.8, 0.8);
	phillyHighwayLights.antialiasing = true;
	add(phillyHighwayLights);

	var phillyHighwayLights_lightmap = new FlxSprite(122, 201);
	phillyHighwayLights_lightmap.loadGraphic(Paths.image('phillyStreets/phillyHighwayLights_lightmap'));
	phillyHighwayLights_lightmap.scrollFactor.set(0.8, 0.8);
	phillyHighwayLights_lightmap.alpha = 1;
	phillyHighwayLights_lightmap.antialiasing = true;
	add(phillyHighwayLights_lightmap);

	var phillyHighway2 = new FlxSprite(-23, 105);
	phillyHighway2.loadGraphic(Paths.image('phillyStreets/erect/phillyHighway'));
	phillyHighway2.scrollFactor.set(0.8, 0.8);
	phillyHighway2.antialiasing = true;
	add(phillyHighway2);

	var grey1 = new FlxSprite(-388, 7);
	grey1.loadGraphic(Paths.image('phillyStreets/erect/greyGradient'));
	grey1.scrollFactor.set(1, 1);
	grey1.scale.set(1.3, 1.3);
	grey1.updateHitbox();
	grey1.alpha = 0.3;
	grey1.antialiasing = true;
	add(grey1);

	var grey2 = new FlxSprite(-388, 7);
	grey2.loadGraphic(Paths.image('phillyStreets/erect/greyGradient'));
	grey2.scrollFactor.set(1, 1);
	grey2.scale.set(1.3, 1.3);
	grey2.updateHitbox();
	grey2.alpha = 0.8;
	grey2.antialiasing = true;
	add(grey2);

	cars1 = new FlxSprite(1200, 818);
	cars1.frames = Paths.getSparrowAtlas('phillyStreets/erect/phillyCars');
	cars1.animation.addByPrefix('car1', 'car1', 24, false);
	cars1.animation.addByPrefix('car2', 'car2', 24, false);
	cars1.animation.addByPrefix('car3', 'car3', 24, false);
	cars1.animation.addByPrefix('car4', 'car4', 24, false);
	cars1.scrollFactor.set(0.9, 1);
	cars1.antialiasing = true;
	add(cars1);

	cars2 = new FlxSprite(1200, 818);
	cars2.frames = Paths.getSparrowAtlas('phillyStreets/erect/phillyCars');
	cars2.animation.addByPrefix('car1', 'car1', 24, false);
	cars2.animation.addByPrefix('car2', 'car2', 24, false);
	cars2.animation.addByPrefix('car3', 'car3', 24, false);
	cars2.animation.addByPrefix('car4', 'car4', 24, false);
	cars2.flipX = true;
	cars2.scrollFactor.set(0.9, 1);
	cars2.antialiasing = true;
	add(cars2);

	trafficLights = new FlxSprite(1840, 608);
	trafficLights.frames = Paths.getSparrowAtlas('phillyStreets/erect/phillyTraffic');
	trafficLights.animation.addByPrefix('togreen', 'redtogreen', 24, false);
	trafficLights.animation.addByPrefix('tored', 'greentored', 24, false);
	trafficLights.scrollFactor.set(0.9, 1);
	trafficLights.antialiasing = true;
	add(trafficLights);

	phillyTraffic_lightmap = new FlxSprite(1840, 608);
	phillyTraffic_lightmap.loadGraphic(Paths.image('phillyStreets/erect/phillyTraffic_lightmap'));
	phillyTraffic_lightmap.scrollFactor.set(0.9, 1);
	phillyTraffic_lightmap.alpha = 0.6;
	phillyTraffic_lightmap.antialiasing = true;
	phillyTraffic_lightmap.blend = BlendMode.ADD;
	add(phillyTraffic_lightmap);

	var phillyForeground = new FlxSprite(88, 317);
	phillyForeground.loadGraphic(Paths.image('phillyStreets/erect/phillyForeground'));
	phillyForeground.scrollFactor.set(1, 1);
	phillyForeground.antialiasing = true;
	add(phillyForeground);

	paper = new FlxSprite(350, 608);
	paper.frames = Paths.getSparrowAtlas('phillyStreets/erect/paper');
	paper.animation.addByPrefix('paperBlow', 'Paper Blowing instance 1', 24, false);
	paper.animation.play('paperBlow');
	paper.scrollFactor.set(1.1, 1.1);
	paper.alpha = 0;
	paper.antialiasing = true;

	colorShaderGf = new AdjustColorShader();
	colorShaderGf.hue.value = [-5];
	colorShaderGf.saturation.value = [-40];
	colorShaderGf.contrast.value = [-25];
	colorShaderGf.brightness.value = [-20];

	colorShaderDad = new AdjustColorShader();
	colorShaderDad.hue.value = [-5];
	colorShaderDad.saturation.value = [-40];
	colorShaderDad.contrast.value = [-25];
	colorShaderDad.brightness.value = [-20];

	colorShaderBf = new AdjustColorShader();
	colorShaderBf.hue.value = [-5];
	colorShaderBf.saturation.value = [-40];
	colorShaderBf.contrast.value = [-25];
	colorShaderBf.brightness.value = [-20];

	var rainShaderIntensity = 0.0;
	if (songName == 'lit-up-boyfriend')
		rainShaderIntensity = 0.02;
	else if (songName == 'darnell-boyfriend')
		rainShaderIntensity = 0.01;

	rainShader = new RainShader();
	rainShader.uRainColor.value = getColorVec(stage.rainColor);
	rainShader.uScale.value = [FlxG.height / 200];
	rainShader.uIntensity.value = [rainShaderIntensity];
	rainShader.uTime.value = [0];
	FlxG.camera.filters = [new ShaderFilter(rainShader)];

	initMist();
	resetCar(true, true);
	resetStageValues();
}

var mists:Array<FlxBackdrop> = [];

function initMist()
{
	for (mist in mistData)
	{
		var mistBackdrop = new FlxBackdrop(Paths.image('phillyStreets/erect/mist' + mist[0]), 0x01);
		mistBackdrop.setPosition(mist[1], mist[2]);
		mistBackdrop.scrollFactor.set(mist[3], mist[3]);
		mistBackdrop.scale.set(mist[4], mist[4]);
		mistBackdrop.color = 0xFF5c5c5c;
		mistBackdrop.alpha = mist[5];
		mistBackdrop.velocity.x = mist[6];
		mistBackdrop.blend = BlendMode.ADD;

		mists.push(mistBackdrop);
	}

	insertBefore(phillyTraffic_lightmap, mists[5]);
	insertAfter(phillyCars2, mists[4]);
	insertAfter(phillySkyline, mists[3]);
}

function changeLights(curBeat)
{
	lastChange = curBeat;
	lightsStop = !lightsStop;

	if (lightsStop)
	{
		trafficLights.animation.play('tored');
		changeInterval = 20;
	}
	else
	{
		trafficLights.animation.play('togreen');
		changeInterval = 30;
		if (carWaiting)
			finishCarLights(cars1);
	}
}

function resetCar(left:Bool, right:Bool)
{
	if (left)
	{
		carWaiting = false;
		carInterruptable = true;
		if (cars1 != null)
		{
			FlxTween.cancelTweensOf(cars1);
			cars1.x = 1200;
			cars1.y = 818;
			cars1.angle = 0;
		}
	}

	if (right)
	{
		car2Interruptable = true;
		if (cars2 != null)
		{
			FlxTween.cancelTweensOf(cars2);
			cars2.x = 1200;
			cars2.y = 818;
			cars2.angle = 0;
		}
	}
}

function finishCarLights(sprite)
{
	carWaiting = false;
	var duration:Float = FlxG.random.float(1.8, 3);
	var rotations:Array<Int> = [-5, 18];
	var offset:Array<Float> = [306.6, 168.3];
	var startdelay:Float = FlxG.random.float(0.2, 1.2);

	var path:Array<FlxPoint> = [
		FlxPoint.get(1950 - offset[0] - 80, 980 - offset[1] + 15),
		FlxPoint.get(2400 - offset[0], 980 - offset[1] - 50),
		FlxPoint.get(3102 - offset[0], 1127 - offset[1] + 40)
	];

	FlxTween.angle(sprite, rotations[0], rotations[1], duration, {ease: FlxEase.sineIn, startDelay: startdelay});
	FlxTween.quadPath(sprite, path, duration, true, {ease: FlxEase.sineIn, startDelay: startdelay, onComplete: function(_) carInterruptable = true});
}

function driveCarLights(sprite)
{
	carInterruptable = false;
	FlxTween.cancelTweensOf(sprite);
	var variant:Int = FlxG.random.int(1, 4);
	sprite.animation.play('car' + variant);
	var extraOffset = [0, 0];
	var duration:Float = 2;

	switch (variant)
	{
		case 1:
			duration = FlxG.random.float(1, 1.7);
		case 2:
			extraOffset = [20, -15];
			duration = FlxG.random.float(0.9, 1.5);
		case 3:
			extraOffset = [30, 50];
			duration = FlxG.random.float(1.5, 2.5);
		case 4:
			extraOffset = [10, 60];
			duration = FlxG.random.float(1.5, 2.5);
	}
	var rotations:Array<Int> = [-7, -5];
	var offset:Array<Float> = [306.6, 168.3];
	sprite.offset.set(extraOffset[0], extraOffset[1]);

	var path:Array<FlxPoint> = [
		FlxPoint.get(1500 - offset[0] - 20, 1049 - offset[1] - 20),
		FlxPoint.get(1770 - offset[0] - 80, 994 - offset[1] + 10),
		FlxPoint.get(1950 - offset[0] - 80, 980 - offset[1] + 15)
	];

	FlxTween.angle(sprite, rotations[0], rotations[1], duration, {ease: FlxEase.cubeOut});
	FlxTween.quadPath(sprite, path, duration, true, {
		ease: FlxEase.cubeOut,
		onComplete: function(_)
		{
			carWaiting = true;
			if (!lightsStop)
				finishCarLights(cars1);
		}
	});
}

function driveCar(sprite)
{
	carInterruptable = false;
	FlxTween.cancelTweensOf(sprite);
	var variant:Int = FlxG.random.int(1, 4);
	sprite.animation.play('car' + variant);
	var extraOffset = [0, 0];
	var duration:Float = 2;
	switch (variant)
	{
		case 1:
			duration = FlxG.random.float(1, 1.7);
		case 2:
			extraOffset = [20, -15];
			duration = FlxG.random.float(0.6, 1.2);
		case 3:
			extraOffset = [30, 50];
			duration = FlxG.random.float(1.5, 2.5);
		case 4:
			extraOffset = [10, 60];
			duration = FlxG.random.float(1.5, 2.5);
	}
	var offset:Array<Float> = [306.6, 168.3];
	sprite.offset.set(extraOffset[0], extraOffset[1]);
	var rotations:Array<Int> = [-8, 18];
	var path:Array<FlxPoint> = [
		FlxPoint.get(1570 - offset[0], 1049 - offset[1] - 30),
		FlxPoint.get(2400 - offset[0], 980 - offset[1] - 50),
		FlxPoint.get(3102 - offset[0], 1127 - offset[1] + 40)
	];

	FlxTween.angle(sprite, rotations[0], rotations[1], duration, null);
	FlxTween.quadPath(sprite, path, duration, true, {ease: null, onComplete: function(_) carInterruptable = true});
}

function driveCarBack(sprite)
{
	car2Interruptable = false;
	FlxTween.cancelTweensOf(sprite);
	var variant:Int = FlxG.random.int(1, 4);
	sprite.animation.play('car' + variant);
	var extraOffset = [0, 0];
	var duration:Float = 2;
	switch (variant)
	{
		case 1:
			duration = FlxG.random.float(1, 1.7);
		case 2:
			extraOffset = [20, -15];
			duration = FlxG.random.float(0.6, 1.2);
		case 3:
			extraOffset = [30, 50];
			duration = FlxG.random.float(1.5, 2.5);
		case 4:
			extraOffset = [10, 60];
			duration = FlxG.random.float(1.5, 2.5);
	}
	var offset:Array<Float> = [306.6, 168.3];
	sprite.offset.set(extraOffset[0], extraOffset[1]);
	var rotations:Array<Int> = [18, -8];
	var path:Array<FlxPoint> = [
		FlxPoint.get(3102 - offset[0], 1127 - offset[1] + 60),
		FlxPoint.get(2400 - offset[0], 980 - offset[1] - 30),
		FlxPoint.get(1570 - offset[0], 1049 - offset[1] - 10)
	];

	FlxTween.angle(sprite, rotations[0], rotations[1], duration, null);
	FlxTween.quadPath(sprite, path, duration, true, {ease: null, onComplete: function(_) car2Interruptable = true});
}

function resetStageValues()
{
	lastChange = 0;
	changeInterval = 8;
	lightsStop = false;
	if (trafficLights != null)
		trafficLights.animation.play('togreen');
}

function positionCharacters(dad, gf, boyfriend, gfName)
{
	dad.setPosition(650, 640);
	stage.cameraOffsetDadX = 300;
	stage.cameraOffsetbfX = -350;
	boyfriend.setPosition(1944, 820);
	gf.setPosition(1200, 440);
	gf.scrollFactor.set(1, 1);
}

function finishSetup(gf, dad, boyfriend)
{
	gf.shader = colorShaderGf;
	dad.shader = colorShaderDad;
	boyfriend.shader = colorShaderBf;
	add(paper);
	add(mists[0]);
	add(mists[1]);
	add(mists[2]);
}

var _timer:Float = 0;

function update(elapsed, inCutscene)
{
	if (rainShader != null)
	{
		time += elapsed * stage.rainTimeScale;

		rainShader.uCameraBounds.value = [
			FlxG.camera.viewLeft,
			FlxG.camera.viewTop,
			FlxG.camera.viewRight,
			FlxG.camera.viewBottom
		];
		rainShader.uTime.value = [time];

		stage.rainTimeScale = smoothLerpPrecision(stage.rainTimeScale, 0.02, elapsed, 2.5);
	}

	_timer += elapsed;
	mists[0].y = 660 + (Math.sin(_timer * 0.35) * 70);
	mists[1].y = 500 + (Math.sin(_timer * 0.3) * 80);
	mists[2].y = 540 + (Math.sin(_timer * 0.4) * 60);
	mists[3].y = 230 + (Math.sin(_timer * 0.3) * 70);
	mists[4].y = 170 + (Math.sin(_timer * 0.35) * 50);
	mists[5].y = -80 + (Math.sin(_timer * 0.08) * 100);

	if (scrollingSky != null)
	{
		scrollingSky.scrollX -= FlxG.elapsed * 22;
	}
}

function getColorVec(color)
{
	return [(color >> 16 & 0xFF) / 255, (color >> 8 & 0xFF) / 255, (color & 0xFF) / 255];
}

function lerp(base, target, alpha)
{
	if (alpha == 0)
		return base;
	if (alpha == 1)
		return target;
	return base + alpha * (target - base);
}

function smoothLerpPrecision(base, target, deltaTime, duration)
{
	if (deltaTime == 0)
		return base;
	if (base == target)
		return target;
	return lerp(target, base, Math.pow(1 / 100, deltaTime / duration));
}

function beatHit(curBeat)
{
	if (paper != null && FlxG.random.bool(0.6) && paperInterruptable == true)
	{
		paper.alpha = 1;
		paper.animation.play('paperBlow');
		paper.y = 608 + FlxG.random.float(-150, 150);
		paperInterruptable = false;
		new FlxTimer().start(2, function(tmr:FlxTimer)
		{
			paperInterruptable = true;
			paper.alpha = 0;
		});
	}

	if (cars1 != null)
	{
		if (FlxG.random.bool(10) && curBeat != (lastChange + changeInterval) && carInterruptable)
		{
			if (!lightsStop)
				driveCar(cars1);
			else
				driveCarLights(cars1);
		}

		if (trafficLights != null && curBeat == (lastChange + changeInterval))
			changeLights(curBeat);
	}

	if (cars2 != null && FlxG.random.bool(10) && curBeat != (lastChange + changeInterval) && car2Interruptable && !lightsStop)
		driveCarBack(cars2);
}
