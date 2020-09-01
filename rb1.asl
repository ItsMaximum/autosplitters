state("Flash Player"){
  int level : "Flash Player.exe", 0x1012930, 0x58, 0x38, 0x70, 0x0, 0xB4;
  bool win : "Flash Player.exe", 0x1012CD8, 0x78, 0xA0, 0x0, 0xE0, 0xB8;
  bool right : "Flash Player.exe", 0x1012CD8, 0x78, 0x70, 0x0, 0xE0, 0xD4;
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
	if(old.level != 12 && old.level != 17 && current.level == 0) {
		vars.lastLevelSplit = 0;
		return true;
	}
}

update {
	print("[RB1 ASL] Current Level: " + current.level + 
	"\n[RB1 ASL] Last Level Split On: " + vars.lastLevelSplit +
	"\n[RB1 ASL] Holding Right? " + current.right +
	"\n[RB1 ASL] Flag Animation? " + current.win);
}
