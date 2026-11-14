function stepHit(curStep)
{
	switch (curStep)
	{
		case 0:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});
		// Camera Movement | time: 0.965517 | params: [0]

		case 1:
			// Camera Modulo Change | time: 129 | params: [2,0.7]

		case 52:
			// Camera Movement | time: 4482.714286 | params: [1]

		case 62:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.2}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.2);
				}
			});

		case 94:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.3}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.3);
				}
			});

		case 127:
			// Camera Modulo Change | time: 10948 | params: [1,0.7]

		case 132:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});
		// Camera Movement | time: 11379.965517 | params: [0]

		case 148:
			// Camera Movement | time: 12758.714286 | params: [1]

		case 160:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 176:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.82}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.82);
				}
			});
		// Camera Movement | time: 15172.714286 | params: [2]

		case 224:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.9);
				}
			});

		case 240:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});
		// Camera Movement | time: 20689.714286 | params: [1]

		case 260:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.95}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.95);
				}
			});

		case 280:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 304:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 312:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.15}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.15);
				}
			});

		case 320:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 332:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.04}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.04);
				}
			});

		case 344:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.08}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.08);
				}
			});

		case 356:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.12}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.12);
				}
			});

		case 364:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.16}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.16);
				}
			});

		case 383:
			// Camera Modulo Change | time: 33017 | params: [2,0.7]

		case 384:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 392:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.82}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.82);
				}
			});
		// Camera Movement | time: 33793.714286 | params: [2]

		case 472:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.88}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.88);
				}
			});

		case 480:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.82}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.82);
				}
			});

		case 496:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.88}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.88);
				}
			});

		case 511:
			// Camera Modulo Change | time: 44051 | params: [1,0.9]

		case 512:
			// Camera Movement | time: 44137.714286 | params: [1]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 544:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});

		case 576:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 608:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.04}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.04);
				}
			});

		case 614:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.08}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.08);
				}
			});

		case 620:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.12}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.12);
				}
			});

		case 626:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.16}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.16);
				}
			});

		case 632:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.12}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.12);
				}
			});

		case 639:
			// Camera Modulo Change | time: 55086 | params: [1,1.2]

		case 640:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 648:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.82}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.82);
				}
			});
		// Camera Movement | time: 55862.714286 | params: [2]

		case 700:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.88}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.88);
				}
			});

		case 708:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});
		// Camera Movement | time: 61034.714286 | params: [1]

		case 726:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 760:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.15}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.15);
				}
			});

		case 768:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.2}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.2);
				}
			});

		case 816:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.25}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.25);
				}
			});

		case 832:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.2}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.2);
				}
			});

		case 844:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.15}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.15);
				}
			});

		case 856:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 863:
			// Camera Modulo Change | time: 74396 | params: [4,1.5]

		case 864:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});

		case 880:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 895:
			// Camera Modulo Change | time: 77155 | params: [1,0.8]

		case 896:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.82}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.82);
				}
			});
		// Camera Movement | time: 77241.714286 | params: [2]

		case 932:
			// Camera Movement | time: 80344.714286 | params: [1]

			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 937:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 942:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 976:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});

		case 992:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 1006:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 1024:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});
		// Camera Movement | time: 88275.965517 | params: [0]

		case 1042:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.82}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.82);
				}
			});
		// Camera Movement | time: 89827.714286 | params: [2]

		case 1056:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.88}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.88);
				}
			});

		case 1088:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expo,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});
		// Camera Movement | time: 93793.714286 | params: [1]

		case 1114:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 0.95}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.95);
				}
			});

		case 1120:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 1136:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 1144:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.2}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.2);
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

		case 1156:
			// Camera Movement | time: 99655.965517 | params: [0]

		case 1172:
			// Camera Movement | time: 101034.714286 | params: [1]

		case 1188:
			// Camera Movement | time: 102413.965517 | params: [0]

		case 1204:
			// Camera Movement | time: 103793.714286 | params: [1]

		case 1216:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.05}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.05);
				}
			});
		// Camera Movement | time: 104827.965517 | params: [0]

		case 1228:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});
		// Camera Movement | time: 105862.714286 | params: [1]

		case 1240:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.15}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.15);
				}
			});
		// Camera Movement | time: 106896.965517 | params: [0]

		case 1252:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.2}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.2);
				}
			});
		// Camera Movement | time: 107931.714286 | params: [1]

		case 1272:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1.1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1.1);
				}
			});

		case 1280:
			FlxTween.cancelTweensOf(FlxG.camera);

			FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 1304:
			// Camera Modulo Change | time: 112413 | params: [4,0]
	}
}
