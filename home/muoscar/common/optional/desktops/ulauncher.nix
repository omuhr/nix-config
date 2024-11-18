{ pkgs, ... }: {
  home.packages = with pkgs.unstable; [
    ulauncher
    python312Packages.pint
    python312Packages.simpleeval
    python312Packages.parsedatetime
    python312Packages.pytz
  ];

}
