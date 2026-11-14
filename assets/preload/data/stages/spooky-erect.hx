var lightningStrike = true;
var lightningStrikeBeat = 0;
var lightningOffset = 8;
var thunderSFXamount = 2;
var trees;
var bgLight;
var stairsLight;
var boy;
var rainShader = null;
var time = 0.0;

function create()
{
	stage.defaultCamZoom = 1;

	for (i in 1...thunderSFXamount + 1)
		FlxG.sound.cache(Paths.sound('thunder_' + i));

	trees = new FlxSprite(200, 50);
	trees.frames = Paths.getSparrowAtlas('stages/spooky/erect/bgtrees');
	trees.animation.addByPrefix('idle', 'bgtrees', 5, true);
	trees.animation.play('idle');
	trees.antialiasing = true;
	trees.scrollFactor.set(0.8, 0.8);
	trees.scale.set(1.05, 1.05);
	add(trees);

	var bgDark = new FlxSprite(-560, -220);
	bgDark.loadGraphic(Paths.image('stages/spooky/erect/bgDark'));
	bgDark.antialiasing = true;
	add(bgDark);

	bgLight = new FlxSprite(-560, -220);
	bgLight.loadGraphic(Paths.image('stages/spooky/erect/bgLight'));
	bgLight.alpha = 0;
	bgLight.antialiasing = true;
	add(bgLight);

	var stairsDark = new FlxSprite(966, -225);
	stairsDark.loadGraphic(Paths.image('stages/spooky/erect/stairsDark'));
	stairsDark.antialiasing = true;
	add(stairsDark);

	stairsLight = new FlxSprite(966, -225);
	stairsLight.loadGraphic(Paths.image('stages/spooky/erect/stairsLight'));
	stairsLight.alpha = 0;
	stairsLight.antialiasing = true;
	add(stairsLight);

	add(gf);
	add(boyfriend);
	add(dad);

	boy = new Boyfriend(795, 450, 'bf');
	boy.alpha = 0.001;
	insertAfter(boyfriend, boy);

	// boy.playAnim('idle', true);

	rainShader = new RainShader();
	rainShader.data.uCameraBounds.value = [0, 0, FlxG.width, FlxG.height];
	rainShader.data.uScale.value = [FlxG.height / 200];
	rainShader.data.uIntensity.value = [0.4];
	rainShader.data.uTime.value = [0];
	rainShader.data.uRainColor.value = getColorVec(0xFF6680CC);
	trees.shader = rainShader;
}

var dirs = ['LEFT', 'DOWN', 'UP', 'RIGHT'];

function onNoteHit(note, isPlayer)
{
	if (!isPlayer)
		return;
	var name = 'sing' + dirs[note.noteData % 4];
	if (boy.animation.exists(name))
	{
		boy.playAnim(name, true);
		boy.holdTimer = 0;
	}
}

function getColorVec(color)
{
	return [(color >> 16 & 0xFF) / 255, (color >> 8 & 0xFF) / 255, (color & 0xFF) / 255];
}

function update(elapsed, inCutscene)
{
	time += elapsed;
	if (rainShader != null)
		rainShader.data.uTime.value = [time];
}

function scare(c)
{
	if (c != null && c.animation.exists('scared'))
	{
		c.animation.paused = false;
		c.playAnim('scared', true);
	}
}

function lightningStrikeShit(beat)
{
	FlxG.sound.play(Paths.soundRandom('thunder_', 1, thunderSFXamount));

	for (bg in [bgLight, stairsLight])
	{
		bg.alpha = 1;
		boy.alpha = 1;

		new FlxTimer().start(0.06, function(_)
		{
			bg.alpha = 0;
			boy.alpha = 0;
		});

		new FlxTimer().start(0.12, function(_)
		{
			bg.alpha = 1;
			boy.alpha = 1;
			FlxTween.tween(bg, {alpha: 0}, 1.5);
			FlxTween.tween(boy, {alpha: 0}, 1.5);
		});
	}

	for (c in [gf, dad, boyfriend, boy])
		scare(c);

	lightningStrikeBeat = beat;
	lightningOffset = FlxG.random.int(8, 24);
}

function beatHit(curBeat)
{
	if (curBeat % 2 == 0 && !boy.isSinging())
		boy.dance();

	if (lightningStrike && FlxG.random.bool(10) && curBeat > lightningStrikeBeat + lightningOffset)
		lightningStrikeShit(curBeat);
}
