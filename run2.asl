state("Flash Player"){
  int levelID : "Flash Player.exe", 0xC951F8, 0x118, 0xFC, 0x64;
  double zVelocity : "Flash Player.exe", 0xC951F8, 0x310, 0x2C, 0x7C4, 0x144, 0x10, 0x64, 0x90;
}


split{return old.levelID != current.levelID && old.zVelocity != 0;}

start{return old.zVelocity == 0 && current.zVelocity != 0;} 