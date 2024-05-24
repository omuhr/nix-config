{ pkgs, lib, ... }: {
  home.packages = [ pkgs.hyprpaper ];
  xdg.configFile.hyprpaper = {
    source = ./config;
    recursive = true;
  };
}
