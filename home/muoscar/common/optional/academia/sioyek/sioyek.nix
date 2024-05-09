{
  programs.sioyek = { enable = true; };
  xdg.configFile.sioyek = {
    source = ./config;
    recursive = true;
  };
}
