function stepHit(curStep)
{
	switch (curStep)
	{
		case 0:
			// FocusCamera: x=0, y=0, char=1
		case 32:
			// FocusCamera: x=0, y=0, char=0
		case 64:
			// FocusCamera: x=0, y=0, char=1
		case 96:
			// FocusCamera: x=0, y=0, char=0
		case 128:
			// FocusCamera: x=0, y=0, char=1
		case 192:
			// FocusCamera: x=0, y=0, char=0
		case 255:
			// SetCameraBop: rate=2, intensity=1.1
		case 256:
			// FocusCamera: x=0, y=0, char=1
		case 304:
			// FocusCamera: x=0, y=0, char=0
		case 319:
			// SetCameraBop: rate=2, intensity=1.2
		case 383:
			// SetCameraBop: rate=1, intensity=1.3
		case 384:
			FlxTween.cancelTweensOf(camGame);
			FlxTween.tween(camGame, {zoom: 1.1}, 2.526316, {
				ease: FlxEase.linear,
				onComplete: function(tween)
				{
					defaultCamZoom = 1.1;
				}
			});
		case 447:
			// SetCameraBop: rate=1, intensity=1.4
		case 448:
			FlxTween.cancelTweensOf(camGame);
			FlxTween.tween(camGame, {zoom: 1.2}, 2.526316, {
				ease: FlxEase.linear,
				onComplete: function(tween)
				{
					defaultCamZoom = 1.2;
				}
			});
		case 479:
			// SetCameraBop: rate=1, intensity=1.5
		case 480:
			FlxTween.cancelTweensOf(camGame);
			FlxTween.tween(camGame, {zoom: 1.3}, 2.526316, {
				ease: FlxEase.linear,
				onComplete: function(tween)
				{
					defaultCamZoom = 1.3;
				}
			});
		case 496:
			FlxTween.cancelTweensOf(camGame);
			FlxTween.tween(camGame, {zoom: 1.35}, 2.526316, {
				ease: FlxEase.linear,
				onComplete: function(tween)
				{
					defaultCamZoom = 1.35;
				}
			});
		case 511:
			// SetCameraBop: rate=1, intensity=1.2
		case 512:
			// FocusCamera: x=0, y=0, char=1
			FlxTween.cancelTweensOf(camGame);
			FlxTween.tween(camGame, {zoom: 1}, 2.526316, {
				ease: FlxEase.linear,
				onComplete: function(tween)
				{
					defaultCamZoom = 1;
				}
			});
		case 524:
			// FocusCamera: x=-100, y=30, char=2
			FlxTween.cancelTweensOf(camGame);
			FlxTween.tween(camGame, {zoom: 0.95}, 2.526316, {
				ease: FlxEase.linear,
				onComplete: function(tween)
				{
					defaultCamZoom = 0.95;
				}
			});
		case 576:
			// FocusCamera: x=-20, y=30, char=2
		case 624:
			// FocusCamera: x=0, y=0, char=0
			FlxTween.cancelTweensOf(camGame);
			FlxTween.tween(camGame, {zoom: 1}, 2.526316, {
				ease: FlxEase.linear,
				onComplete: function(tween)
				{
					defaultCamZoom = 1;
				}
			});
		case 703:
			// SetCameraBop: rate=1, intensity=1.3
		case 704:
			FlxTween.cancelTweensOf(camGame);
			FlxTween.tween(camGame, {zoom: 1.1}, 2.526316, {
				ease: FlxEase.linear,
				onComplete: function(tween)
				{
					defaultCamZoom = 1.1;
				}
			});
		case 738:
			FlxTween.cancelTweensOf(camGame);
			FlxTween.tween(camGame, {zoom: 1.2}, 2.526316, {
				ease: FlxEase.linear,
				onComplete: function(tween)
				{
					defaultCamZoom = 1.2;
				}
			});
		case 752:
			FlxTween.cancelTweensOf(camGame);
			FlxTween.tween(camGame, {zoom: 1.3}, 2.526316, {
				ease: FlxEase.linear,
				onComplete: function(tween)
				{
					defaultCamZoom = 1.3;
				}
			});
		case 764:
			FlxTween.cancelTweensOf(camGame);
			FlxTween.tween(camGame, {zoom: 1.1}, 0.631579, {
				ease: FlxEase.linear,
				onComplete: function(tween)
				{
					defaultCamZoom = 1.1;
				}
			});
		case 767:
			// SetCameraBop: rate=1, intensity=1.2
		case 768:
			// FocusCamera: x=-100, y=30, char=2
			FlxTween.cancelTweensOf(camGame);
			FlxTween.tween(camGame, {zoom: 0.9}, 2.526316, {
				ease: FlxEase.linear,
				onComplete: function(tween)
				{
					defaultCamZoom = 0.9;
				}
			});
		case 800:
			// FocusCamera: x=-20, y=30, char=2
		case 832:
			// FocusCamera: x=-100, y=30, char=2
		case 864:
			// FocusCamera: x=-20, y=30, char=2
		case 896:
			// FocusCamera: x=-100, y=30, char=2
		case 959:
			// SetCameraBop: rate=1, intensity=1.3
		case 960:
			// FocusCamera: x=0, y=0, char=0
			FlxTween.cancelTweensOf(camGame);
			FlxTween.tween(camGame, {zoom: 1}, 2.526316, {
				ease: FlxEase.linear,
				onComplete: function(tween)
				{
					defaultCamZoom = 1;
				}
			});
		case 992:
			FlxTween.cancelTweensOf(camGame);
			FlxTween.tween(camGame, {zoom: 1.1}, 2.526316, {
				ease: FlxEase.linear,
				onComplete: function(tween)
				{
					defaultCamZoom = 1.1;
				}
			});
		case 1008:
			FlxTween.cancelTweensOf(camGame);
			FlxTween.tween(camGame, {zoom: 1.2}, 2.526316, {
				ease: FlxEase.linear,
				onComplete: function(tween)
				{
					defaultCamZoom = 1.2;
				}
			});
		case 1016:
			FlxTween.cancelTweensOf(camGame);
			FlxTween.tween(camGame, {zoom: 0.9}, 2.526316, {
				ease: FlxEase.linear,
				onComplete: function(tween)
				{
					defaultCamZoom = 0.9;
				}
			});
		case 1023:
			// SetCameraBop: rate=1, intensity=1.2
		case 1024:
			FlxTween.cancelTweensOf(camGame);
			FlxTween.tween(camGame, {zoom: 1}, 2.526316, {
				ease: FlxEase.linear,
				onComplete: function(tween)
				{
					defaultCamZoom = 1;
				}
			});
		case 1088:
			FlxTween.cancelTweensOf(camGame);
			FlxTween.tween(camGame, {zoom: 0.9}, 2.526316, {
				ease: FlxEase.linear,
				onComplete: function(tween)
				{
					defaultCamZoom = 0.9;
				}
			});
		case 1152:
			FlxTween.cancelTweensOf(camGame);
			FlxTween.tween(camGame, {zoom: 1}, 2.526316, {
				ease: FlxEase.linear,
				onComplete: function(tween)
				{
					defaultCamZoom = 1;
				}
			});
		case 1216:
			FlxTween.cancelTweensOf(camGame);
			FlxTween.tween(camGame, {zoom: 1.1}, 2.526316, {
				ease: FlxEase.linear,
				onComplete: function(tween)
				{
					defaultCamZoom = 1.1;
				}
			});
		case 1248:
			FlxTween.cancelTweensOf(camGame);
			FlxTween.tween(camGame, {zoom: 1.2}, 2.526316, {
				ease: FlxEase.linear,
				onComplete: function(tween)
				{
					defaultCamZoom = 1.2;
				}
			});
		case 1260:
			FlxTween.cancelTweensOf(camGame);
			FlxTween.tween(camGame, {zoom: 1.1}, 2.526316, {
				ease: FlxEase.linear,
				onComplete: function(tween)
				{
					defaultCamZoom = 1.1;
				}
			});
		case 1264:
			FlxTween.cancelTweensOf(camGame);
			FlxTween.tween(camGame, {zoom: 1.3}, 2.526316, {
				ease: FlxEase.linear,
				onComplete: function(tween)
				{
					defaultCamZoom = 1.3;
				}
			});
		case 1276:
			FlxTween.cancelTweensOf(camGame);
			FlxTween.tween(camGame, {zoom: 1.2}, 2.526316, {
				ease: FlxEase.linear,
				onComplete: function(tween)
				{
					defaultCamZoom = 1.2;
				}
			});
		case 1280:
			FlxTween.cancelTweensOf(camGame);
			FlxTween.tween(camGame, {zoom: 1}, 2.526316, {
				ease: FlxEase.linear,
				onComplete: function(tween)
				{
					defaultCamZoom = 1;
				}
			});
		case 1312:
			FlxTween.cancelTweensOf(camGame);
			FlxTween.tween(camGame, {zoom: 1.1}, 2.526316, {
				ease: FlxEase.linear,
				onComplete: function(tween)
				{
					defaultCamZoom = 1.1;
				}
			});
		case 1316:
			FlxTween.cancelTweensOf(camGame);
			FlxTween.tween(camGame, {zoom: 1}, 2.526316, {
				ease: FlxEase.linear,
				onComplete: function(tween)
				{
					defaultCamZoom = 1;
				}
			});
		case 1344:
			FlxTween.cancelTweensOf(camGame);
			FlxTween.tween(camGame, {zoom: 1.1}, 2.526316, {
				ease: FlxEase.linear,
				onComplete: function(tween)
				{
					defaultCamZoom = 1.1;
				}
			});
		case 1348:
			FlxTween.cancelTweensOf(camGame);
			FlxTween.tween(camGame, {zoom: 1}, 2.526316, {
				ease: FlxEase.linear,
				onComplete: function(tween)
				{
					defaultCamZoom = 1;
				}
			});
		case 1408:
			// FocusCamera: x=-100, y=30, char=2
			FlxTween.cancelTweensOf(camGame);
			FlxTween.tween(camGame, {zoom: 0.9}, 2.526316, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 0.9;
				}
			});
		case 1472:
			// FocusCamera: x=0, y=0, char=0
			FlxTween.cancelTweensOf(camGame);
			FlxTween.tween(camGame, {zoom: 0.95}, 2.526316, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 0.95;
				}
			});
		case 1504:
			FlxTween.cancelTweensOf(camGame);
			FlxTween.tween(camGame, {zoom: 1}, 2.526316, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1;
				}
			});
		case 1516:
			FlxTween.cancelTweensOf(camGame);
			FlxTween.tween(camGame, {zoom: 0.9}, 2.526316, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 0.9;
				}
			});
		case 1520:
			FlxTween.cancelTweensOf(camGame);
			FlxTween.tween(camGame, {zoom: 1.1}, 2.526316, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1.1;
				}
			});
		case 1532:
			FlxTween.cancelTweensOf(camGame);
			FlxTween.tween(camGame, {zoom: 1}, 2.526316, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1;
				}
			});
		case 1535:
			// SetCameraBop: rate=4, intensity=1
		case 1536:
			FlxTween.cancelTweensOf(camGame);
			FlxTween.tween(camGame, {zoom: 1}, 2.526316, {
				ease: FlxEase.expoOut,
				onComplete: function(tween)
				{
					defaultCamZoom = 1;
				}
			});
		// FocusCamera: x=0, y=0, char=1
		case 1568:
			// FocusCamera: x=0, y=0, char=0
		case 1600:
			// FocusCamera: x=0, y=0, char=1
		case 1632:
			// FocusCamera: x=0, y=0, char=0
	}
}
