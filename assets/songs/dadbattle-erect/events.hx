function stepHit(curStep)
{
	switch (curStep)
	{
		case 0:
			// Camera Movement | time: 0 | params: [0]

		case 32:
			// Camera Movement | time: 2526.315789 | params: [1]

		case 64:
			// Camera Movement | time: 5052.631579 | params: [0]

		case 96:
			// Camera Movement | time: 7578.947368 | params: [1]

		case 128:
			// Camera Movement | time: 10105.263158 | params: [0]

		case 192:
			// Camera Movement | time: 15157.894737 | params: [1]

		case 255:
			// Camera Modulo Change | time: 20131.578947 | params: [2,1.1]

		case 256:
			// Camera Movement | time: 20210.526316 | params: [0]

		case 304:
			// Camera Movement | time: 24000 | params: [1]

		case 319:
			// Camera Modulo Change | time: 25184.210526 | params: [2,1.2]

		case 383:
			// Camera Modulo Change | time: 30236.842105 | params: [1,1.3]

		case 384:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1.1;
				}
			});

		case 447:
			// Camera Modulo Change | time: 35289.473684 | params: [1,1.4]

		case 448:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.2}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1.2;
				}
			});

		case 479:
			// Camera Modulo Change | time: 37815.789474 | params: [1,1.5]

		case 480:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.3}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1.3;
				}
			});

		case 496:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.35}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1.35;
				}
			});

		case 511:
			// Camera Modulo Change | time: 40342.105263 | params: [1,1.2]

		case 512:
			// Camera Movement | time: 40421.052632 | params: [0]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1;
				}
			});

		case 524:
			// Camera Position | time: 41368 | params: [-100,30,true,32,"expo",null,true]
			// Camera Movement | time: 41368 | params: [2,true,32,"expo",null]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.95}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 0.95;
				}
			});

		case 576:
			// Camera Position | time: 45473 | params: [-20,30,true,32,"expo",null,true]
			// Camera Movement | time: 45473 | params: [2,true,32,"expo",null]

		case 624:
			// Camera Movement | time: 49263.157895 | params: [1]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1;
				}
			});

		case 703:
			// Camera Modulo Change | time: 55500 | params: [1,1.3]

		case 704:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1.1;
				}
			});

		case 738:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.2}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1.2;
				}
			});

		case 752:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.3}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1.3;
				}
			});

		case 764:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 8, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1.1;
				}
			});

		case 767:
			// Camera Modulo Change | time: 60552.631579 | params: [1,1.2]

		case 768:
			// Camera Position | time: 60631 | params: [-100,30,true,32,"expo",null,true]
			// Camera Movement | time: 60631 | params: [2,true,32,"expo",null]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 0.9;
				}
			});

		case 800:
			// Camera Position | time: 63157 | params: [-20,30,true,32,"expo",null,true]
			// Camera Movement | time: 63157 | params: [2,true,32,"expo",null]

		case 832:
			// Camera Position | time: 65684 | params: [-100,30,true,32,"expo",null,true]
			// Camera Movement | time: 65684 | params: [2,true,32,"expo",null]

		case 864:
			// Camera Position | time: 68210 | params: [-20,30,true,32,"expo",null,true]
			// Camera Movement | time: 68210 | params: [2,true,32,"expo",null]

		case 896:
			// Camera Position | time: 70736 | params: [-100,30,true,32,"expo",null,true]
			// Camera Movement | time: 70736 | params: [2,true,32,"expo",null]

		case 959:
			// Camera Modulo Change | time: 75710.526316 | params: [1,1.3]

		case 960:
			// Camera Movement | time: 75789.157895 | params: [1]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1;
				}
			});

		case 992:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1.1;
				}
			});

		case 1008:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.2}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1.2;
				}
			});

		case 1016:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 0.9;
				}
			});

		case 1023:
			// Camera Modulo Change | time: 80763.157895 | params: [1,1.2]

		case 1024:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1;
				}
			});

		case 1088:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 0.9;
				}
			});

		case 1152:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1;
				}
			});

		case 1216:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1.1;
				}
			});

		case 1248:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.2}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1.2;
				}
			});

		case 1260:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1.1;
				}
			});

		case 1264:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.3}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1.3;
				}
			});

		case 1276:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.2}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1.2;
				}
			});

		case 1280:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1;
				}
			});

		case 1312:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1.1;
				}
			});

		case 1316:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1;
				}
			});

		case 1344:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1.1;
				}
			});

		case 1348:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1;
				}
			});

		case 1408:
			// Camera Position | time: 111157 | params: [-100,30,true,32,"expo","Out",true]
			// Camera Movement | time: 111157 | params: [2,true,32,"expo","Out"]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 0.9;
				}
			});

		case 1472:
			// Camera Movement | time: 116210.526316 | params: [1]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.95}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 0.95;
				}
			});

		case 1504:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1;
				}
			});

		case 1516:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 0.9;
				}
			});

		case 1520:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1.1;
				}
			});

		case 1532:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1;
				}
			});

		case 1535:
			// Camera Modulo Change | time: 121184.361446 | params: [4,1]

		case 1536:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1;
				}
			});
		// Camera Movement | time: 121263.157895 | params: [0]

		case 1568:
			// Camera Movement | time: 123789.634146 | params: [1]

		case 1600:
			// Camera Movement | time: 126315.634146 | params: [0]

		case 1632:
			// Camera Movement | time: 128842.634146 | params: [1]
	}
}
