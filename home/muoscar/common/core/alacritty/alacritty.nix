{ pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    package = pkgs.unstable.alacritty;
  };
  xdg.configFile.alacritty = {
    source = ./config;
    recursive = true;
  };
}
