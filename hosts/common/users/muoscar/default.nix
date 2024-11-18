{ pkgs, inputs, config, ... }:
let
  ifTheyExist = groups:
    builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.users.muoscar = {
    isNormalUser = true;
    shell = pkgs.zsh; # default shell
    extraGroups = [
      "wheel"
      "audio"
      "video"
      "input"
      "dialout"
    ] # Input gives waybar the access it needs
      ++ ifTheyExist [ "docker" "git" "mysql" "network" ];

    packages = [ pkgs.home-manager ];
  };

  # FIXME This should probably be host specific. Also need to confirm that this is the correct place to do this.
  security.sudo.extraConfig = ''
    Defaults timestamp_timeout=120 # only ask for password every 120 minutes
  '';

  # Import this user's personal/home configurations
  # home-manager.users.muoscar =
  #   import ../../../../home/muoscar/${config.networking.hostName}.nix;

}
