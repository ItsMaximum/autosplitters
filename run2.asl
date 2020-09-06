state("flashplayer11_2r202_233_win_sa_32bit", "Adobe Flash Player 11") {
  int level   : 0x742E8C, 0x3F0, 0xF4, 0x60;
  double velZ : 0x742A8C, 0x28, 0x184, 0x90;
}

state("Flash Player", "Adobe Flash Player 30") {
  int level   : 0x100B038, 0x310, 0x1F8, 0xBC;
  double velZ : 0x1011C90, 0x118, 0xD8, 0x140, 0xA8;
}

state("Flash Player", "Adobe Flash Player 32") {
  int level   : 0xC951F8, 0x118, 0xFC, 0x64;
  double velZ : 0xC9AAD8, 0xE5C, 0x4, 0x244, 0x214, 0x90;
}

init {
  //print(modules.First().ModuleMemorySize.ToString());

  switch (modules.First().ModuleMemorySize) {
    case 9011200:
      version = "Adobe Flash Player 11";
      break;
    case 20406272:
      version = "Adobe Flash Player 30";
      break;
    case 16441344:
      version = "Adobe Flash Player 32";
      break;
    default:
      print(">>>>> This version of Flash Player is not supported by the auto splitter!");
      break;
  }
}

start {
  return old.velZ == 0.0 && current.velZ != 0.0;
}

split {
  return old.level != current.level && old.velZ != 0.0;
}

reset {
  return old.velZ != 0.0 && current.velZ == 0.0;
}
