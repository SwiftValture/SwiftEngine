function stepHit(curStep)
{
	switch (curStep)
	{
		case 64:
			camAngle = true;
		case 308:
			camHUD.fade(0xFF000000, 1);
		case 313:
			setScrollSpeed(2.0);
		case 320:
			camHUD.fade(0xFF000000, 0.001, true);
			camAngle = false;
		case 322:
			camHUD.fade(0xFF000000, 0.4);
		case 328:
			camHUD.fade(0xFF000000, 0.5, true);
		case 336:
			camHUD.fade(0xFF000000, 1, true);
			iconP2.alpha = 1;
		case 464:
			camHUD.fade(0xFF000000, 0.5);
		case 474:
			setScrollSpeed(2.3);
		case 479:
			camHUD.fade(0xFF000000, 1, true);
		case 606:
			camHUD.fade(0xFF000000, 0.2);
			setScrollSpeed(2.55);
		case 608:
			camHUD.fade(0xFF000000, 0.2, true);
		case 734:
			camHUD.fade(0xFF000000, 0.01);
		case 736:
			camHUD.fade(0xFF000000, 0.5, true);
			setScrollSpeed(1.9);
		case 862:
			camHUD.fade(0xFF000000, 0.2);
		case 865:
			camHUD.fade(0xFF000000, 0.5, true);
			boyfriend.alpha = 0;

		case 894:
			camHUD.fade(0xFF000000, 0.1);

		case 896:
			camHUD.fade(0xFF000000, 0.5, true);
			dad.alpha = 0;
			boyfriend.alpha = 1;
		case 926:
			camHUD.fade(0xFF000000, 0.1);
		case 928:
			camHUD.fade(0xFF000000, 0.5, true);
			dad.alpha = 1;
			boyfriend.alpha = 0;

		case 958:
			camHUD.fade(0xFF000000, 0.1);

		case 960:
			camHUD.fade(0xFF000000, 0.5, true);
			dad.alpha = 0;
			boyfriend.alpha = 1;

		case 990:
			camHUD.fade(0xFF000000, 0.1);

		case 992:
			camHUD.fade(0xFF000000, 0.5, true);
			FlxTween.num(scrollSpeed, 1.8, 3.0, {
				onUpdate: function(value)
				{
					setScrollSpeed(value);
				}
			});
			dad.alpha = 0;
			boyfriend.alpha = 0;
		case 1118:
			camHUD.fade(0xFF000000, 0.01);
		case 1120:
			camHUD.fade(0xFF000000, 0.5, true);
			setScrollSpeed(2.6);
		case 1247:
			camHUD.fade(0xFF000000, 0.01);
		case 1248:
			camHUD.fade(0xFF000000, 0.5, true);
			dad.alpha = 0;
			boyfriend.alpha = 0;
	}
}

function postCreate()
{
	iconP2.alpha = 0;
}

function beatHit(curBeat)
{
	if (swingEnabled)
	{
		startAngle = targetAngle;
		targetAngle = -targetAngle;
		progress = 0;
	}
}

var swingTime = 1;
var swingAmount = 1;
var swingSpeed = 0.8;
var camAngle = false;
var swingEnabled = false;
var progress = 1;
var duration = 1;
var startAngle = 5;
var targetAngle = -5;

function update(elapsed)
{
	if (swingEnabled && duration > 0)
	{
		progress = Math.min(progress + elapsed / duration, 1);
		var eased = Math.pow(progress, 4);
		var angle = startAngle + (targetAngle - startAngle) * eased;
		boyfriend.angle = angle;
		dad.angle = angle;
		forest4.angle = angle;
	}

	if (camAngle)
	{
		swingTime = swingTime + elapsed * swingSpeed;
		angleCam = Math.sin(swingTime) * swingAmount;
		camGame.angle = angleCam;
	}
}
