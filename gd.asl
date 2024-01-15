state("GeometryDash", "2.11"){
  bool loadingMusic : "GeometryDash.exe", 0x3222A8, 0x128, 0x34, 0xC0, 0xC;
  string3 percentage : "GeometryDash.exe", 0x3222D0, 0x164, 0x124, 0xEC, 0x2A4, 0xE8, 0x8, 0x12C;
  float position : "GeometryDash.exe", 0x3222D0, 0x164, 0x124, 0xEC, 0x108, 0xE8, 0x8, 0x67C;
  int scene : "GeometryDash.exe", 0x3222D0, 0x1DC;
}

state("GeometryDash", "2.2"){
  bool loadingMusic : "GeometryDash.exe", 0x4E82C0, 0x128, 0x0, 0x0, 0x40;
  //string3 percentage : "GeometryDash.exe", 0x4E82E8, 0x198, 0x2E30, 0x148;
  float position : "GeometryDash.exe", 0x4E82E8, 0x1A0, 0x870, 0x81C;
  int scene : "GeometryDash.exe", 0x4E82E8, 0x21C;
  double timer : "GeometryDash.exe", 0x4E82E8, 0x198, 0x2C18;
  bool levelComplete : "GeometryDash.exe", 0x4E82E8, 0x198, 0x2C20;
}

state("GeometryDash", "2.202"){
  bool loadingMusic : "GeometryDash.exe", 0x4ED2E8, 0x128, 0x0, 0x0, 0x40;
  float position : "GeometryDash.exe", 0x4ED310, 0x198, 0x878, 0x834;
  int scene : "GeometryDash.exe", 0x4ED310, 0x21C;
  double timer : "GeometryDash.exe", 0x4ED310, 0x198, 0x2C20;
  bool levelComplete : "GeometryDash.exe", 0x4ED310, 0x198, 0x2C28;
}

state("GeometryDash", "2.203"){
  bool loadingMusic : "GeometryDash.exe", 0x4F0308, 0x128, 0x0, 0x0, 0x40;
  float position : "GeometryDash.exe", 0x4F0330, 0x198, 0x878, 0x834;
  int scene : "GeometryDash.exe", 0x4F0330, 0x21C;
  double timer : "GeometryDash.exe", 0x4F0330, 0x198, 0x2C20;
  bool levelComplete : "GeometryDash.exe", 0x4F0330, 0x198, 0x2C28;
}

state("GeometryDash", "2.204"){
  bool loadingMusic : "GeometryDash.exe", 0x4F0308, 0x128, 0x0, 0x0, 0x40;
  float position : "GeometryDash.exe", 0x4F0330, 0x198, 0x878, 0x48;
  int scene : "GeometryDash.exe", 0x4F0330, 0x21C;
  double timer : "GeometryDash.exe", 0x4F0330, 0x198, 0x2C20;
  bool levelComplete : "GeometryDash.exe", 0x4F0330, 0x198, 0x2C28;
}

startup {
	vars.loadingLevel = false;
    vars.debug = false;
	vars.totalTime = 0d;
	refreshRate = 60;
    vars.stopwatch = new Stopwatch();
	settings.Add("classic", false, "Classic Mode");
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

init
{
	int moduleSize = modules.First().ModuleMemorySize;
	print("[GD ASL] Main Module Size: "+moduleSize.ToString());
	if (moduleSize == 6873088) {
		version = "2.11";
	} else if (moduleSize == 8884224) {
		version = "2.2";
	} else if (moduleSize == 8904704) {
        version = "2.202";
    } else if (moduleSize == 8921088) {
        version = "2.204";
    } else {
		version = "Unsupported: " + moduleSize.ToString();
		MessageBox.Show("This game version is currently not supported.", "LiveSplit Auto Splitter - Unsupported Game Version");
	}
}

onStart {
	vars.totalTime = 0d;
}

isLoading { 
	if (settings["classic"] || version == "2.11") {
        if (!old.loadingMusic && current.loadingMusic) {
            vars.loadingLevel = !vars.loadingLevel;
		}
        
		if (current.scene == 0) {
			vars.loadingLevel = false;
		}

		if (version == "2.11") {
			if (old.position == 0 && current.position != 0) {
				vars.loadingLevel = false;
			}
		} else {
			if (old.timer == 0 && current.timer != 0) {
				vars.loadingLevel = false;
			}
		}
        
		return vars.loadingLevel;
	} else {
		return true;
	}
}

gameTime {
	if (!settings["classic"] && version != "2.11") {
		if (old.timer > current.timer) {
			vars.totalTime += old.timer;
		}
		return TimeSpan.FromSeconds(vars.totalTime + current.timer);
	}
}

reset {
	if (!settings["classic"] && version != "2.11") {
		if (old.timer > current.timer && timer.CurrentSplitIndex == 0) {
			return true;
		}
	}
}

split {
	if (settings["classic"] || version == "2.11") {
        if (version == "2.11") {
            return old.percentage != current.percentage && current.percentage == "100";
        }
        
        if (!old.levelComplete && current.levelComplete) {
            vars.stopwatch.Start();
        }
        
        if (vars.stopwatch.Elapsed.TotalMilliseconds >= 983) {
            vars.stopwatch.Reset();
            return true;
        }
	} else {
		return !old.levelComplete && current.levelComplete;
	}
}

start {
	if (settings["classic"] || version == "2.11") {
		return old.position == 0 && current.position != 0;
	} else {
		return old.timer == 0 && current.timer != 0;
	}
}

update {
	if (version.Contains("Unsupported")) {
		return false;
	}
    
    if (vars.debug) {
        print("[GD ASL] Player Position: " + current.position.ToString() +
        "\n[GD ASL] Loading Music ? " + current.loadingMusic.ToString() +
        "\n[GD ASL] Loading Level ? " + vars.loadingLevel.ToString() +
        "\n[GD ASL] Current Timer: " + current.timer.ToString() +
        "\n[GD ASL] Total Time: " + vars.totalTime.ToString());
    }
}