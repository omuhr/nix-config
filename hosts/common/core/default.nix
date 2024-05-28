{ inputs, outputs, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./locale.nix # localization settings
    ./nix.nix # nix settings and garbage collection
    ./zsh.nix # load a basic shell just in case we need it without home-manager
    ./git.nix # make sure we have git if needed

    # ./services/auto-upgrade.nix # auto-upgrade service TODO: Enable this

  ] ++ (builtins.attrValues outputs.nixosCustomModules);

  home-manager.extraSpecialArgs = { inherit inputs outputs; };

  nixpkgs = {
    # you can add global overlays here
    overlays = builtins.attrValues outputs.overlays;
    config = { allowUnfree = true; };
  };

  hardware.enableRedistributableFirmware = true;
}
