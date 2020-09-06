state("Flash Player", "Red Ball") {
  int level       : 0x100BE08, 0x1F8, 0x140, 0x0, 0xB4;
  bool win        : 0x100BE08, 0x1F8, 0x140, 0x0, 0xE0, 0xB8;
  bool accelRight : 0x100BE08, 0x1F8, 0x140, 0x0, 0xE0, 0xD4;
  string300 file  : 0x1015861;
}

state("Flash Player", "Red Ball 2"){
  int level       : 0x100B038, 0x310, 0x1F8, 0x188, 0xE0, 0xD8, 0xBC;
  bool win        : 0x100B038, 0x310, 0x1F8, 0x188, 0x108, 0xCC;
  bool accelRight : 0x100B038, 0x310, 0x1F8, 0x188, 0x108, 0xC8;
  string300 file  : 0x1015861;
}

state("Flash Player", "Red Ball 3") {
  int level      : 0x1012CD8, 0x78, 0x160, 0x0, 0xBC;
  bool win       : 0x1012CD8, 0x78, 0x160, 0x0, 0xC8, 0xC0;
  string300 file : 0x1015861;
}

state("Flash Player", "Red Ball 4 Vol.1") {
  int cp           : 0x100B038, 0x268, 0x1A0, 0x28, 0x1B8, 0x20, 0x60;
  int level        : 0x1012CD8, 0x78, 0x160, 0x0, 0xA8;
  float bossHealth : 0x1012CD8, 0x78, 0x160, 0x0, 0xC8, 0x180, 0x11C;
  string300 file   : 0x1015861;
}

state("Flash Player", "Red Ball 4 Vol.2") {
  int cp           : 0x100B038, 0x268, 0x1A0, 0x28, 0xD0, 0x20, 0x84;
  int level        : 0x1012CD8, 0x78, 0x160, 0x0, 0xA8;
  float bossHealth : 0x1012CD8, 0x78, 0x160, 0x0, 0xC8, 0x188, 0x124;
  string300 file   : 0x1015861;
}

state("Flash Player", "Red Ball 4 Vol.3") {
  int cp           : 0x100B038, 0x268, 0x1A0, 0x28, 0x90, 0x20, 0xB0;
  int level        : 0x1012CD8, 0x78, 0x160, 0x0, 0xA8;
  float bossHealth : 0x1012CD8, 0x78, 0x160, 0x0, 0xC8, 0x1C8, 0x12C;
  string300 file   : 0x1015861;
}

state("Flash Player", "Red Ball 5") {
  int level          : 0x100B038, 0x310, 0x3B8, 0xB0, 0xB0;
  int starsForUnlock : 0x100B038, 0x310, 0x3B8, 0xB0, 0x90, 0x160, 0x194;
  byte1 win          : 0x100B038, 0x310, 0x578, 0x420, 0x158, 0x198;
  double completion  : 0x1011C88, 0x50, 0xA0;
  string300 file     : 0x1015861;
}

state("Flash Player", "Red&Blue Balls") {
  int level      : 0x100B038, 0x310, 0x1F8, 0x130, 0xBC;
  int gems       : 0x100B038, 0x310, 0x1F8, 0x130, 0xF0, 0xC8;
  double score   : 0x100B038, 0x310, 0x1F8, 0x130, 0xF0, 0x180;
  int quit       : 0x100B038, 0xCE8, 0xE8, 0xC0, 0xC08, 0x20, 0x48;
  string300 file : 0x1015861;
}

state("Flash Player", "Red&Blue Balls 2") {
  int level      : 0x10157D0, 0xA60, 0x2A0, 0x8, 0x50, 0x60, 0xC4;
  int progress   : 0x10157D0, 0xA30, 0xCA0, 0x8, 0x140;
  string300 file : 0x1015861;
}

state("Flash Player", "Red&Blue Balls 3") {
  int level      : 0x10157D0, 0xA60, 0x2A0, 0x8, 0x50, 0x60, 0xC4;
  int progress   : 0x10157D0, 0xA30, 0xCA0, 0x8, 0x140;
  string300 file : 0x1015861;
}

