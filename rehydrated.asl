state("Pineapple-Win64-Shipping"){
  int isloading : "Pineapple-Win64-Shipping.exe", 0x33446F8, 0xB8, 0x300, 0xD0;
}

isLoading{return current.isloading == -1;}

start{return (old.isloading == 1 || old.isloading == 0) && current.isloading == -1;}
