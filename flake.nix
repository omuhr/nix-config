{
  description = "Oscar's Nix-Config";

  inputs = {
    #################### Official NixOS Package Sources ####################

    nixpkgs.url = "github:NixOS/nixpkgs/release-23.11";
    nixpkgs-unstable.url =
      "github:NixOS/nixpkgs/nixos-unstable"; # also see 'unstable-packages' overlay at 'overlays/default.nix"

    #################### Utilities ####################

    # Official NixOS hardware packages
    hardware.url = "github:nixos/nixos-hardware";

    # Home-manager for declaring user/home configurations
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
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
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
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

        # work
        feynman = lib.nixosSystem {
          modules = [ ./hosts/feynman ];
          specialArgs = { inherit inputs outputs; };
        };
      };

      #################### User-level Home-Manager Configurations ####################
      # Available through 'home-manager --flake .#primary-username@hostname'
      # Typically adopted using 'home-manager switch --flake .#primary-username@hostname'

      homeConfigurations = {
        "muoscar@feynman" = lib.homeManagerConfiguration {
          modules = [ ./home/muoscar/feynman.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
      };
    };
}