startup {
  vars.timerModel = new TimerModel { CurrentState = timer };
  vars.redBall1to3 = new List<string>() { "Red Ball", "Red Ball 2", "Red Ball 3" };
  vars.redBall4 = new List<string>() { "Red Ball 4 Vol.1", "Red Ball 4 Vol.2", "Red Ball 4 Vol.3" };
  vars.redAndBlue2and3 = new List<string>() { "Red&Blue Balls 2", "Red&Blue Balls 3" };

  settings.Add("rb4cpSplits", false, "Red Ball 4: split on every checkpoint (includes mid-point of boss fight)");
  settings.Add("rb5Exit", false, "Red Ball 5: split after unlocking the level exit");
  settings.Add("rb5100%", false, "Red Ball 5: split when collecting the last star of a level");
}

init {
  if (current.file == "") throw new Exception(">>>>> Game Version has not been found yet!");

  vars.lastLevelSplit = 0;
  vars.relevantLevels = new List<int>();
  
  // gets the full file path and splits at backslashes
  vars.firstStringSplit = current.file.Split(new string[] { "\\" }, StringSplitOptions.None);
  // gets the path after final backslash and splits the rest at " - Definitive Edition.swf"
  vars.secondStringSplit = vars.firstStringSplit[vars.firstStringSplit.Length - 1].Split(new string[] { " - Definitive Edition.swf" }, StringSplitOptions.None);
  // sets the string between final backslash and " - Definitive Edition.swf" as the version
  version = vars.secondStringSplit[0];

  switch (version) {
    case "Red Ball":
      vars.relevantLevels = new List<int>() { 12, 17 };
      break;
    case "Red Ball 2":
      vars.relevantLevels = new List<int>() { 20, 25 };
      break;
    case "Red Ball 3":
      vars.relevantLevels = new List<int>() { 20 };
      break;
    case "Red&Blue Balls":
      vars.relevantLevels = new List<int>() { 16, 21 };
      break;
    case "Red&Blue Balls 2":
      vars.relevantLevels = new List<int>() { 1 };
      break;
    case "Red&Blue Balls 3":
      vars.relevantLevels = new List<int>() { 26 };
      break;
    case "Red Ball 5":
      vars.nullUpdateCount = 0;
      vars.runActive = false;
      break;
    default:
      break;
  }

  //print(">>>>> " + current.file);
  //print(">>>>> " + vars.secondStringSplit[0]);
}

update {
  if (version == "Red Ball 5" && current.win == null && vars.runActive) { // checks game for Red Ball 5 and if win is null and runActive is true
    vars.nullUpdateCount++;                                               // increases nullUpdateCount by 1 every frame
  }
}

exit {
    if (timer.CurrentPhase != TimerPhase.Ended) {
        vars.timerModel.Reset();
    }
}

start {
  if (version == "Red Ball" || version == "Red Ball 2") {               // checks game for Red Ball 1 or 2
    vars.lastLevelSplit = 0;                                            //
    return current.level == 1 && !old.accelRight && current.accelRight; // starts when player is in level 1 and begins moving right
  } else if (version == "Red Ball 3" || vars.redBall4.Contains(version)) { // checks game for Red Ball 3 or 4 Vol. 1 through 3
    vars.lastLevelSplit = 0;                                               //
    return old.level == 0 && current.level == 1;                           // starts when player loads level 1
  } else if (version == "Red Ball 5" && old.win == null && current.win != null) { // checks game for Red Ball 5 and if win changed from null to a value (when player enters a level)
    vars.runActive = true;                                                        // set runActive to true
    vars.lastLevelSplit = 0;
    return true;
  } else if (version == "Red&Blue Balls") {                         // checks game for Red & Blue Balls 1
    vars.lastLevelSplit = 0;                                        //
    return current.level == 1 && Math.Round(current.score) == 1000; // starts when player is in level 1 and score rounds to 1000 (when player restarts level)
  } else if (vars.redAndBlue2and3.Contains(version)) {                    // checks game for Red & Blue Balls 2 or 3
    return old.level == 0 && vars.relevantLevels.Contains(current.level); // starts when player loads level 1 for R&BB1 or 26 for R&BB2
  }
}

