state("Flash Player"){
  int level : "Flash Player.exe", 0x100B038, 0x2D8, 0x4C8, 0x10, 0x0, 0xBC;
  bool win : "Flash Player.exe", 0x100B038, 0x2D8, 0x4B8, 0x40, 0x0, 0xC8, 0xC0;
}

startup {vars.lastLevelSplit = 0;}

split {
	if(vars.lastLevelSplit != current.level && old.win == false && current.win == true) {
		vars.lastLevelSplit = current.level;
		return true;
	}
}

start {
	if(old.level == 0 && current.level == 1) {
		vars.lastLevelSplit = 0;
		return true;
	}
}

reset {
	if(old.level != 0 && old.level != 20 && current.level == 0) {
		vars.lastLevelSplit = 0;
		return true;
	}
}

