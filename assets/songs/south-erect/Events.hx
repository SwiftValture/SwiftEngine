function stepHit(curStep)
{
	switch (curStep)
	{
		case 0:
			// Camera Movement | time: 0.634146 | params: [0]

		case 32:
			// Camera Movement | time: 2711.634146 | params: [1]

		case 64:
			// Camera Movement | time: 5423.634146 | params: [0]

		case 96:
			// Camera Movement | time: 8135.634146 | params: [1]

		case 127:
			// Camera Modulo Change | time: 10762.361446 | params: [2,1]

			camZoomInterval(2, 0.015, 0.03);

		case 128:
			// Camera Movement | time: 10847.634146 | params: [0]

		case 192:
			// Camera Movement | time: 16271.634146 | params: [1]

		case 240:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 248:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.2}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.2);
				}
			});

		case 256:
			// Camera Movement | time: 21694.634146 | params: [0]

			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 320:
			// Camera Movement | time: 27118.634146 | params: [1]

		case 368:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 376:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.2}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.2);
				}
			});

		case 384:
			// Camera Movement | time: 32542.372881 | params: [0]

			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 388:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 448:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});
		// Camera Movement | time: 37966.634146 | params: [1]

		case 464:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 480:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 496:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 510:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.9);
				}
			});

		case 511:
			// Camera Modulo Change | time: 43305.361446 | params: [4,1]

			camZoomInterval(4, 0.015, 0.03);

		case 520:
			// Camera Movement | time: 44067 | params: [2]

		case 576:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});
		// Camera Movement | time: 48813.634146 | params: [1]

		case 585:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});

		case 600:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 624:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 639:
			// Camera Modulo Change | time: 54152.361446 | params: [2,1]

			camZoomInterval(2, 0.015, 0.03);

		case 640:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.9);
				}
			});

		case 648:
			// Camera Movement | time: 54915 | params: [2]

		case 704:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});
		// Camera Movement | time: 59661.634146 | params: [1]

		case 720:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 736:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 752:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 768:
			// Camera Movement | time: 65084.634146 | params: [0]

			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 832:
			// Camera Movement | time: 70508.634146 | params: [1]

		case 880:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 888:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.2}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.2);
				}
			});

		case 896:
			// Camera Movement | time: 75931.634146 | params: [0]

			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 960:
			// Camera Movement | time: 81355.634146 | params: [1]

			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 976:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 992:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 1008:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 1022:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.9);
				}
			});

		case 1023:
			// Camera Modulo Change | time: 86695.361446 | params: [4,1]

			camZoomInterval(4, 0.015, 0.03);

		case 1032:
			// Camera Movement | time: 87457 | params: [2]

		case 1088:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});
		// Camera Movement | time: 92203.634146 | params: [1]

		case 1097:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});

		case 1112:
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

		case 1151:
			// Camera Modulo Change | time: 97542.361446 | params: [2,1]

			camZoomInterval(2, 0.015, 0.03);

		case 1152:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.9);
				}
			});

		case 1160:
			// Camera Movement | time: 98305 | params: [2]

		case 1216:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});
		// Camera Movement | time: 103051.634146 | params: [1]

		case 1232:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 1248:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 1264:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 1280:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});
		// Camera Movement | time: 108474.634146 | params: [1]

		case 1296:
			// Camera Movement | time: 109830.508475 | params: [2]

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
