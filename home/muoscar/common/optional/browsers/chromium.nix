{ pkgs, ... }: {
  programs.chromium = {
    enable = true;
    # package = pkgs.unstable.ungoogled-chromium;
    package = pkgs.unstable.chromium;
    commandLineArgs = [ "--no-default-browser-check" "--restore-last-sesion" ];
  };
}
