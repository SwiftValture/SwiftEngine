function stepHit(curStep)
{
	switch (curStep)
	{
		case 0:
			// Camera Movement | time: 0 | params: [0]

		case 16:
			// Camera Movement | time: 1777 | params: [1]

		case 34:
			// Camera Movement | time: 3777 | params: [0]

		case 66:
			// Camera Movement | time: 7333 | params: [1]

		case 98:
			// Camera Movement | time: 10888 | params: [0]

		case 128:
			// Camera Movement | time: 14222 | params: [1]

		case 160:
			// Camera Movement | time: 17777 | params: [0]

		case 192:
			// Camera Movement | time: 21333 | params: [1]

		case 224:
			// Camera Movement | time: 24888 | params: [0]

		case 256:
			// Camera Movement | time: 28444 | params: [1]

		case 290:
			// Camera Movement | time: 32222 | params: [0]

		case 322:
			// Camera Movement | time: 35777 | params: [1]

		case 352:
			// Camera Movement | time: 39111 | params: [2]

			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.95}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.95);
				}
			});

		case 384:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.smoothStepInOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});
		// Camera Movement | time: 42666.666667 | params: [1]

		case 400:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 6, {
				ease: FlxEase.quadOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 408:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.2}, Conductor.stepCrochet / 1000 * 6, {
				ease: FlxEase.quadOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.2);
				}
			});

		case 416:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 8, {
				ease: FlxEase.quadOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 432:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 440:
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

		case 472:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 480:
			// Camera Movement | time: 53333 | params: [2]

			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.95}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.95);
				}
			});

		case 496:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});

		case 504:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.95}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.95);
				}
			});

		case 528:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});

		case 536:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.95}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.95);
				}
			});

		case 544:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 546:
			// Camera Movement | time: 60666 | params: [0]

		case 576:
			// Camera Movement | time: 63999 | params: [1]

		case 592:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 600:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 608:
			// Camera Movement | time: 67555 | params: [2]

			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.95}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.95);
				}
			});

		case 640:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.smoothStepInOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});
		// Camera Movement | time: 71111.111111 | params: [1]

		case 656:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 6, {
				ease: FlxEase.quadOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 664:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.2}, Conductor.stepCrochet / 1000 * 6, {
				ease: FlxEase.quadOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.2);
				}
			});

		case 672:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 8, {
				ease: FlxEase.quadOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 688:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 704:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 720:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});

		case 723:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 728:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 736:
			// Camera Movement | time: 81777 | params: [2]

			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.95}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.95);
				}
			});

		case 752:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});

		case 768:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.95}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.95);
				}
			});

		case 784:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 787:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});

		case 792:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.95}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.95);
				}
			});

		case 816:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});

		case 824:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.95}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.95);
				}
			});

		case 832:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.smoothStepInOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});
		// Camera Movement | time: 92444.444444 | params: [1]

		case 848:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 6, {
				ease: FlxEase.quadOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 852:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.2}, Conductor.stepCrochet / 1000 * 6, {
				ease: FlxEase.quadOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.2);
				}
			});

		case 856:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.3}, Conductor.stepCrochet / 1000 * 6, {
				ease: FlxEase.quadOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.3);
				}
			});

		case 864:
			// Camera Movement | time: 95999 | params: [2]

			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.95}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.95);
				}
			});

		case 880:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});

		case 888:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.95}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.95);
				}
			});

		case 912:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});

		case 920:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.95}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.95);
				}
			});

		case 928:
			// Camera Movement | time: 103111 | params: [0]

			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 944:
			// Camera Movement | time: 104888 | params: [1]

		case 960:
			// Camera Movement | time: 106666 | params: [0]

		case 976:
			// Camera Movement | time: 108444 | params: [1]
	}
}
