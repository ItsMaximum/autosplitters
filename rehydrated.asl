state("Pineapple-Win64-Shipping", "Rev 603296")
{
	bool isLoading: "Pineapple-Win64-Shipping.exe", 0x0338B8D0, 0x20, 0x1A0;
	int spatCount: "Pineapple-Win64-Shipping.exe", 0x03487038, 0x8, 0x6E0;
	string150  map: "Pineapple-Win64-Shipping.exe", 0x3488090, 0x8A8, 0x0;
}

state("Pineapple-Win64-Shipping", "Rev 603442")
{
	bool isLoading: "Pineapple-Win64-Shipping.exe", 0x0331A650, 0x20, 0x1D0;
	int spatCount: "Pineapple-Win64-Shipping.exe", 0x03415DB8, 0x8, 0x6E0;
	string150  map: "Pineapple-Win64-Shipping.exe", 0x03416E10, 0x8A8, 0x0;
}

startup
{
	vars.newRun = false;
	vars.startOffset = 138f/60f; //Bubble animation after starting new save file (+1 frame of ASL delay)
	vars.buildSpatList = false;
	vars.spatSplits = new List<int>();
	vars.splitsQueued = 0;
	vars.splitThroughQueue = false;
	
	settings.Add("reset", true, "Reset");
	settings.Add("mainMenuReset", false, "Reset on Main Menu", "reset");
	settings.Add("newGameReset", true, "Reset on New Game", "reset");

	settings.Add("misc", false, "Miscellaneous");
	settings.Add("warpSplit", false, "Split on leaving Spongebob's House (2 Spat Warp)", "misc");

	settings.Add("spatSplit", false, "Split on collecting certain number of spatulas");
	settings.Add("delaySpatSplit", true, "-- Delay splitting until next map transition", "spatSplit");
	for(int i = 1; i < 100; i++)
	{
	    settings.Add("spat"+(i).ToString(), false, (i).ToString()+" spatulas", "spatSplit");
	}


	vars.mainMenu = "/Game/Maps/MainMenu/MainMenu_P";
	vars.introCutscene = "/Game/Maps/IntroCutscene/IntroCutscene_P";
	vars.finalLevel = "/Game/Maps/ChumBucketLab/Part3/ChumBucketLab_03_P";
	
	if (timer.CurrentTimingMethod == TimingMethod.RealTime)
	{        
		var timingMessage = MessageBox.Show (
			"This game uses Time without Loads (Game Time) as the main timing method.\n"+
			"LiveSplit is currently set to show Real Time (RTA).\n"+
			"Would you like to set the timing method to Game Time?",
			"LiveSplit | BFBB Rehydrated",
			MessageBoxButtons.YesNo,MessageBoxIcon.Question
		);
		if (timingMessage == DialogResult.Yes)
		{
			timer.CurrentTimingMethod = TimingMethod.GameTime;
		}
	}
}

init
{
	int moduleSize = modules.First().ModuleMemorySize;
	print("[BFBB ASL] Main Module Size: "+moduleSize.ToString());
	if (moduleSize == 58867712)
	{
		version = "Rev 603296";
	} 
	else if (moduleSize == 58372096)
	{
		version = "Rev 603442";
	}
	else
	{
		version = "Unsupported: " + moduleSize.ToString();
		MessageBox.Show("This game version is currently not supported.", "LiveSplit Auto Splitter - Unsupported Game Version");
	}
}


update
{
	//Disable the script if the version is unknown
	if (version.Contains("Unsupported"))
		return false;
	
	if (vars.buildSpatList)
	{
		vars.buildSpatList = false;
		for(int i = 1; i < 100; i++)
		{
			if(settings["spat"+i.ToString()])
				vars.spatSplits.Add(i);
		}
		print("[BFBB ASL] List of spatulas to split for: "+string.Join(", ", vars.spatSplits));
	}

	if (old.map != current.map)
		print("[BFBB ASL] Map change \""+old.map+"\" -> \""+current.map+"\"");

	if (current.spatCount > old.spatCount)
		print("[BFBB ASL] Spat count increased to "+current.spatCount.ToString());
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
		reset = (old.map != null && old.map != current.map && current.map == vars.mainMenu); //Checking old map for null to avoid resetting on game crash
	}

	if(settings["newGameReset"] && !reset)
	{
		reset = (old.map != current.map && current.map == vars.introCutscene);
	}

	if(reset)
	{
		print("[BFBB ASL] Resetting run on \""+current.map+"\"");
		return true;
	}
}

start
{
	if(old.isLoading && !current.isLoading && current.map == vars.introCutscene)
	{
		vars.spatSplits = new List<int>();
		if(settings["spatSplit"])
			vars.buildSpatList = true; //Build a list of spatulas amounts that we split on (if option is checked)
		vars.splitsQueued = 0;
		vars.splitThroughQueue = false;
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
	if(vars.spatSplits.Count > 0 && settings["spatSplit"])
	{
		if(current.spatCount >= vars.spatSplits[0])
		{
			vars.spatSplits.RemoveAt(0); //Remove current spatula amount from the list to split for (so we don't accidentally split for it again)
			if(!settings["delaySpatSplit"]) //Splitting immediately for current amount of spatulas
			{
				print("[BFBB ASL] Splitting for "+current.spatCount+" spatulas");
				return true;
			}
			else //Queueing split for next map transition
			{
				vars.splitsQueued += 1;
				print("[BFBB ASL] Queued split for "+current.spatCount+" spatulas");
			}
		}
	}

	if(vars.splitThroughQueue || (old.map != current.map && old.map != vars.mainMenu && current.map != vars.mainMenu && vars.splitsQueued > 0)) //Looking for queued splits to work through if map has changed (excluding main menu)
	{
		print("[BFBB ASL] Splitting for queued split");
		vars.splitsQueued -= 1;
		vars.splitThroughQueue = (vars.splitsQueued > 0); // Because we can't split multiple times during one cycle this is set to true to make sure that the queue will be worked through in the upcoming cycle
		return true;
	}

	if(settings["warpSplit"] && old.map == "/Game/Maps/BikiniBottom/SpongeBobHouse/SpongeBobHouse_P" && current.map != old.map && current.map != null && current.map != vars.mainMenu)
	{	
		print("[BFBB ASL] Splitting for 2 spat warp transition");
		return true;
	}

	if(old.spatCount != current.spatCount && current.map == vars.finalLevel) //This is hardcoded currently, I'm not sure if there are any cases where you wouldn't want this to trigger a split
	{
		print("[BFBB ASL] Splitting for final spatula");
		return true;
	}
}
