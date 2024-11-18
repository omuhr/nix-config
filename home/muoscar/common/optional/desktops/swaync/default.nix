{ pkgs, ... }: {
  home.packages = [ pkgs.unstable.swaynotificationcenter ];
  xdg.configFile.swaync = {
    source = ./config;
    recursive = true;
  };
}
