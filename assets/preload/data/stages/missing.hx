var gradient = null;
var black = null;
var bgShader = null;
var bgShaderTween = null;
var video = null;

function create()
{
	stage.defaultCamZoom = 1.2;

	var bg = new FlxSprite().makeGraphic(4400, 4400, FlxColor.WHITE);
	bg.screenCenter();
	bg.cameras = [camGame];
	bg.scrollFactor.set();
	add(bg);

	gradient = new FlxSprite(0, -200);
	gradient.loadGraphic(FlxGradient.createGradientBitmapData(2, 800, [0xff808080, 0x00808080], 1, 90));
	gradient.screenCenter(FlxAxes.X);
	gradient.scale.set(2000, 1);
	gradient.cameras = [camGame];
	gradient.scrollFactor.set();
	add(gradient);

	black = new FlxSprite().makeGraphic(2400, 2400, FlxColor.BLACK);
	black.screenCenter();
	black.cameras = [camHUD];
	black.scrollFactor.set();
	add(black);

	bgShader = new MissMeShader();
	bgShader.u_scale.value = [2.0, 2.0];
	bgShader.u_time.value = [0.0];
	bgShader.u_mix.value = [0.0];
	bg.shader = bgShader;
}

function positionCharacters(dad, gf, boyfriend, gfName)
{
	boyfriend.y += 150;
	boyfriend.x += 350;

	gf.alpha = 0;
}

function onSongStart(song)
{
	if (!VIDEOS_ALLOWED)
		return;

	video = new VideoSprite();
	video.cameras = [camHUD];
	video.canvasWidth = FlxG.width;
	video.canvasHeight = FlxG.height;
	add(video);
	video.finishCallback = function()
	{
		remove(video);
		video.destroy();
		video = null;
	};

	video.playVideo("assets/music/intro.mp4");

	trace(Type.getInstanceFields(Type.getClass(video)));
	trace(Type.getInstanceFields(Type.getClass(video.bitmap)));
}

function getShaderTime()
{
	var beatDec = songPosition / crochet;
	var beatMod = beatDec % 16.0;
	return 100.0 * (Math.floor(beatMod / 8.0) + Math.floor(beatMod / 11.0) + 3.0 * Math.floor(beatDec / 16.0)) + 0.5 * songPosition / 1000.0;
}

function postUpdate(elapsed)
{
	if (bgShader == null)
		return;

	bgShader.u_offset.value = [0.5 * camGame.scroll.x / 2400.0, 0.5 * camGame.scroll.y / 2400.0];
	bgShader.u_time.value = [getShaderTime()];
}

function tweenMix(from, to)
{
	if (bgShaderTween != null)
	{
		bgShaderTween.cancel();
		bgShaderTween.destroy();
		bgShaderTween = null;
	}

	bgShaderTween = FlxTween.num(from, to, 5, {
		ease: FlxEase.quadInOut,
		onComplete: function(t)
		{
			bgShader.u_mix.value = [to];
			bgShaderTween = null;
		}
	}, function(v)
	{
		bgShader.u_mix.value = [v];
	});
}

function stepHit(curStep)
{
	switch (curStep)
	{
		case 2:
			if (black != null)
			{
				remove(black);
				black.destroy();
				black = null;
			}
		case 112:
			FlxTween.tween(gradient, {alpha: 0.0001}, 1.25, {ease: FlxEase.cubeIn});
		case 248:
			gradient.alpha = 0.1;
		case 250:
			gradient.alpha = 0.2;
		case 252:
			gradient.alpha = 0.3;
		case 254:
			gradient.alpha = 0.4;
		case 256:
			FlxTween.tween(gradient, {alpha: 0.0001}, 0.2, {ease: FlxEase.cubeOut});
		case 512:
			tweenMix(0, 0.1);
		case 640:
			tweenMix(0.1, 0.25);
		case 768:
			tweenMix(0.25, 0.5);
		case 1024:
			tweenMix(0.5, 0);
	}
}

function onFocusLost()
{
	if (video == null)
		return;

	video.bitmap.pause();
}

function onFocus()
{
	if (video == null)
		return;

	video.bitmap.resume();
}

function onOpenSubState()
{
	if (video == null)
		return;

	video.bitmap.pause();
}

function onCloseSubState()
{
	if (video == null)
		return;

	video.bitmap.resume();
}
