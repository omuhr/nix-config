{ pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellApplication {
      name = "hyprpickertoclip";
      runtimeInputs = with pkgs; [ hyprpicker wl-clipboard ];
      text = ''
        hyprpicker | wl-copy
      '';
    })
  ];
}
