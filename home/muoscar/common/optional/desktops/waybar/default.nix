{ pkgs, ... }: {
  programs.waybar = {
    enable = true;
    # systemd.enable = true;
    package = (pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    }));
  };
  xdg.configFile.waybar = {
    source = ./config;
    recursive = true;
  };
}
