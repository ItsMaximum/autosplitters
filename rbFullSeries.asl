state("ActiveX Flash Player") {
}
state("Full Series") {
}

startup {
  vars.gameTime = TimeSpan.FromSeconds(0);
  vars.debug = false;
  vars.TimerModel = new TimerModel { CurrentState = timer };
  settings.Add("fsAny", false, "Freeze after Levels 12 and 20 in Red Ball 1 and 2 (Full Series Any% Mode)");
  settings.Add("gameSplit", false, "Only split after finishing each game");
  settings.Add("anyStart", false, "Start the timer upon entering any level (useful for Bonus Levels runs)");

	if (timer.CurrentTimingMethod == TimingMethod.RealTime)
	{
		var timingMessage = MessageBox.Show (
			"This game uses Time without Loads (Game Time) as the main timing method.\n"+
			"LiveSplit is currently set to show Real Time (RTA).\n"+
			"Would you like to set the timing method to Game Time?",
			"LiveSplit | Red Ball",
			MessageBoxButtons.YesNo,MessageBoxIcon.Question
		);
		if (timingMessage == DialogResult.Yes)
		{
			timer.CurrentTimingMethod = TimingMethod.GameTime;
		}
	}
}

init {
    vars.frames = new MemoryWatcher<int>(new DeepPointer("Flash64_11_5_502_149.ocx", 0x125DE78, 0x90, 0x3F0, 0x10, 0x0, 0xA0));
    vars.freeze = new MemoryWatcher<int>(new DeepPointer("Flash64_11_5_502_149.ocx", 0x125DE78, 0x90, 0x3F0, 0x10, 0x0, 0x98));
    vars.path = new StringWatcher(new DeepPointer("Flash64_11_5_502_149.ocx", 0x11F42A8), 300);
    vars.openFrames = new MemoryWatcher<int>(new DeepPointer("Flash64_11_5_502_149.ocx", 0x125DE78, 0x1CC));
    
    vars.frames.FailAction = MemoryWatcher.ReadFailAction.SetZeroOrNull;
    vars.freeze.FailAction = MemoryWatcher.ReadFailAction.SetZeroOrNull;
    vars.path.FailAction = MemoryWatcher.ReadFailAction.SetZeroOrNull;
    vars.openFrames.FailAction = MemoryWatcher.ReadFailAction.SetZeroOrNull;

    vars.path.Update(game);

  if (vars.path.Current == "") throw new Exception(">>>>> Game Version has not been found yet!");

  vars.lastLevelSplit = 0;
  vars.prevGameTime = TimeSpan.FromSeconds(0);
  vars.split = false;
  vars.betweenGames = false;
  vars.gameSet = false;
  vars.gameName = "";
}

reset {
  if (!vars.betweenGames &&
    !vars.endLevels.Contains(vars.level.Old) &&
    (vars.level.Current == 0 && !vars.gameName.Contains("Red & Blue Balls")) ||
    (vars.frames.Old > 1 && vars.frames.Current <= 1)) {
      return true;
  }
}

split {
  if (vars.split) {
    vars.split = false;
    return true;
  }
}

gameTime {
  return vars.gameTime;
}

isLoading {
  return vars.betweenGames;
}

onReset {
  vars.prevGameTime = TimeSpan.FromSeconds(0);
  vars.gameTime = TimeSpan.FromSeconds(0);
  vars.lastLevelSplit = 0;
  vars.betweenGames = false;
}

