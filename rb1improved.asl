state("Flash Player"){
  int frames : "Flash Player.exe", 0x100B038, 0x2D8, 0x4C8, 0x10, 0x0, 0xA8;
  int freeze : "Flash Player.exe", 0x100B038, 0x2D8, 0x4C8, 0x10, 0x0, 0xA0;
  int level : "Flash Player.exe", 0x1012930, 0x58, 0x38, 0x70, 0x0, 0xB4;
}

startup {
	refreshRate = 31;
    vars.split = false;
    vars.gameTime = TimeSpan.FromSeconds(0);
    vars.debug = false;
	if (timer.CurrentTimingMethod == TimingMethod.RealTime)
	{        
		var timingMessage = MessageBox.Show (
			"This game uses Time without Loads (Game Time) as the main timing method.\n"+
			"LiveSplit is currently set to show Real Time (RTA).\n"+
			"Would you like to set the timing method to Game Time?",
			"LiveSplit | Geometry Dash",
			MessageBoxButtons.YesNo,MessageBoxIcon.Question
		);
		if (timingMessage == DialogResult.Yes)
		{
			timer.CurrentTimingMethod = TimingMethod.GameTime;
		}
	}
}

split {
    if (vars.split) {
        vars.split = false;
        return true;
    }
}

start {
	return current.level == 1 && current.frames > 0 && old.frames == 0;
}

gameTime {
    return vars.gameTime;
}

reset {
    if (old.level != 12 && old.level != 17 && current.level == 0) {
        return true;
    }
    
    if (old.frames > 0 && current.frames == 0) {
        return true;
    }
}

update {
    int adjustedFrames = current.frames;
    if (current.freeze > 0 && old.freeze == 0) {
        vars.split = true;
        if (current.freeze > 87) { // Level 12 or 17
            adjustedFrames = current.frames - (310 - current.freeze);
        } else { // other levels
            adjustedFrames = current.frames - (87 - current.freeze);
        }
    }
    vars.gameTime = TimeSpan.FromSeconds(adjustedFrames / 31.0);
    
    if (vars.debug) {
        print("[RB1 ASL] Current Frames: " + current.frames + 
        "\n[RB1 ASL] Current Freeze " + current.freeze);
    }
}