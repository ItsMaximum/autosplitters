state("Pineapple-Win64-Shipping")
{
  bool isLoading: "Pineapple-Win64-Shipping.exe", 0x0338B8D0, 0x20, 0x1A0;
}

isLoading
{
    return current.isLoading;
}

start
{
    return !old.isLoading && current.isLoading;
}
