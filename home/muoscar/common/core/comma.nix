{ pkgs, ... }: {
  programs.nix-index-database.comma.enable = true;
  programs.nix-index.enable = true;
}
