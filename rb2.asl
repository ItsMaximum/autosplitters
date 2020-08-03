state("Flash Player"){
  int level : "Flash Player.exe", 0x100B038, 0x6C8, 0x50, 0x1A8, 0x1D8, 0x18, 0xD8, 0xBC;
  bool win : "Flash Player.exe", 0x100B038, 0x310, 0x1F8, 0x188, 0x108, 0xCC;
  bool right : "Flash Player.exe", 0x100B038, 0x310, 0x1F8, 0x188, 0x108, 0xC8;
}

startup {vars.lastLevelSplit = 0;}

split {
	if(vars.lastLevelSplit != current.level && old.win == false && current.win == true) {
		vars.lastLevelSplit = current.level;
		return true;
	}
}

start {
	if(current.level == 1 && current.right == true) {
		vars.lastLevelSplit = 0;
		return true;
	}
}

reset {
	if(old.level != 20 && old.level != 25 && old.level != 0 && current.level == 0) {
		vars.lastLevelSplit = 0;
		return true;
	}
}

