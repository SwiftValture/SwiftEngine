function stepHit(curStep)
{
	switch (curStep)
	{
		case 0:
			// Camera Movement | time: 0 | params: [0]

		case 64:
			// Camera Movement | time: 5925.925926 | params: [1]

		case 120:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
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
		// Camera Movement | time: 11851.851852 | params: [0]

		case 192:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});
		// Camera Movement | time: 17777.777778 | params: [1]

		case 208:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
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
			// Camera Movement | time: 23703.703704 | params: [0]

			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.9);
				}
			});

		case 274:
			// Camera Movement | time: 25370 | params: [2]

		case 288:
			// Camera Movement | time: 26666.634146 | params: [0]

			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 320:
			// Camera Movement | time: 29629.62963 | params: [1]

		case 352:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});

		case 360:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 368:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.15}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.15);
				}
			});

		case 376:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});

		case 384:
			// Camera Movement | time: 35555 | params: [2]

			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.9);
				}
			});

		case 448:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});
		// Camera Movement | time: 41481.481481 | params: [1]

		case 480:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});

		case 488:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 496:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.15}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.15);
				}
			});

		case 512:
			// Camera Movement | time: 47407 | params: [2]

			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.9);
				}
			});

		case 576:
			// Camera Movement | time: 53333.777778 | params: [1]

		case 608:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 630:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 640:
			// Camera Movement | time: 59259 | params: [2]

			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.9);
				}
			});

		case 656:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 672:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.9);
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
		// Camera Movement | time: 65185.777778 | params: [1]

		case 736:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 768:
			// Camera Movement | time: 71111 | params: [2]

			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.9);
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

		case 800:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.9);
				}
			});

		case 832:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});
		// Camera Movement | time: 77037.777778 | params: [1]

		case 864:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 882:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 898:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.9);
				}
			});
		// Camera Movement | time: 83148.703704 | params: [0]

		case 914:
			// Camera Movement | time: 84629 | params: [2]

		case 928:
			// Camera Movement | time: 85925.634146 | params: [0]

			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 960:
			// Camera Movement | time: 88888.62963 | params: [1]

		case 992:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});

		case 1000:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 1008:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.15}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.15);
				}
			});

		case 1016:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});

		case 1024:
			// Camera Movement | time: 94814 | params: [0]

			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.9);
				}
			});

		case 1088:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});
		// Camera Movement | time: 100740.777778 | params: [1]

		case 1120:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});

		case 1128:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 1136:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.15}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.15);
				}
			});

		case 1152:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.9);
				}
			});
	}
}
