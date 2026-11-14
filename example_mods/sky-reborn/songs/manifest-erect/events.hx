function stepHit(curStep)
{
	switch (curStep)
	{
		case 128:
			// Camera Movement | time: 14407.894737 | params: [0]

			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.8}, Conductor.stepCrochet / 1000 * 8, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.8);
				}
			});

		case 192:
			// Camera Movement | time: 20004.450355 | params: [1]

		case 240:
			// Camera Movement | time: 23578.076729 | params: [0]

		case 248:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.5}, Conductor.stepCrochet / 1000 * 8, {
				ease: FlxEase.expoIn,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.5);
				}
			});

		case 256:
			// Camera Modulo Change | time: 24689.18784 | params: [1,2.3]

			camZoomInterval(1, 0.0345, 0.069);

		case 320:
			// Camera Movement | time: 28955.854507 | params: [1]

		case 380:
			// Camera Modulo Change | time: 32955.854507 | params: [5,2.7]

			camZoomInterval(5, 0.0405, 0.081);

		case 384:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});
		// Camera Movement | time: 33222.521173 | params: [0]

		case 424:
			// Camera Movement | time: 35889.18784 | params: [1]

			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 8, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.9);
				}
			});

		case 464:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.8}, Conductor.stepCrochet / 1000 * 8, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.8);
				}
			});
		// Camera Movement | time: 38555.854507 | params: [0]

		case 504:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.7}, Conductor.stepCrochet / 1000 * 8, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.7);
				}
			});
		// Camera Movement | time: 41222.521173 | params: [1]

		case 540:
			// Camera Modulo Change | time: 43622.521173 | params: [4,1]

			camZoomInterval(4, 0.015, 0.03);

		case 544:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.6}, Conductor.stepCrochet / 1000 * 8, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.6);
				}
			});
		// Camera Movement | time: 43889.18784 | params: [0]

		case 600:
			// Camera Modulo Change | time: 47622.521173 | params: [1,2]

			camZoomInterval(1, 0.03, 0.06);

		case 604:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.5}, Conductor.stepCrochet / 1000 * 4, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.5);
				}
			});

		case 608:
			// Camera Movement | time: 48155.854507 | params: [1]

			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.8}, 0.01, {
				ease: FlxEase.INSTANT,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.8);
				}
			});

		case 668:
			// Camera Modulo Change | time: 52155.854507 | params: [4,1.4]

			camZoomInterval(4, 0.021, 0.042);

		case 672:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.6}, Conductor.stepCrochet / 1000 * 8, {
				ease: FlxEase.cubeOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.6);
				}
			});
		// Camera Movement | time: 52422.521173 | params: [0]

		case 736:
			// Camera Movement | time: 56689.18784 | params: [1]

			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 8, {
				ease: FlxEase.cubeOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.9);
				}
			});

		case 796:
			// Camera Modulo Change | time: 60689.18784 | params: [3,1.5]

			camZoomInterval(3, 0.0225, 0.045);

		case 800:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.6}, Conductor.stepCrochet / 1000 * 6, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.6);
				}
			});

		case 806:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.8}, Conductor.stepCrochet / 1000 * 6, {
				ease: FlxEase.expoIn,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.8);
				}
			});

		case 812:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.6}, Conductor.stepCrochet / 1000 * 6, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.6);
				}
			});

		case 818:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.8}, Conductor.stepCrochet / 1000 * 6, {
				ease: FlxEase.expoIn,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.8);
				}
			});

		case 824:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.6}, Conductor.stepCrochet / 1000 * 6, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.6);
				}
			});

		case 830:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.8}, Conductor.stepCrochet / 1000 * 6, {
				ease: FlxEase.expoIn,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.8);
				}
			});

		case 836:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.6}, Conductor.stepCrochet / 1000 * 6, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.6);
				}
			});

		case 842:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.5}, Conductor.stepCrochet / 1000 * 6, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.5);
				}
			});

		case 848:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.6}, Conductor.stepCrochet / 1000 * 6, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.6);
				}
			});

		case 854:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.8}, Conductor.stepCrochet / 1000 * 6, {
				ease: FlxEase.expoIn,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.8);
				}
			});

		case 860:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.6}, Conductor.stepCrochet / 1000 * 6, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.6);
				}
			});

		case 866:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.8}, Conductor.stepCrochet / 1000 * 6, {
				ease: FlxEase.expoIn,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.8);
				}
			});

		case 872:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.6}, Conductor.stepCrochet / 1000 * 6, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.6);
				}
			});

		case 878:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.8}, Conductor.stepCrochet / 1000 * 6, {
				ease: FlxEase.expoIn,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.8);
				}
			});

		case 884:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.6}, Conductor.stepCrochet / 1000 * 6, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.6);
				}
			});

		case 890:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.5}, Conductor.stepCrochet / 1000 * 6, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.5);
				}
			});

		case 896:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.6}, Conductor.stepCrochet / 1000 * 6, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.6);
				}
			});
		// Camera Movement | time: 67355.854507 | params: [0]

		case 902:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.8}, Conductor.stepCrochet / 1000 * 6, {
				ease: FlxEase.expoIn,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.8);
				}
			});

		case 908:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.6}, Conductor.stepCrochet / 1000 * 6, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.6);
				}
			});

		case 914:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.8}, Conductor.stepCrochet / 1000 * 6, {
				ease: FlxEase.expoIn,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.8);
				}
			});

		case 920:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.6}, Conductor.stepCrochet / 1000 * 6, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.6);
				}
			});

		case 926:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.8}, Conductor.stepCrochet / 1000 * 6, {
				ease: FlxEase.expoIn,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.8);
				}
			});

		case 932:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.6}, Conductor.stepCrochet / 1000 * 6, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.6);
				}
			});

		case 938:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.5}, Conductor.stepCrochet / 1000 * 6, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.5);
				}
			});

		case 944:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.6}, Conductor.stepCrochet / 1000 * 6, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.6);
				}
			});
		// Camera Movement | time: 70555.854507 | params: [1]

		case 950:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.8}, Conductor.stepCrochet / 1000 * 6, {
				ease: FlxEase.expoIn,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.8);
				}
			});

		case 956:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.5}, Conductor.stepCrochet / 1000 * 18, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.5);
				}
			});

		case 980:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 12, {
				ease: FlxEase.expoIn,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 988:
			// Camera Modulo Change | time: 73489.18784 | params: [4,1.1]

			camZoomInterval(4, 0.0165, 0.033);

		case 992:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.6}, Conductor.stepCrochet / 1000 * 128, {
				ease: FlxEase.linear,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.6);
				}
			});
		// Camera Movement | time: 73755.854507 | params: [0]

		case 1056:
			// Camera Movement | time: 79298.062299 | params: [1]

		case 1120:
			// Camera Modulo Change | time: 84032.799783 | params: [16,2]

			camZoomInterval(16, 0.03, 0.06);

			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 8, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});
		// Camera Movement | time: 84032.799783 | params: [0]

		case 1128:
			// Camera Modulo Change | time: 84566.133117 | params: [1,1.3]

			camZoomInterval(1, 0.0195, 0.039);

		case 1132:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.6}, Conductor.stepCrochet / 1000 * 8, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.6);
				}
			});

		case 1184:
			// Camera Movement | time: 88299.46645 | params: [1]

		case 1232:
			// Camera Movement | time: 91499.46645 | params: [0]

		case 1248:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.8}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.8);
				}
			});

		case 1280:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.6}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.6);
				}
			});

		case 1312:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.8}, Conductor.stepCrochet / 1000 * 8, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.8);
				}
			});

		case 1328:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.7}, Conductor.stepCrochet / 1000 * 8, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.7);
				}
			});

		case 1344:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.8}, Conductor.stepCrochet / 1000 * 8, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.8);
				}
			});

		case 1360:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.7}, Conductor.stepCrochet / 1000 * 8, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.7);
				}
			});

		case 1376:
			// Camera Movement | time: 100402.867811 | params: [1]

			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 1}, Conductor.stepCrochet / 1000 * 128, {
				ease: FlxEase.linear,
				onComplete: function(tween)
				{
					setDefaultCamZoom(1);
				}
			});

		case 1500:
			// Camera Modulo Change | time: 106928.47428 | params: [500,1]

			camZoomInterval(500, 0.015, 0.03);

		case 1504:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.6}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.cubeOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.6);
				}
			});
		// Camera Movement | time: 107128.47428 | params: [1]

		case 1536:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.7}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.cubeOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.7);
				}
			});

		case 1552:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.8}, Conductor.stepCrochet / 1000 * 12, {
				ease: FlxEase.cubeOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.8);
				}
			});

		case 1564:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 4, {
				ease: FlxEase.cubeOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.9);
				}
			});

		case 1568:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.7}, Conductor.stepCrochet / 1000 * 20, {
				ease: FlxEase.cubeOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.7);
				}
			});

		case 1586:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.75}, Conductor.stepCrochet / 1000 * 4, {
				ease: FlxEase.cubeOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.75);
				}
			});

		case 1591:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.8}, Conductor.stepCrochet / 1000 * 4, {
				ease: FlxEase.cubeOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.8);
				}
			});

		case 1597:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.5}, Conductor.stepCrochet / 1000 * 12, {
				ease: FlxEase.cubeOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.5);
				}
			});

		case 1612:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.6}, Conductor.stepCrochet / 1000 * 4, {
				ease: FlxEase.cubeOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.6);
				}
			});

		case 1616:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.7}, Conductor.stepCrochet / 1000 * 8, {
				ease: FlxEase.cubeOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.7);
				}
			});

		case 1624:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.8}, Conductor.stepCrochet / 1000 * 8, {
				ease: FlxEase.cubeOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.8);
				}
			});

		case 1628:
			// Camera Modulo Change | time: 114892.348508 | params: [600,1]

			camZoomInterval(600, 0.015, 0.03);

		case 1632:
			// Camera Movement | time: 115118.763602 | params: [0]

			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.5}, Conductor.stepCrochet / 1000 * 16, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.5);
				}
			});

		case 1664:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.6}, Conductor.stepCrochet / 1000 * 4, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.6);
				}
			});

		case 1668:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.7}, Conductor.stepCrochet / 1000 * 4, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.7);
				}
			});

		case 1672:
			// Camera Movement | time: 118118.763602 | params: [1]

		case 1708:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.8}, Conductor.stepCrochet / 1000 * 4, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.8);
				}
			});

		case 1712:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 4, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.9);
				}
			});

		case 1718:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.7}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.7);
				}
			});

		case 1740:
			// Camera Modulo Change | time: 122901.57866 | params: [1,1.2]

			camZoomInterval(1, 0.018, 0.036);

		case 1744:
			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.9}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.9);
				}
			});

		case 1756:
			// Camera Modulo Change | time: 124293.638213 | params: [600,1.5]

			camZoomInterval(600, 0.0225, 0.045);

		case 1760:
			// Camera Movement | time: 124680.734987 | params: [2]

			FlxTween.cancelTweensOf(cameraZoomTarget);

			FlxTween.tween(cameraZoomTarget, {zoom: 0.5}, Conductor.stepCrochet / 1000 * 32, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					setDefaultCamZoom(0.5);
				}
			});
			// Camera Modulo Change | time: 124680.734987 | params: [300,4]

			camZoomInterval(300, 0.06, 0.12);
	}
}
