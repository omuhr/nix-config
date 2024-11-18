{ pkgs, outputs, lib, ... }: {
  programs.ssh = {
    enable = true;
    package = pkgs.unstable.openssh;
    matchBlocks = {
      pluto = {
        user = "pi";
        hostname = "pluto";
      };
      mvp2 = {
        user = "root";
        hostname = "192.168.10.1";
        proxyJump = "pluto";
      };
    };

    #extraConfig = ''
    #Include config.d/*
    #'';
  };
}
