function stepHit(curStep)
{
	switch (curStep)
	{
		case 0:
			// Camera Movement | time: 0 | params: [1]

		case 32:
			// Camera Movement | time: 3840 | params: [0]

		case 96:
			// Camera Movement | time: 11520 | params: [1]

		case 160:
			// Camera Movement | time: 19200 | params: [0]

		case 224:
			// Camera Movement | time: 26880 | params: [1]

		case 288:
			// Camera Movement | time: 34560 | params: [0]

		case 352:
			// Camera Movement | time: 42240 | params: [2]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.95}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.95);
				}
			});

		case 383:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.smoothStep,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 384:
			// Camera Movement | time: 46080 | params: [1]

		case 408:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 6, {
				ease: FlxEase.quad,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 412:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.2}, Conductor.stepCrochet / 1000 * 6, {
				ease: FlxEase.quad,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.2);
				}
			});

		case 416:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 8, {
				ease: FlxEase.quad,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 422:
			// Camera Movement | time: 50640 | params: [0]

		case 480:
			// Camera Movement | time: 57600 | params: [1]

		case 544:
			// Camera Movement | time: 65280 | params: [0]

		case 608:
			// Camera Movement | time: 72960 | params: [2]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.95}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.95);
				}
			});

		case 639:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.smoothStep,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 640:
			// Camera Movement | time: 76800 | params: [1]

		case 664:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.12}, Conductor.stepCrochet / 1000 * 8, {
				ease: FlxEase.quad,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.12);
				}
			});

		case 672:
			// Camera Movement | time: 80640 | params: [2]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.95}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.95);
				}
			});

		case 704:
			// Camera Movement | time: 84480 | params: [2]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.sineOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 736:
			// Camera Movement | time: 88320 | params: [2]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.95}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.95);
				}
			});

		case 768:
			// Camera Movement | time: 92160 | params: [2]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.sineOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 800:
			// Camera Movement | time: 96000 | params: [2]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.95}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.95);
				}
			});
	}
}
