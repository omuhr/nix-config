{ pkgs, ... }: { home.packages = with pkgs.unstable; [ cargo rustc ]; }
