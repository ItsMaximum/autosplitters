state("Pineapple-Win64-Shipping")
{
	bool isLoading: "Pineapple-Win64-Shipping.exe", 0x0338B8D0, 0x20, 0x1A0;
	int spatCount: "Pineapple-Win64-Shipping.exe", 0x03487038, 0x8, 0x6E0;
	string100  map: "Pineapple-Win64-Shipping.exe", 0x3488090, 0x8A8, 0x0;
}

startup
{
	vars.newRun = false;
	vars.startOffset = 137f/60f;

	settings.Add("mainMenuReset", false, "Reset on Main Menu");
	settings.Add("newGameReset", true, "Reset on New Game");

	vars.mainMenu = "/Game/Maps/MainMenu/MainMenu_P";
	vars.introCutscene = "/Game/Maps/IntroCutscene/IntroCutscene_P";
	vars.finalLevel = "/Game/Maps/ChumBucketLab/Part3/ChumBucketLab_03_P";
	
	if (timer.CurrentTimingMethod == TimingMethod.RealTime)
	{        
		var timingMessage = MessageBox.Show (
			"This game uses Time without Loads (Game Time) as the main timing method.\n"+
			"LiveSplit is currently set to show Real Time (RTA).\n"+
			"Would you like to set the timing method to Game Time?",
			"Livesplit | BFBB Rehydrated",
			MessageBoxButtons.YesNo,MessageBoxIcon.Question
		);
		
		if (timingMessage == DialogResult.Yes)
		{
			timer.CurrentTimingMethod = TimingMethod.GameTime;
		}
	}
}

gameTime
{
	if (vars.newRun)
	{
		vars.newRun = false;
		return TimeSpan.FromSeconds(vars.startOffset);
	}
}

reset
{
	var reset = false;

	if(settings["mainMenuReset"])
	{
		reset = old.map != null && old.map != current.map && current.map == vars.mainMenu;
	}

	if(settings["newGameReset"] && !reset)
	{
		reset = !old.isLoading && current.isLoading && current.map == vars.introCutscene;
	}

	return reset;
}

start
{
	if(!old.isLoading && current.isLoading && current.map == vars.introCutscene)
	{
		vars.newRun = true;
		return true;
	}
}

isLoading
{
	return current.isLoading;
}

split
{
	return old.spatCount != current.spatCount && current.map == vars.finalLevel;
}
