state("Flash Player"){
  int level : "Flash Player.exe", 0x10157D0, 0xA60, 0x2A0, 0x8, 0x50, 0x60, 0xC4;
}

split {
	return (old.level == current.level -1 || old.level == 50 && current.level == 0);
}

start {
	return old.level == 0 && current.level == 26;
}

reset {
	return old.level != 0 && old.level != 50 && current.level == 0;
}



