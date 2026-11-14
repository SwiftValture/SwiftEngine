setSkipCountdown(true, false);
setSkipStrumIntro(true);
function create()
{
	setShowRating(false);
	setShowCombo(false);
	setOpponentStrumsVisible(false);
	setOpponentNotesVisible(false);

	PreferencesMenu.setPref('camMovement', false);
	PreferencesMenu.setPref('show splashes', false);
	Main.fpsCounter.visible = false;
}

function postCreate()
{
	scoreTxt.alpha = 0;
	healthBarBG.alpha = 0;
	healthBar.alpha = 0;
	iconP1.alpha = 0;
	iconP2.alpha = 0;

	for (i in 0...strumLineNotes.playerStrums.length)
	{
		var strum = strumLineNotes.playerStrums.members[i];

		if (strum != null)
		{
			strumLineNotes.baseX[i + 4] += strumBaseX - 630;
			strum.x = strumLineNotes.baseX[i + 4];
		}
	}
}

var ranNum = 0;
var dirs = ['LEFT', 'DOWN', 'UP', 'RIGHT'];

function playVariant(note, n)
{
	var name = 'sing' + dirs[note.noteData] + '-' + n;
	if (dad.animation.exists(name))
		dad.playAnim(name, true);
}

function onOpponentHit(note)
{
	switch (note.noteType)
	{
		case 'begin':
			playVariant(note, 7);
		case 'whisper':
			if (!note.isSustainNote)
				ranNum = FlxG.random.int(0, 3);
			playVariant(note, ranNum);
		case 'yell':
			if (!note.isSustainNote)
				ranNum = FlxG.random.int(4, 7);
			playVariant(note, ranNum);
	}
}