split {
  if (vars.lastLevelSplit != current.level && vars.redBall1to3.Contains(version)) { // checks game for Red Ball 1 through 3
    if (!old.win && current.win) {                                                  // splits when win turns from false into true
      vars.lastLevelSplit = current.level;
      return true;
    }
  } else if (vars.redBall4.Contains(version)) {              // checks game for Red Ball 4 Vol. 1 through 3
    return                                                   //
      current.level == old.level + 1 ||                      // splits when level increases by 1 
      old.bossHealth == 2.5625 && current.bossHealth == 0 || // splits when when boss is defeated
      current.cp == old.cp + 1 && settings["rb4cpSplits"];   // splits when number of checkpoints increases by 1 and the corresponding setting is on
  } else if (vars.lastLevelSplit != current.level && version == "Red Ball 5" && old.win != null && current.win != null) { // checks game for Red Ball 5 and if win isn't null (throws error otherwise, harmless but best avoided)
    if (old.win[0] == 0 && current.win[0] == 1) {                                                                         // splits when player finishes a level
      vars.lastLevelSplit = current.level;                                                                                //
      return true;                                                                                                        //
    } else if (current.level != 1 && old.starsForUnlock == 1 && current.starsForUnlock == 0 && settings["rb5Exit"] ||     // splits when player unlocks level exit and the corresponding setting is on (except in level 1)
               old.completion != current.completion && Math.Round(current.completion) == 100 && settings["rb5100%"]) {    // splits when player collects final star of level and the corresponding setting is on
      return true;
    }
  } else if (vars.lastLevelSplit != current.level && version == "Red&Blue Balls") { // checks game for Red & Blue Balls 1
    if (old.gems == 1 && current.gems == 2) {                                       // splits when number of gems collected changes from 1 to 2
      vars.lastLevelSplit = current.level;
      return old.gems == 1 && current.gems == 2;
    }
  } else if (vars.redAndBlue2and3.Contains(version)) { // checks game for Red & Blue Balls 2 or 3
    return current.progress == old.progress + 1;       // splits when number of unlocked levels increases by 1
  }
}

reset {
  if (vars.redBall1to3.Contains(version)) {                                // checks game for Red Ball 1 through 3
    return current.level == 0 && !vars.relevantLevels.Contains(old.level); // resets when player enters main menu from any level except 12/17 for RB1, 20/25 for RB2 and 20 for RB3
  } else if (vars.redBall4.Contains(version)) {  // checks game for Red Ball 4 Vol. 1 through 3
    return old.level != 0 && current.level == 0; // resets when player enters main menu
  } else if (version == "Red Ball 5" && vars.runActive && vars.nullUpdateCount > 30) { // checks game for Red Ball 5 and if runActive is true and nullUpdateCount has exceeded 30 frames (0.5s)
    vars.nullUpdateCount = 0;                                                          // reset nullUpdateCount to 0
    vars.runActive = false;                                                            // set runActive to false
    return true;
  } else if (version == "Red&Blue Balls") {                                                                                                       // checks game for Red & Blue Balls 1
    return !vars.relevantLevels.Contains(current.level) && old.quit != 0 && current.quit == 0 || current.level == 1 && current.score > old.score; // resets when player enters main menu from any level except 16/21 or restarts level 1 
  } else if (vars.redAndBlue2and3.Contains(version)) {                                                       // checks game for Red & Blue Balls 2 or 3
    return old.progress > current.progress || vars.relevantLevels.Contains(old.level) && current.level == 0; // resets when number of unlocked levels decreases or when player enters main menu from level 1 for R&BB1 or 26 for R&BB2
  }
}
