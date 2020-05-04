state("GeometryDash"){
  bool isloading : "fmod.dll", 0x158504, 0x34, 0xC0, 0xC;
  int endlevel : "GeometryDash.exe", 0x3222D0, 0x164, 0x3C0, 0x12C;
}

isLoading{return current.isloading;}


split{return old.endlevel != current.endlevel && current.endlevel == 623915057;}

start{return old.isloading && !current.isloading;} 