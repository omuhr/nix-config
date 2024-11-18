# #################################
#                                #
#  Feynman - Work Thinkpad P43s  #
#  NixOS running on work laptop  #
#                                #
##################################

{ inputs, config, pkgs, lib, ... }: {
  imports = [
    #################### Hardware Modules ####################
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-gpu-nvidia
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.hardware.nixosModules.common-pc-laptop-acpi_call

    #################### Required Configs ####################
    ../common/core
    ./hardware-configuration.nix

    #################### Host-specific Optional Configs ####################

    # ../common/optional/services/greetd.nix # display manager
    ../common/optional/gnome.nix # window manager
    ../common/optional/hyprland.nix # window manager
    ../common/optional/acpilight.nix
    ../common/optional/pipewire.nix
    ../common/optional/nix-ld.nix
    ../common/optional/services/kanata.nix

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

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    # is this too much?  It's convenient for Steam.
    enable = lib.mkDefault true;
    enable32Bit = lib.mkDefault true;
  };

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.beta;

    # The open source driver does not support Pascal GPUs.
    open = false;

    # Enable the Nvidia settings menu, accessible via `nvidia-settings`.
    nvidiaSettings = true;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = lib.mkDefault "PCI:0:2:0";
      nvidiaBusId = lib.mkDefault "PCI:60:0:0";
    };

    # fix suspend/resume screen corruption in sync mode
    powerManagement = lib.mkIf config.hardware.nvidia.prime.sync.enable {
      enable = lib.mkDefault true;
    };

    # fix screen tearing in sync mode
    modesetting = lib.mkIf config.hardware.nvidia.prime.sync.enable {
      enable = lib.mkDefault true;
    };

  };

  # required to make wireless work
  hardware.enableAllFirmware = lib.mkDefault true;

  services.throttled.enable = lib.mkDefault true;

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  services.printing = { enable = true; };
  services.avahi = {
    enable = true;
    nssmdns = true; # deprecated in favour of nssmdns4/6 in unstable/after 23.11
    # nssmdns4 = true;
    openFirewall = true;
  };

  hardware.printers = {
    ensurePrinters = [
      {
        name = "home";
        location = "home";
        deviceUri =
          "dnssd://HP%20Color%20LaserJet%20CP2025n%20(0DFA50)._pdl-datastream._tcp.local/";
        model = "drv:///sample.drv/laserjet.ppd";
        ppdOptions = {
          PageSize = "A4";
          Option1 = "True"; # Enable duplexing
        };
      }
      {
        name = "work";
        location = "Satcube";
        deviceUri =
          "dnssd://Xerox%20VersaLink%20C405%20(a5%3A97%3Aee)._pdl-datastream._tcp.local/?uuid=cfcb6b90-1dd1-11b2-bc06-9c934ea597ee";
        model = "drv:///sample.drv/deskjet.ppd";
        # model = "drv:///sample.drv/laserjet.ppd";
        ppdOptions = {
          PageSize = "A4";
          Option1 = "True"; # Enable duplexing
        };
      }
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
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="067b", ATTRS{idProduct}=="23a3", MODE="0666"
  '';
  services.udev.packages = [ pkgs.platformio-core.udev pkgs.openocd ];

  # udev rules for saleae logic analyzers
  hardware.saleae-logic.enable = true;

  networking = {
    hostName = "feynman";
    # networkmanager.enable = true;
    enableIPv6 = true;
    firewall.allowedTCPPorts = [ 32123 ];
    # interfaces.enp58s0u1u2 = {
    #   useDHCP = false;
    #   ipv4.addresses = [{
    #     address = "192.168.222.217";
    #     prefixLength = 29;
    #   }];
    # };
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
  system.stateVersion = "24.05";
}
