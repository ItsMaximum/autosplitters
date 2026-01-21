// scene is 0 on main menu, 1 in gauntlets, 8 in main level menu, etc.

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

state("GeometryDash", "2.206"){
  bool loadingMusic : "GeometryDash.exe", 0x687DC0, 0x198, 0x18, 0x30, 0x138;
  float position : "GeometryDash.exe", 0x687E10, 0x208, 0xD98, 0xA90;
  int scene : "GeometryDash.exe", 0x687E10, 0x2BC;
  double timer : "GeometryDash.exe", 0x687E10, 0x208, 0x3488;
  bool levelComplete : "GeometryDash.exe", 0x687E10, 0x208, 0x3490;
}

state("GeometryDash", "2.207"){
	bool loadingMusic : "GeometryDash.exe", 0x6A4E18, 0x198, 0x70, 0x0, 0x5C;
	float position : "GeometryDash.exe", 0x6A4E68, 0x208, 0xD98, 0x4C;
	int scene : "GeometryDash.exe", 0x6A4E68, 0x2BC;
	double timer : "GeometryDash.exe", 0x6A4E68, 0x208, 0x3C8;
	bool levelComplete : "GeometryDash.exe", 0x6A4E68, 0x208, 0x3490;
	float timewarp : "GeometryDash.exe", 0x6A4E68, 0x100, 0x38;
}

state("GeometryDash", "2.208"){
	bool loadingMusic : "GeometryDash.exe", 0x6C1E88, 0x230, 0x90, 0x118, 0x18;
	float position : "GeometryDash.exe", 0x6C1ED8, 0x208, 0xDA0, 0x4C;
	int scene : "GeometryDash.exe", 0x6C1ED8, 0x2BC;
	double timer : "GeometryDash.exe", 0x6C1ED8, 0x208, 0x3D0;
	bool levelComplete : "GeometryDash.exe", 0x6C1ED8, 0x208, 0x3570;
	float timewarp : "GeometryDash.exe", 0x6C1ED8, 0x100, 0x38;
}

state("GeometryDash", "2.2081"){
	bool loadingMusic : "GeometryDash.exe", 0x6C2E88, 0x230, 0x90, 0x118, 0x18;
	float position : "GeometryDash.exe", 0x6C2ED8, 0x208, 0xDA0, 0x4C;
	int scene : "GeometryDash.exe", 0x6C2ED8, 0x2BC;
	double timer : "GeometryDash.exe", 0x6C2ED8, 0x208, 0x3D0;
	bool levelComplete : "GeometryDash.exe", 0x6C2ED8, 0x208, 0x3570;
	float timewarp : "GeometryDash.exe", 0x6C2ED8, 0x100, 0x38;
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
	} else if (moduleSize == 10473472) {
		version = "2.206";
	} else if (moduleSize == 10600448) {
		version = "2.207";
	} else if (moduleSize == 10719232) {
		version = "2.208";
    } else if (moduleSize == 10723328) {
		version = "2.2081";
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

		// approximate quadratic curve, covers 1.00-2.00x timewarp cases
		vars.msToWait = (0.457143 * current.timewarp * current.timewarp - 1.85143 * current.timewarp + 2.37762) * 1000;
        
        if (vars.stopwatch.Elapsed.TotalMilliseconds >= vars.msToWait) {
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
        "\n[GD ASL] Total Time: " + vars.totalTime.ToString() +
        "\n[GD ASL] Classic Mode: " + settings["classic"].ToString() +
		"\n[GD ASL] Timewarp: " + current.timewarp.ToString());
    }
}