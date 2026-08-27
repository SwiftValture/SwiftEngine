function stepHit(curStep)
{
	switch (curStep)
	{
		case 0:
			// Camera Movement | time: 0.909091 | params: [0]

		case 1:
			// Camera Modulo Change | time: 42.709677 | params: [2,0.7]

		case 64:
			// Camera Movement | time: 5454.909091 | params: [1]

		case 80:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});

		case 96:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 124:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});

		case 127:
			// Camera Modulo Change | time: 10823.709677 | params: [2,0.8]

		case 128:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});
		// Camera Movement | time: 10909.772727 | params: [0]

		case 160:
			// Camera Movement | time: 13636.363636 | params: [1]

		case 192:
			// Camera Movement | time: 16363.090909 | params: [0]

		case 224:
			// Camera Movement | time: 19090.909091 | params: [1]

		case 244:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});

		case 248:
			// Play Animation | time: 21136.363636 | params: [2,"cheer",true]

		case 255:
			// Camera Modulo Change | time: 21732.709677 | params: [2,1.1]

		case 256:
			// Camera Movement | time: 21818.090909 | params: [0]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 288:
			// Camera Movement | time: 24545.454545 | params: [1]

		case 300:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});

		case 320:
			// Camera Movement | time: 27272.090909 | params: [0]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 352:
			// Camera Movement | time: 30000 | params: [1]

		case 364:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});

		case 376:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 383:
			// Camera Modulo Change | time: 32642.709677 | params: [2,1.3]

		case 384:
			// Camera Position | time: 32727.272727 | params: [-30,100,null,null,null,null,true]
			// Camera Movement | time: 32727.272727 | params: [2]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.93}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.93);
				}
			});

		case 416:
			// Camera Movement | time: 35454.272727 | params: [1]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 440:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});

		case 448:
			// Camera Position | time: 38181.272727 | params: [-30,100,null,null,null,null,true]
			// Camera Movement | time: 38181.272727 | params: [2]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.93}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.93);
				}
			});

		case 479:
			// Camera Modulo Change | time: 40823.709677 | params: [2,0.5]

		case 480:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});
		// Camera Movement | time: 40909.272727 | params: [1]

		case 504:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});

		case 511:
			// Camera Modulo Change | time: 43551.709677 | params: [2,1]

		case 512:
			// Camera Movement | time: 43636.090909 | params: [0]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 576:
			// Camera Movement | time: 49090.909091 | params: [1]

		case 624:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});

		case 639:
			// Camera Modulo Change | time: 54460.709677 | params: [4,0.5]

		case 640:
			// Camera Movement | time: 54545.090909 | params: [0]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 704:
			// Camera Movement | time: 59999.909091 | params: [1]

		case 736:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});

		case 759:
			// Camera Modulo Change | time: 64687.709677 | params: [1,1.2]

		case 762:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 767:
			// Camera Modulo Change | time: 65369.709677 | params: [2,0.8]

		case 768:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});
		// Camera Movement | time: 65454.909091 | params: [0]

		case 800:
			// Camera Movement | time: 68181.909091 | params: [1]

		case 816:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});

		case 824:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 832:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});
		// Camera Movement | time: 70909.909091 | params: [0]

		case 864:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});
		// Camera Movement | time: 73636.909091 | params: [1]

		case 880:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 895:
			// Camera Modulo Change | time: 76278.709677 | params: [4,1]

		case 896:
			// Camera Movement | time: 76363.090909 | params: [0]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 959:
			// Camera Modulo Change | time: 81732.709677 | params: [2,1]

		case 960:
			// Camera Movement | time: 81817.909091 | params: [1]

		case 976:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});

		case 992:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 1008:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});

		case 1015:
			// Camera Modulo Change | time: 86505.709677 | params: [1,1.2]

		case 1018:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 1023:
			// Camera Modulo Change | time: 87187.709677 | params: [4,1.5]

		case 1024:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});
		// Camera Movement | time: 87272.909091 | params: [0]

		case 1031:
			// Camera Modulo Change | time: 87869.709677 | params: [4,0.5]

		case 1051:
			// Camera Modulo Change | time: 89573.709677 | params: [4,1.5]

		case 1056:
			// Camera Movement | time: 89999.818182 | params: [1]

		case 1063:
			// Camera Modulo Change | time: 90596.709677 | params: [4,0.5]

		case 1079:
			// Camera Modulo Change | time: 91960.709677 | params: [1,1.2]

		case 1087:
			// Camera Modulo Change | time: 92642.709677 | params: [4,1.5]

		case 1088:
			// Camera Movement | time: 92727.090909 | params: [0]

		case 1099:
			// Camera Modulo Change | time: 93664.709677 | params: [4,1]

		case 1120:
			// Camera Movement | time: 95454.363636 | params: [1]

		case 1135:
			// Camera Modulo Change | time: 96732.709677 | params: [2,0]

		case 1136:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});

		case 1146:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 1152:
			// Camera Position | time: 98181.272727 | params: [-30,100,null,null,null,null,true]
			// Camera Movement | time: 98181.272727 | params: [2]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.93}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.93);
				}
			});

		case 1200:
			// Camera Movement | time: 102272.272727 | params: [1]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 1252:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});

		case 1272:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 1279:
			// Camera Modulo Change | time: 109005.709677 | params: [2,1.5]

		case 1280:
			// Camera Position | time: 109090.272727 | params: [-30,100,null,null,null,null,true]
			// Camera Movement | time: 109090.272727 | params: [2]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.93}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.93);
				}
			});

		case 1295:
			// Camera Modulo Change | time: 110369.709677 | params: [2,0]

		case 1304:
			// Camera Movement | time: 111136.272727 | params: [1]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 1311:
			// Camera Modulo Change | time: 111732.709677 | params: [2,1.5]

		case 1312:
			// Camera Position | time: 111817.272727 | params: [-30,100,null,null,null,null,true]
			// Camera Movement | time: 111817.272727 | params: [2]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.93}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.93);
				}
			});

		case 1328:
			// Camera Modulo Change | time: 113181.709677 | params: [2,0]

		case 1336:
			// Camera Movement | time: 113863.272727 | params: [1]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 1343:
			// Camera Modulo Change | time: 114460.709677 | params: [2,1.5]

		case 1344:
			// Camera Position | time: 114545.272727 | params: [-30,100,null,null,null,null,true]
			// Camera Movement | time: 114545.272727 | params: [2]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.93}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.93);
				}
			});

		case 1376:
			// Camera Movement | time: 117272.272727 | params: [1]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 1390:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});

		case 1391:
			// Camera Modulo Change | time: 118550.709677 | params: [2,0]

		case 1400:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 1407:
			// Camera Modulo Change | time: 119914.709677 | params: [2,1.6]

		case 1408:
			// Camera Position | time: 119999.272727 | params: [-30,100,null,null,null,null,true]
			// Camera Movement | time: 119999.272727 | params: [2]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.93}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.93);
				}
			});

		case 1440:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});
		// Camera Movement | time: 122727.272727 | params: [1]

		case 1472:
			// Camera Position | time: 125454.272727 | params: [-30,100,null,null,null,null,true]
			// Camera Movement | time: 125454.272727 | params: [2]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.93}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.93);
				}
			});

		case 1503:
			// Camera Modulo Change | time: 128096.709677 | params: [2,0.7]

		case 1504:
			// Camera Movement | time: 128181.272727 | params: [1]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 1520:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.98}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.98);
				}
			});

		case 1524:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.96}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.96);
				}
			});

		case 1528:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.94}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.94);
				}
			});

		case 1532:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.92}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.92);
				}
			});

		case 1535:
			// Camera Modulo Change | time: 130823.709677 | params: [4,1]
	}
}
