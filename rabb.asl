state("Flash Player"){
  int level : "Flash Player.exe", 0x100B038, 0x310, 0x1F8, 0x130, 0xBC;
  int win : "Flash Player.exe", 0x100B038, 0xCE8, 0xE8, 0xC0, 0xC08, 0x20, 0x48;
}

startup {vars.lastLevelSplit = 0;}

split {
	if(vars.lastLevelSplit != current.level && old.win == 2 && current.win == 1) {
		vars.lastLevelSplit = current.level;
		return true;
	}
}

start {
	if(current.level == 1 && current.win == 2) {
		vars.lastLevelSplit = 0;
		return true;
	}
}

reset {
	if(current.level != 16 && current.level != 21 && old.win != 0 && current.win == 0) {
		vars.lastLevelSplit = 0;
		return true;
	}
}

