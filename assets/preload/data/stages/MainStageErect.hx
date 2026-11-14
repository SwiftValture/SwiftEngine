var orangeLight = null;
var colorShaderBf = null;
var colorShaderGf = null;
var colorShaderDad = null;

function create()
{
	stage.defaultCamZoom = 0.85;

	var solid = new FlxSprite(-500, -1000);
	solid.makeGraphic(2400, 2000, 0xff222026);
	solid.scrollFactor.set(0, 0);
	solid.active = false;
	add(solid);

	var crowd = new FlxSprite(682, 290);
	crowd.frames = Paths.getSparrowAtlas('stage/erect/crowd');
	crowd.animation.addByPrefix('idle', 'idle0', 12, true);
	crowd.animation.play('idle');
	crowd.scrollFactor.set(0.8, 0.8);
	crowd.antialiasing = true;
	add(crowd);

	var brightLightSmall = new FlxSprite(967, -103);
	brightLightSmall.loadGraphic(Paths.image('stage/erect/brightLightSmall'));
	brightLightSmall.scrollFactor.set(1.2, 1.2);
	brightLightSmall.antialiasing = true;
	add(brightLightSmall);

	var bg = new FlxSprite(-765, -247);
	bg.loadGraphic(Paths.image('stage/erect/bg'));
	bg.scrollFactor.set(1, 1);
	bg.antialiasing = true;
	add(bg);

	var server = new FlxSprite(-991, 205);
	server.loadGraphic(Paths.image('stage/erect/server'));
	server.scrollFactor.set(1, 1);
	server.antialiasing = true;
	add(server);

	var lights = new FlxSprite(-847, -245);
	lights.loadGraphic(Paths.image('stage/erect/lights'));
	lights.scrollFactor.set(1.2, 1.2);
	lights.antialiasing = true;
	add(lights);

	orangeLight = new FlxSprite(189, -500);
	orangeLight.loadGraphic(Paths.image('stage/erect/orangeLight'));
	orangeLight.scrollFactor.set(1, 1);
	orangeLight.scale.set(1, 1700);
	orangeLight.updateHitbox();
	orangeLight.alpha = 1;
	orangeLight.antialiasing = true;
	add(orangeLight);

	var lightgreen = new FlxSprite(-171, 242);
	lightgreen.loadGraphic(Paths.image('stage/erect/lightgreen'));
	lightgreen.scrollFactor.set(1, 1);
	lightgreen.alpha = 1;
	lightgreen.antialiasing = true;
	add(lightgreen);

	var lightred = new FlxSprite(-101, 560);
	lightred.loadGraphic(Paths.image('stage/erect/lightred'));
	lightred.scrollFactor.set(1, 1);
	lightred.alpha = 1;
	lightred.antialiasing = true;
	add(lightred);

	var lightAbove = new FlxSprite(804, -117);
	lightAbove.loadGraphic(Paths.image('stage/erect/lightAbove'));
	lightAbove.scrollFactor.set(1, 1);
	lightAbove.alpha = 1;
	lightAbove.antialiasing = true;
	add(lightAbove);

	brightLightSmall.blend = BlendMode.ADD;
	orangeLight.blend = BlendMode.ADD;
	lightgreen.blend = BlendMode.ADD;
	lightred.blend = BlendMode.ADD;

	colorShaderBf = new AdjustColorShader();
	colorShaderBf.hue.value = [12];
	colorShaderBf.saturation.value = [0];
	colorShaderBf.contrast.value = [7];
	colorShaderBf.brightness.value = [-23];

	colorShaderGf = new AdjustColorShader();
	colorShaderGf.hue.value = [-9];
	colorShaderGf.saturation.value = [0];
	colorShaderGf.contrast.value = [-4];
	colorShaderGf.brightness.value = [-30];

	colorShaderDad = new AdjustColorShader();
	colorShaderDad.hue.value = [-32];
	colorShaderDad.saturation.value = [0];
	colorShaderDad.contrast.value = [-23];
	colorShaderDad.brightness.value = [-33];
}

function positionCharacters(dad, gf, boyfriend, gfName)
{
	boyfriend.setPosition(758, 470);
}

function finishSetup(gf, dad, boyfriend)
{
	gf.shader = colorShaderGf;
	dad.shader = colorShaderDad;
	boyfriend.shader = colorShaderBf;
}
