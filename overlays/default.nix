# This file defines overlays/custom modifications to upstream packages
#

{ inputs, ... }: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: let ... in {
    # ...
    # });
    saleae-logic-2 = prev.pkgs.unstable.saleae-logic-2.overrideAttrs (old: {
      version = "2.4.14";
      src = final.pkgs.fetchurl {
        url =
          "https://downloads.saleae.com/logic2/Logic-2.4.14-linux-x64.AppImage";
        hash = "sha256-qiFTE8/An0um/eP+owtE8fcCX0EnnTg00S2H6OBO38g=";
      };
    });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
