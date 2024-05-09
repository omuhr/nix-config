{ pkgs, lib, config, ... }:
{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "muoscar";
    userEmail = "oscar.muhr@gmail.com";
    aliases = { };
    extraConfig = {
      init.defaultBranch = "main";
      url = { };
    };
    # enable git Large File Storage: https://git-lfs.com/
    # lfs.enable = true;
    ignores = [ ".direnv" "result" ];
  };
}
