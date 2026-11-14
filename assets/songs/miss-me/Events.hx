setSkipCountdown(true, true);
function stepHit(step)
{
	switch (step)
	{
		case 110:
			dad.playSpecialAnim("okay");
			camHUD.alpha = 0;
		case 128:
			dad.specialAnim = false;
			dad.playAnim("idle", true);
			FlxTween.tween(camHUD, {alpha: 1}, 0.5, {ease: FlxEase.cubeIn});

			for (i in [scoreTxt, iconP1, iconP2, healthBar, healthBarBG])
			{
				FlxTween.tween(i, {alpha: 1}, 0.5, {ease: FlxEase.cubeIn});
			}

		case 144:
			FlxTween.globalManager.cancelTweensOf(camHUD, ['alpha']);
			camHUD.alpha = 1.0;
		case 248:
			dad.playAnim("laugh", true);
			FlxTween.tween(camGame, {angle: -1}, Conductor.stepCrochet / 1000 * 5, {ease: FlxEase.quartOut});
			moveCamera(true);
		case 250:
			dad.playAnim("laugh", true);
			FlxTween.tween(camGame, {angle: -2}, Conductor.stepCrochet / 1000 * 5, {ease: FlxEase.quartOut});
		case 252:
			dad.playAnim("laugh", true);
			FlxTween.tween(camGame, {angle: -3}, Conductor.stepCrochet / 1000 * 5, {ease: FlxEase.quartOut});
		case 254:
			dad.playAnim("laugh", true);
			FlxTween.tween(camGame, {angle: -4}, Conductor.stepCrochet / 1000 * 5, {ease: FlxEase.quartOut});
		case 256:
			FlxTween.tween(camGame, {angle: 0}, Conductor.stepCrochet / 1000 * 5, {ease: FlxEase.quartOut});
			moveCamera(true);
		case 292:
			dad.playSpecialAnim("dance1");
		case 314:
			moveCamera(true);
		case 356:
			dad.playSpecialAnim("dance1");
		case 448:
			dad.playAnim("funny2", true);
			dad.specialAnim = true;
		case 451:
			dad.playAnim("funny3", true);
		case 454:
			dad.playAnim("funny2", true);
		case 460:
			dad.specialAnim = false;
		case 528:
			dad.specialAnim = false;
			dad.playAnim("laugh", true);
		case 530:
			dad.playAnim("laugh", true);
		case 832:
			dad.playSpecialAnim("dance3");
			dad.specialAnim = true;
		case 880:
			dad.specialAnim = false;
		case 896:
			dad.idleSuffix = '-alt';
		case 1024:
			dad.idleSuffix = '';
		case 1156:
			dad.playAnim("laugh", true);
		case 1158:
			dad.playAnim("laugh", true);
	}
}

function postCreate()
{
	scoreTxt.alpha = 0;
	healthBarBG.alpha = 0;
	healthBar.alpha = 0;
	iconP1.alpha = 0;
	iconP2.alpha = 0;
}
