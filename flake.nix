{
  description = "Oscar's Nix-Config";

  inputs = {
    #################### Official NixOS Package Sources ####################

    nixpkgs.url = "github:NixOS/nixpkgs/release-24.05";
    nixpkgs-unstable.url =
      "github:NixOS/nixpkgs/nixos-unstable"; # also see 'unstable-packages' overlay at 'overlays/default.nix"

    #################### Utilities ####################

    # Official NixOS hardware packages
    hardware.url = "github:nixos/nixos-hardware";

    # Home-manager for declaring user/home configurations
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # neovim overlay with the nightly build
    # neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    # ngrams data for ltex grammar
    ngrams = {
      url = "github:Janik-Haag/nix-languagetool-ngram/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # status bar for zellij
    zjstatus = { url = "github:dj95/zjstatus"; };

    # latest hyprland
    hyprland.url = "github:hyprwm/hyprland";

    # zen browser
    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    # ags
    ags.url = "github:Aylur/ags";
  };

  outputs = { self, nixpkgs, home-manager, nix-index-database, ... }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      systems = [ "x86_64-linux" ];
      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs systems (system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        });
    in {
      inherit lib;

      # Custom modules to enable special functionality for nixos or home-manager oriented configs.
      nixosCustomModules = import ./customModules/nixos;
      homeManagerCustomModules = import ./customModules/home-manager;

      # Custom modifications/overrides to upstream packages.
      overlays = import ./overlays { inherit inputs outputs; };

      # Your custom packages meant to be shared or upstreamed.
      # Accessible through 'nix build', 'nix shell', etc
      packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });

      # Nix formatter available through 'nix fmt' https://nix-community.github.io/nixpkgs-fmt
      formatter = forEachSystem (pkgs: pkgs.nixpkgs-fmt);

      # Shell configured with packages that are typically only needed when working on or with nix-config.
      devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs; });

      #################### NixOS Configurations ####################
      # Available through 'nixos-rebuild --flake .#hostname'
      # Typically adopted using 'sudo nixos-rebuild switch --flake .#hostname'

      nixosConfigurations = {
        # Example
        # <hostname> = lib.nixosSystem {
        #   modules = [ ./hosts/<hostname> ];
        #   specialArgs = { inherit inputs outputs; };
        # };

        # home desktop
        dirac = lib.nixosSystem {
          modules = [ ./hosts/dirac ];
          specialArgs = { inherit inputs outputs; };
        };

        # work Thinkpad P43s
        feynman = lib.nixosSystem {
          modules = [ ./hosts/feynman ];
          specialArgs = { inherit inputs outputs; };
        };

        # work Zephyrus G16
        lagrange = lib.nixosSystem {
          modules = [ ./hosts/lagrange ];
          specialArgs = { inherit inputs outputs; };
        };
      };

      #################### User-level Home-Manager Configurations ####################
      # Available through 'home-manager --flake .#primary-username@hostname'
      # Typically adopted using 'home-manager switch --flake .#primary-username@hostname'

      homeConfigurations = {
        "muoscar@dirac" = lib.homeManagerConfiguration {
          modules =
            [ ./home/muoscar/dirac.nix nix-index-database.hmModules.nix-index ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
        "muoscar@feynman" = lib.homeManagerConfiguration {
          modules = [
            ./home/muoscar/feynman.nix
            nix-index-database.hmModules.nix-index
            inputs.ags.homeManagerModules.default
          ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
        "muoscar@lagrange" = lib.homeManagerConfiguration {
          modules = [
            ./home/muoscar/lagrange.nix
            nix-index-database.hmModules.nix-index
            inputs.ags.homeManagerModules.default
          ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
      };
    };
}
