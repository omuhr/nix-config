{ pkgs, ... }: {
  programs.ags = {
    enable = true;
    # configDir = ./config;
  };
  # xdg.configFile.waybar = {
  #   source = ./config;
  #   recursive = true;
  # };
}
