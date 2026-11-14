function stepHit(curStep)
{
	switch (curStep)
	{
		case 0:
			// Camera Movement | time: 0.634146 | params: [1]

		case 64:
			// Camera Movement | time: 5783.634146 | params: [0]

		case 96:
			// Camera Movement | time: 8674.634146 | params: [1]

		case 128:
			// Camera Movement | time: 11566.634146 | params: [0]

		case 160:
			// Camera Movement | time: 14457.634146 | params: [1]

		case 176:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 191:
			// Camera Modulo Change | time: 17259.361446 | params: [2,1]

		case 192:
			// Camera Position | time: 17349 | params: [-50,50,true,32,"expo","In",true]
			// Camera Movement | time: 17349 | params: [0,true,32,"expo","In"]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.9);
				}
			});

		case 256:
			// Camera Movement | time: 23132 | params: [1,true,32,"expo","Out"]

		case 258:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 272:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.95}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.95);
				}
			});

		case 288:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 320:
			// Camera Position | time: 28915 | params: [-50,50,true,32,"expo",null,true]
			// Camera Movement | time: 28915 | params: [2,true,32,"expo",null]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.9);
				}
			});

		case 368:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 384:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.9);
				}
			});

		case 448:
			// Camera Movement | time: 40481.634146 | params: [1]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 480:
			// Camera Position | time: 43373 | params: [-50,50,true,32,"expo",null,true]
			// Camera Movement | time: 43373 | params: [2,true,32,"expo",null]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.9);
				}
			});

		case 512:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});
		// Camera Movement | time: 46265.634146 | params: [1]

		case 528:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});

		case 544:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 560:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 575:
			// Camera Modulo Change | time: 51957.361446 | params: [1,1.1]

		case 576:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 592:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 608:
			// Camera Position | time: 54939 | params: [-50,50,true,32,"expo",null,true]
			// Camera Movement | time: 54939 | params: [2,true,32,"expo",null]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.9);
				}
			});

		case 640:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});
		// Camera Movement | time: 57831.634146 | params: [1]

		case 656:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 671:
			// Camera Modulo Change | time: 60632.361446 | params: [2,1.1]

		case 672:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.2}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.2);
				}
			});

		case 680:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.3}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.3);
				}
			});

		case 688:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.2}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.2);
				}
			});

		case 696:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 703:
			// Camera Modulo Change | time: 63524.361446 | params: [4,1]

		case 704:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});
		// Camera Movement | time: 63614.634146 | params: [0]

		case 736:
			// Camera Movement | time: 66506.634146 | params: [1]

		case 768:
			// Camera Movement | time: 69397.634146 | params: [0]

		case 800:
			// Camera Movement | time: 72289.634146 | params: [1]

		case 816:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 831:
			// Camera Modulo Change | time: 75090.361446 | params: [2,1]

		case 832:
			// Camera Position | time: 75180 | params: [-50,50,true,32,"expo","Out",true]
			// Camera Movement | time: 75180 | params: [2,true,32,"expo","Out"]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.9);
				}
			});

		case 896:
			// Camera Movement | time: 80963 | params: [1,true,32,"expo",null]

		case 898:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 912:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.95}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.95);
				}
			});

		case 928:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 960:
			// Camera Position | time: 86746 | params: [-50,50,true,32,"expo",null,true]
			// Camera Movement | time: 86746 | params: [2,true,32,"expo",null]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.9);
				}
			});

		case 1008:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 1024:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.9);
				}
			});

		case 1056:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 1072:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});

		case 1080:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 1088:
			// Camera Movement | time: 98312.634146 | params: [1]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 1120:
			// Camera Position | time: 101204 | params: [-50,50,true,32,"expo","Out",true]
			// Camera Movement | time: 101204 | params: [2,true,32,"expo","Out"]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.9);
				}
			});

		case 1136:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 1152:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});
		// Camera Movement | time: 104096.634146 | params: [1]

		case 1168:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});

		case 1184:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 1200:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 1215:
			// Camera Modulo Change | time: 109789.361446 | params: [1,1.1]

		case 1216:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 1232:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 1248:
			// Camera Position | time: 112770 | params: [-50,50,true,32,"expo","Out",true]
			// Camera Movement | time: 112770 | params: [2,true,32,"expo","Out"]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.9);
				}
			});

		case 1280:
			// Camera Movement | time: 115662.634146 | params: [1]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 1296:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 1311:
			// Camera Modulo Change | time: 118463.361446 | params: [2,1.1]

		case 1312:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.2}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.2);
				}
			});

		case 1320:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.3}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.3);
				}
			});

		case 1328:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.2}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.2);
				}
			});

		case 1336:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 1343:
			// Camera Modulo Change | time: 121355.361446 | params: [1,1.2]

		case 1344:
			// Camera Position | time: 121445 | params: [-50,50,true,32,"expo","Out",true]
			// Camera Movement | time: 121445 | params: [2,true,32,"expo","Out"]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.9);
				}
			});

		case 1360:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 1376:
			// Camera Movement | time: 124337.634146 | params: [1]

		case 1392:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 1408:
			// Camera Position | time: 127228 | params: [-50,50,true,32,"expo","Out",true]
			// Camera Movement | time: 127228 | params: [2,true,32,"expo","Out"]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.9);
				}
			});

		case 1424:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 1440:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});
		// Camera Movement | time: 130120.634146 | params: [1]

		case 1456:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 1464:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.2}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.2);
				}
			});

		case 1471:
			// Camera Modulo Change | time: 132921.361446 | params: [1,1.1]

		case 1472:
			// Camera Position | time: 133012 | params: [-50,50,true,32,"expo","Out",true]
			// Camera Movement | time: 133012 | params: [2,true,32,"expo","Out"]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.9);
				}
			});

		case 1487:
			// Camera Modulo Change | time: 134367.361446 | params: [1,1]

		case 1503:
			// Camera Modulo Change | time: 135813.361446 | params: [1,0.7]

		case 1511:
			// Camera Modulo Change | time: 136536.361446 | params: [1,0.4]

		case 1519:
			// Camera Modulo Change | time: 137259.361446 | params: [1,0.2]

		case 1535:
			// Camera Modulo Change | time: 138704.361446 | params: [4,0.2]
	}
}
