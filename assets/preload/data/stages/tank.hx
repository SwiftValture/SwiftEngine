var tankWatchtower = null;
var tankGround = null;
var tankAngle = FlxG.random.int(-90, 45);
var tankSpeed = FlxG.random.float(5, 7);
var tankX = 400;

function create()
{
	stage.gfVersion = 'gf-tankmen';
	stage.defaultCamZoom = 0.90;

	var bg = new BGSprite('tankSky', -400, -400, 0, 0);
	add(bg);

	var tankSky = new BGSprite('tankClouds', FlxG.random.int(-700, -100), FlxG.random.int(-20, 20), 0.1, 0.1);
	tankSky.active = true;
	tankSky.velocity.x = FlxG.random.float(5, 15);
	add(tankSky);

	var tankMountains = new BGSprite('tankMountains', -300, -20, 0.2, 0.2);
	tankMountains.setGraphicSize(Std.int(tankMountains.width * 1.2));
	tankMountains.updateHitbox();
	add(tankMountains);

	var tankBuildings = new BGSprite('tankBuildings', -200, 0, 0.30, 0.30);
	tankBuildings.setGraphicSize(Std.int(tankBuildings.width * 1.1));
	tankBuildings.updateHitbox();
	add(tankBuildings);

	var tankRuins = new BGSprite('tankRuins', -200, 0, 0.35, 0.35);
	tankRuins.setGraphicSize(Std.int(tankRuins.width * 1.1));
	tankRuins.updateHitbox();
	add(tankRuins);

	var smokeLeft = new BGSprite('smokeLeft', -200, -100, 0.4, 0.4, ['SmokeBlurLeft'], true);
	add(smokeLeft);

	var smokeRight = new BGSprite('smokeRight', 1100, -100, 0.4, 0.4, ['SmokeRight'], true);
	add(smokeRight);

	tankWatchtower = new BGSprite('tankWatchtower', 100, 50, 0.5, 0.5, ['watchtower gradient color']);
	add(tankWatchtower);

	tankGround = new BGSprite('tankRolling', 300, 300, 0.5, 0.5, ['BG tank w lighting'], true);
	add(tankGround);

	stage.tankmanRun = new FlxTypedGroup();
	add(stage.tankmanRun);

	var tankGroundFront = new BGSprite('tankGround', -420, -150);
	tankGroundFront.setGraphicSize(Std.int(tankGroundFront.width * 1.15));
	tankGroundFront.updateHitbox();
	add(tankGroundFront);

	moveTank(false);

	var fgTank0 = new BGSprite('tank0', -500, 650, 1.7, 1.5, ['fg']);
	foregroundSprites.add(fgTank0);

	var fgTank1 = new BGSprite('tank1', -300, 750, 2, 0.2, ['fg']);
	foregroundSprites.add(fgTank1);

	var fgTank2 = new BGSprite('tank2', 450, 940, 1.5, 1.5, ['foreground']);
	foregroundSprites.add(fgTank2);

	var fgTank4 = new BGSprite('tank4', 1300, 900, 1.5, 1.5, ['fg']);
	foregroundSprites.add(fgTank4);

	var fgTank5 = new BGSprite('tank5', 1620, 700, 1.5, 1.5, ['fg']);
	foregroundSprites.add(fgTank5);

	var fgTank3 = new BGSprite('tank3', 1300, 1200, 3.5, 2.5, ['fg']);
	foregroundSprites.add(fgTank3);
}

function positionCharacters(dad, gf, boyfriend, gfName)
{
	gf.y += 10;
	gf.x -= 30;
	boyfriend.x += 40;
	boyfriend.y += 0;
	dad.y += 60;
	dad.x -= 80;

	if (gfName != 'pico-speaker')
	{
		gf.x -= 170;
		gf.y -= 75;
	}
}

function update(elapsed, inCutscene)
{
	moveTank(inCutscene);
}

function beatHit(curBeat)
{
	tankWatchtower.dance();
}

function moveTank(inCutscene)
{
	if (!inCutscene && tankGround != null)
	{
		var daAngleOffset = 1;
		var toRad = Math.PI / 180;

		tankAngle += FlxG.elapsed * tankSpeed;
		tankGround.angle = tankAngle - 90 + 15;

		tankGround.x = tankX + Math.cos(((tankAngle * daAngleOffset) + 180) * toRad) * 1500;
		tankGround.y = 1300 + Math.sin(((tankAngle * daAngleOffset) + 180) * toRad) * 1100;
	}
}
