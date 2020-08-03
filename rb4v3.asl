state("Flash Player"){
  int level : "Flash Player.exe", 0x1012930, 0x50, 0x450, 0xA0, 0x0, 0xA8;
  int health : "Flash Player.exe", 0x100B038, 0x310, 0x140, 0x20, 0xD8, 0x1C8, 0x12C;
}

split {
	return (current.level == old.level + 1) || (old.health == 1076101120 && current.health == 0);
}

start {
	return old.level == 0 && current.level == 1;
}

reset {
	return old.level != 0 && current.level == 0;
}