update {
  vars.path.Update(game);
  vars.openFrames.Update(game);
  vars.frames.Update(game);
  vars.freeze.Update(game);
  if (!vars.gameSet || vars.openFrames.Current < vars.openFrames.Old) {
    vars.gameSet = false;
    if (vars.gameName != "" && vars.path.Old == vars.path.Current) { // If a game has previously been set, make sure the path has updated
      return false;
    }

    vars.endLevels = new List<int>();
    vars.freezes = new List<int>();
    
    String[] firstStringSplit = vars.path.Current.Split(new string[] { " - Tournament Edition" }, StringSplitOptions.None);
    String[] secondStringSplit = firstStringSplit[0].Split(new string[] { "\\" }, StringSplitOptions.None);
    vars.framerate = 30.0;
    refreshRate = 30;

    switch (secondStringSplit[secondStringSplit.Length - 1]) {
      case "Red Ball":
        vars.startLevels = new List<int>() { 1, 13 };
        vars.endLevels = new List<int>() { 12, 17 };
        vars.freezes = new List<int>() { 88, 311 };
        vars.framerate = 31.0;
        refreshRate = 31;
        vars.level = new MemoryWatcher<int>(new DeepPointer("Flash64_11_5_502_149.ocx", 0x125FBC0, 0xA0, 0x288, 0x40, 0x0, 0xAC));
        break;
      case "Red Ball 2":
        vars.startLevels = new List<int>() { 1, 21 };
        vars.endLevels = new List<int>() { 20, 25 };
        vars.freezes = new List<int>() { 46 };
        vars.level = new MemoryWatcher<int>(new DeepPointer("Flash64_11_5_502_149.ocx", 0x1279658, 0x198, 0x50, 0xD0, 0x180, 0xB4));
        break;
      case "Red Ball 3":
        vars.startLevels = new List<int>() { 1 };
        vars.endLevels = new List<int>() { 20 };
        vars.freezes = new List<int>() { 46 };
        vars.level = new MemoryWatcher<int>(new DeepPointer("Flash64_11_5_502_149.ocx", 0x125DE78, 0x90, 0x3F0, 0x18, 0x0, 0xB4));
        break;
      case "Red Ball 4 Vol.1":
      case "Red Ball 4 Vol.2":
      case "Red Ball 4 Vol.3":
        vars.startLevels = new List<int>() { 1 };
        vars.endLevels = new List<int>() { 15 };
        vars.freezes = new List<int>() { 90 };
        vars.level = new MemoryWatcher<int>(new DeepPointer("Flash64_11_5_502_149.ocx", 0x125DE78, 0x90, 0x3F0, 0x18, 0x0, 0xA0));
        break;
      case "Red & Blue Balls":
        vars.startLevels = new List<int>() { 1, 16 };
        vars.endLevels = new List<int>() { 15, 20 };
        vars.freezes = new List<int>() { 46 };
        vars.level = new MemoryWatcher<int>(new DeepPointer("Flash64_11_5_502_149.ocx", 0x1279658, 0x198, 0x50, 0xD0, 0x128, 0xB4));
        break;
      case "Red & Blue Balls 2":
      case "Red & Blue Balls 3":
        vars.startLevels = new List<int>() { 1, 26 };
        vars.endLevels = new List<int>() { -1 };
        vars.freezes = new List<int>() { 40 };
        vars.level = new MemoryWatcher<int>(new DeepPointer("Flash64_11_5_502_149.ocx", 0x12798C0, 0xAE0, 0xE8, 0x1A8, 0x120, 0xBC));
        break;
      default:
        return false;
        break;
    }
    vars.level.FailAction = MemoryWatcher.ReadFailAction.SetZeroOrNull;
    vars.gameName = secondStringSplit[secondStringSplit.Length - 1];
    vars.gameSet = true;

    if (!vars.betweenGames) {
      vars.lastLevelSplit = 0;
      vars.TimerModel.Reset();
      vars.prevGameTime = TimeSpan.FromSeconds(0);
    }
  }
  
  if (!vars.betweenGames && timer.CurrentPhase == TimerPhase.Running) {
    vars.adjustedFrames = vars.frames.Current;
    if (vars.lastLevelSplit != vars.level.Current && vars.freeze.Current != 0 && vars.freeze.Old == 0) {
      vars.lastLevelSplit = vars.level.Current;
      if (!settings["gameSplit"]) {
        vars.split = true;
      }

      if (vars.freeze.Current < 0) {
        vars.adjustedFrames = vars.frames.Current - (-1 - vars.freeze.Current);
      } else if (vars.freezes.Count > 1 && vars.freeze.Current > vars.freezes[0]) {
        vars.adjustedFrames = vars.frames.Current - (vars.freezes[1] - vars.freeze.Current);
      } else {
        vars.adjustedFrames = vars.frames.Current - (vars.freezes[0] - vars.freeze.Current);
      }

      if ((settings["fsAny"] && vars.level.Current == vars.endLevels[0])
        || (vars.level.Current == vars.endLevels[vars.endLevels.Count - 1])
        || (vars.endLevels[0] == -1 && vars.freeze.Current < 0)) { // rabb 2/3
        vars.split = true;
        vars.betweenGames = true;
        vars.lastLevelSplit = 0;
      }
    }

    vars.gameTime = vars.prevGameTime + TimeSpan.FromSeconds(vars.adjustedFrames / vars.framerate);
    if (vars.betweenGames) {
      vars.prevGameTime += TimeSpan.FromSeconds(vars.adjustedFrames / vars.framerate);
    }
  }
  
  vars.level.Update(game);

  if ((vars.startLevels.Contains(vars.level.Current) || settings["anyStart"]) &&
    ((vars.frames.Current < vars.frames.Old && vars.frames.Current > 0) ||
    (vars.frames.Current > 1 && vars.frames.Old <= 1))) { // Started timer in level 1
    
    vars.betweenGames = false;
    vars.TimerModel.Start();
  }

  if (vars.debug) {
    print("[RB ASL] Current Frames: " + vars.frames.Current + 
    "\n[RB ASL] Current Freeze: " + vars.freeze.Current +
    "\n[RB ASL] Current Level: " + vars.level.Current +
    "\n[RB ASL] Game Set: " + vars.gameSet +
    "\n[RB ASL] Game Name: " + vars.gameName +
    "\n[RB ASL] Between Games?: " + vars.betweenGames +
    "\n[RB ASL] Open Frames: " + vars.openFrames.Current + 
    "\n[RB ASL] Previous Game Time: " + vars.prevGameTime.ToString() +
    "\n[RB ASL] Overall Game Time: " + vars.gameTime.ToString() +
    "\n[RB ASL] Last Level Split: " + vars.lastLevelSplit +
    "\n[RB ASL] Frame Rate: " + vars.framerate);
  }
}
