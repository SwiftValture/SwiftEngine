var upperBoppers = null;
var bottomBoppers = null;
var bottomIsAtlas = false;
var santa = null;
var colorShader = null;

function create()
{
	stage.defaultCamZoom = 0.8;
	stage.gfVersion = 'gf-christmas';

	var bgWalls = new FlxSprite();
	bgWalls.loadGraphic(Paths.image('christmas/erect/bgWalls'));
	bgWalls.scale.set(0.9, 0.9);
	bgWalls.updateHitbox();
	bgWalls.setPosition(-726, -566);
	bgWalls.scrollFactor.set(0.2, 0.2);
	bgWalls.antialiasing = true;
	add(bgWalls);

	upperBoppers = new FlxSprite();
	upperBoppers.frames = Paths.getSparrowAtlas('christmas/erect/upperBop');
	upperBoppers.animation.addByPrefix('idle', 'upperBop', 24, false);
	upperBoppers.animation.play('idle');
	upperBoppers.scale.set(0.85, 0.85);
	upperBoppers.updateHitbox();
	upperBoppers.setPosition(-374, -98);
	upperBoppers.scrollFactor.set(0.28, 0.28);
	upperBoppers.antialiasing = true;
	add(upperBoppers);

	var bgEscalator = new FlxSprite();
	bgEscalator.loadGraphic(Paths.image('christmas/erect/bgEscalator'));
	bgEscalator.scale.set(0.9, 0.9);
	bgEscalator.updateHitbox();
	bgEscalator.setPosition(-1100, -540);
	bgEscalator.scrollFactor.set(0.3, 0.3);
	bgEscalator.antialiasing = true;
	add(bgEscalator);

	var christmasTree = new FlxSprite(370, -250);
	christmasTree.loadGraphic(Paths.image('christmas/erect/christmasTree'));
	christmasTree.scrollFactor.set(0.4, 0.4);
	christmasTree.antialiasing = true;
	add(christmasTree);

	var fog = new FlxSprite();
	fog.loadGraphic(Paths.image('christmas/erect/white'));
	fog.scale.set(0.9, 0.9);
	fog.updateHitbox();
	fog.setPosition(-1000, 100);
	fog.scrollFactor.set(0.85, 0.85);
	fog.antialiasing = true;
	add(fog);

	var colorShaderBoppers = new AdjustColorShader();
	colorShaderBoppers.hue.value = [15];
	colorShaderBoppers.brightness.value = [20];

	bottomBoppers = new FlxSprite(-410, 100);
	bottomBoppers.frames = Paths.getSparrowAtlas('christmas/erect/bottomBop');
	bottomBoppers.animation.addByPrefix('idle', 'bottomBop', 24, false);
	bottomBoppers.animation.play('idle');
	bottomBoppers.scrollFactor.set(0.9, 0.9);
	bottomBoppers.antialiasing = true;
	bottomBoppers.shader = colorShaderBoppers;
	add(bottomBoppers);

	var snowUnder = new FlxSprite(-1500, 800);
	snowUnder.makeGraphic(5700, 3000, 0xFFF3F4F5);
	snowUnder.scrollFactor.set(1, 1);
	snowUnder.active = false;
	add(snowUnder);

	var fgSnow = new FlxSprite();
	fgSnow.loadGraphic(Paths.image('christmas/fgSnow'));
	fgSnow.scale.set(1.1, 1);
	fgSnow.updateHitbox();
	fgSnow.setPosition(-1350, 680);
	fgSnow.scrollFactor.set(1, 1);
	fgSnow.antialiasing = true;
	add(fgSnow);

	add(gf);
	add(dad);

	santa = new FlxSprite();
	santa.frames = Paths.getSparrowAtlas('christmas/santa');
	santa.animation.addByPrefix('idle', 'santa idle in fear', 24, false);
	santa.animation.play('idle');
	santa.setPosition(-840, 150);
	santa.scrollFactor.set(1, 1);
	santa.antialiasing = true;
	add(santa);

	add(boyfriend);

	colorShader = new AdjustColorShader();
	colorShader.hue.value = [5];
	colorShader.saturation.value = [20];
	santa.shader = colorShader;
}

function positionCharacters(dad, gf, boyfriend, gfName)
{
	boyfriend.setPosition(970, 450);
	dad.setPosition(-300, 120);
}

function finishSetup(gf, dad, boyfriend)
{
	gf.shader = colorShader;
	dad.shader = colorShader;
	boyfriend.shader = colorShader;
}

function beatHit(curBeat)
{
	upperBoppers.animation.play('idle', true);
	santa.animation.play('idle', true);

	if (bottomBoppers != null)
		bottomBoppers.animation.play('idle', true);
}
