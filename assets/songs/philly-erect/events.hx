function stepHit(curStep)
{
	switch (curStep)
	{
		case 0:
			// Camera Movement | time: 0 | params: [0]

		case 64:
			// Camera Movement | time: 5485.714286 | params: [1]

		case 112:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});

		case 128:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});
		// Camera Movement | time: 10971.428571 | params: [0]

		case 192:
			// Camera Movement | time: 16457.142857 | params: [1]

		case 210:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.95}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.95);
				}
			});

		case 224:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 256:
			// Camera Movement | time: 21942.857143 | params: [0]

		case 320:
			// Camera Movement | time: 27428.571429 | params: [1]

		case 338:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.95}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.95);
				}
			});

		case 352:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 368:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.95}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.95);
				}
			});

		case 384:
			// Camera Movement | time: 32914 | params: [2]

			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.9);
				}
			});

		case 448:
			// Camera Movement | time: 38400 | params: [1]

			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 464:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 480:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 496:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 512:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});
		// Camera Movement | time: 43885.714286 | params: [0]

		case 576:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});
		// Camera Movement | time: 49371.428571 | params: [1]

		case 592:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 608:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 624:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 640:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});
		// Camera Movement | time: 54857.142857 | params: [0]

		case 704:
			// Camera Movement | time: 60342.857143 | params: [1]

		case 768:
			// Camera Movement | time: 65828 | params: [2]

			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.9);
				}
			});

		case 800:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.95}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.95);
				}
			});

		case 832:
			// Camera Movement | time: 71314.285714 | params: [1]

			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 880:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 896:
			// Camera Movement | time: 76800 | params: [0]

			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 960:
			// Camera Movement | time: 82285.714286 | params: [1]

		case 978:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.95}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.95);
				}
			});

		case 992:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 1008:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.95}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.95);
				}
			});

		case 1024:
			// Camera Movement | time: 87771 | params: [2]

			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.9);
				}
			});

		case 1088:
			// Camera Movement | time: 93257 | params: [1]

			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 1104:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 1116:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 1136:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 1148:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 1152:
			// Camera Movement | time: 98742.857143 | params: [1]

		case 1184:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 12, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});

		case 1216:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 12, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 1248:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.15}, Conductor.stepCrochet / 1000 * 12, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.15);
				}
			});

		case 1278:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 8, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});
	}
}
