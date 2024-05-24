{ inputs, lib, pkgs, config, outputs, ... }: {
  imports = [
    #################### Required Configs ####################
    common/core # required

    #################### Host-specific Optional Configs ####################
    common/optional/desktops
    common/optional/browsers
    common/optional/academia
    common/optional/dev
    common/optional/media
    common/optional/tools
    common/optional/comms
  ];

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    # name = "macOS-BigSur-White";
    name = "macOS-BigSur";
    package = pkgs.apple-cursor;
    #   package = pkgs.bibata-cursors;
    #   name = "Bibata-Modern-Ice";
  };
}
