# #################################
#                                #
#  Feynman - Work Thinkpad P43s  #
#  NixOS running on work laptop  #
#                                #
##################################

{ inputs, ... }: {
  imports = [
    #################### Hardware Modules ####################
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    #################### Required Configs ####################
    ../common/core
    ./hardware-configuration.nix

    #################### Host-specific Optional Configs ####################

    # ../common/optional/services/greetd.nix # display manager
    ../common/optional/gnome.nix # window manager
    ../common/optional/hyprland.nix # window manager
    ../common/optional/acpilight.nix
    ../common/optional/pipewire.nix

    #################### Users to Create ####################
    ../common/users/muoscar

  ];
  # set custom autologin options. see greetd.nix for details
  # TODO is there a better spot for this?
  # autoLogin.enable = true;
  # autoLogin.username = "muoscar";

  services.gnome.gnome-keyring.enable = true;
  # TODO enable and move to greetd area? may need authentication dir or something?
  # services.pam.services.greetd.enableGnomeKeyring = true;

  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns = true; # deprecated in favour of nssmdns4/6 in unstable/after 23.11
    openFirewall = true;
  };

  hardware.printers = {
    ensurePrinters = [
      {
        name = "Find-Me-Print";
        location = "Chalmers";
        deviceUri = "smb://papercut.chalmers.se/Find-Me-Print";
        model = "drv:///sample.drv/generic.ppd";
        ppdOptions = {
          Option1 = "True"; # Enable duplexing
          # auth-info-required = "negotiate";
          auth-info-required = "username,password";
        };
      }
      {
        name = "O-6108-COLOR3";
        location = "Chalmers-Floor6-HEP";
        deviceUri = "smb://papercut.chalmers.se/O-6108-COLOR3";
        model = "drv:///sample.drv/generic.ppd";
        ppdOptions = {
          Option1 = "True"; # Enable duplexing
          # auth-info-required = "negotiate";
          auth-info-required = "username,password";
        };
      }
    ];
  };

  # for agilent spectrum analyzer
  services.udev.extraRules = ''
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="067b", ATTRS{idProduct}=="23a3", GROUP="users", MODE="0666"
  '';

  networking = {
    hostName = "feynman";
    networkmanager.enable = true;
    enableIPv6 = true;
    firewall.allowedTCPPorts = [ 32123 ];
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.settings = { General = { Experimental = true; }; };
  services.blueman.enable = true;

  boot.loader = {
    systemd-boot.enable = false;
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };
    efi.canTouchEfiVariables = true;
  };
  boot.supportedFilesystems = [ "ntfs" ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
