state("Pineapple-Win64-Shipping")
{
  bool isLoading: "Pineapple-Win64-Shipping.exe", 0x0338B8D0, 0x20, 0x1A0;
  int spatCount: "Pineapple-Win64-Shipping.exe", 0x03487038, 0x8, 0x6E0;
  string100  map: "Pineapple-Win64-Shipping.exe", 0x3488090, 0x8A8, 0x0;
}

startup
{
	vars.newRun = true;
	vars.startOffset = 137f/60f;

	vars.mainMenuName = "/Game/Maps/IntroCutscene/IntroCutscene_P";
	vars.finalLevel = "/Game/Maps/ChumBucketLab/Part3/ChumBucketLab_03_P";
}

gameTime
{
	if (vars.newRun)
	{
		vars.newRun = false;
		return TimeSpan.FromSeconds(vars.startOffset);
	}
}

start
{
	if(!old.isLoading && current.isLoading && current.map == vars.mainMenuName)
	{
		vars.newRun = true;
		return true;
	}
}

isLoading
{
	return current.isLoading;
}

split
{
	return old.spatCount != current.spatCount && current.map == vars.finalLevel;
}