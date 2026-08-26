function stepHit(curStep)
{
	switch (curStep)
	{
		case 0:
			// Camera Movement | time: 0 | params: [0]

		case 16:
			// Camera Movement | time: 1920.634146 | params: [1]

		case 32:
			// Camera Movement | time: 3840.634146 | params: [0]

		case 48:
			// Camera Movement | time: 5760 | params: [1]

		case 66:
			// Camera Movement | time: 7920 | params: [0]

		case 82:
			// Camera Movement | time: 9840 | params: [1]

		case 98:
			// Camera Movement | time: 11760 | params: [0]

		case 114:
			// Camera Movement | time: 13680 | params: [1]

		case 128:
			// Camera Movement | time: 15360 | params: [0]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 0.9;
				}
			});

		case 146:
			// Camera Movement | time: 17520 | params: [1]

		case 160:
			// Camera Movement | time: 19200 | params: [0]

		case 176:
			// Camera Movement | time: 21120 | params: [1]

		case 177:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1;
				}
			});

		case 192:
			// Camera Position | time: 23040 | params: [-100,0,true,32,"expo",null,true]
			// Camera Movement | time: 23040 | params: [2,true,32,"expo",null]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 0.9;
				}
			});

		case 224:
			// Camera Movement | time: 26880 | params: [1,true,16,"expo",null]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1;
				}
			});

		case 250:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 0.9;
				}
			});

		case 256:
			// Camera Position | time: 30720 | params: [-100,0,true,32,"expo",null,true]
			// Camera Movement | time: 30720 | params: [2,true,32,"expo",null]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 0.9;
				}
			});

		case 288:
			// Camera Movement | time: 34560 | params: [1,true,16,"expo",null]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 0.9;
				}
			});

		case 296:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.95}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 0.95;
				}
			});

		case 304:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 0.9;
				}
			});

		case 312:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 0.9;
				}
			});

		case 320:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 0.9;
				}
			});

		case 322:
			// Camera Movement | time: 38640 | params: [0]

		case 338:
			// Camera Movement | time: 40560 | params: [1]

		case 354:
			// Camera Movement | time: 42480 | params: [0]

		case 368:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.85}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 0.85;
				}
			});
		// Camera Movement | time: 44160.634146 | params: [1]

		case 372:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 0.9;
				}
			});

		case 376:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.85}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 0.85;
				}
			});

		case 384:
			// Camera Movement | time: 46080 | params: [0]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 0.9;
				}
			});

		case 416:
			// Camera Movement | time: 49920 | params: [1]

		case 424:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.3}, Conductor.stepCrochet / 1000 * 21, {
				ease: FlxEase.quadOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1.3;
				}
			});

		case 446:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 4, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1.1;
				}
			});

		case 450:
			// Camera Position | time: 54000 | params: [-100,0,true,32,"expo",null,true]
			// Camera Movement | time: 54000 | params: [2,true,32,"expo",null]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 0.9;
				}
			});

		case 464:
			// Camera Movement | time: 55680 | params: [1,true,32,"expo",null]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1;
				}
			});

		case 482:
			// Camera Position | time: 57840 | params: [-100,0,true,32,"expo",null,true]
			// Camera Movement | time: 57840 | params: [2,true,32,"expo",null]

		case 496:
			// Camera Movement | time: 59520 | params: [1,true,32,"expo",null]

		case 512:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.linear,
				onComplete: function(tween)
				{
					defaultCamZoom = 0.9;
				}
			});

		case 544:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.95}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 0.95;
				}
			});

		case 552:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1;
				}
			});

		case 560:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.95}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 0.95;
				}
			});

		case 568:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 0.9;
				}
			});

		case 576:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1;
				}
			});

		case 608:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1.1;
				}
			});
	}
}
