state("Flash Player"){
  int win : "Flash Player.exe", 0x10157D0, 0xA50, 0x920, 0x8, 0x218, 0x198;
  byte1 winByte : "Flash Player.exe", 0x10157D0, 0xA50, 0x920, 0x8, 0x218, 0x198;
}

startup {
	vars.nullUpdateCount = 0;
	vars.runActive = false;
}

split {
	return old.win == 0 && current.win == 1;
}

start {
	if (old.winByte == null && current.winByte != null) {
		vars.runActive = true;
		return true;
	}
}

reset {
	if(vars.nullUpdateCount > 30) {
		vars.runActive = false;
		return true;
	}
}

update {
	if(current.winByte == null && vars.runActive) {
		vars.nullUpdateCount++;
	}
}



