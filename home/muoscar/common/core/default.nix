{ inputs, config, lib, pkgs, outputs, ... }: {
  imports = [

    # Packages with custom configs go here

    ./bat.nix # cat with better syntax highlighting and extras like batgrep.
    # ./direnv.nix # shell environment manager. Hooks inot shell direnv to look for .envrc before prompts
    ./fonts.nix # core fonts
    ./git.nix # personal git config
    ./kitty.nix # terminal
    ./wezterm/wezterm.nix # terminal
    ./alacritty/alacritty.nix # terminal
    ./man-pages.nix # manual pages for linux syscalls and C
    ./neovim # vim goodness
    ./zellij # multiplexer
    ./screen.nix # hopefully rarely needed but good to have if so
    ./zoxide.nix # cd replacement
    ./zsh # primary shell: includes zsh
    ./nushell.nix # fun shell
    ./bash.nix # backup shell
    ./starship.nix # cross-shell prompt
    ./carapace.nix # shell completions

    ./ssh.nix # ssh config

    ./comma.nix # run commands without installing them i.e.: , ripgrep whatever

    # TODO: Not set, need to investigate but will need custom config if used:
    # ./shellcolor.nix

  ] ++ (builtins.attrValues outputs.homeManagerCustomModules);

  home = {
    username = lib.mkDefault "muoscar";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "24.05";
    sessionPath = [ "$HOME/.local/bin" "$HOME/scripts/talon_scripts" ];
    sessionVariables = {
      FLAKE = "$HOME/src/nix-config";
      SHELL = "zsh";
      TERM = "kitty";
      TERMINAL = "kitty";
      EDITOR = "nvim";
      MANPAGER = "batman"; # see ./cli/bat.nix
    };
  };

  home.packages = builtins.attrValues {
    inherit (pkgs)

    # Packages that don't have custom configs go here

    # TODO: spaces before comment are removed by nixpkgs-fmt
    # See: https://github.com/nix-community/nixpkgs-fmt/issues/305
      borgbackup # backups
      btop # resource monitor
      coreutils # basic gnu utils
      # curl
      eza # ls replacement
      fd # tree style ls
      findutils # find
      fzf # fuzzy search
      jq # JSON pretty printer and manipulator
      nix-tree # nix package tree viewer
      ncdu # TUI disk usage
      pciutils pfetch # system info
      pre-commit # git hooks
      p7zip # compression & encryption
      ripgrep # better grep
      usbutils tree # cli dir tree viewer
      unzip # zip extraction
      unrar # rar extraction
      wget # downloader
      zip; # zip compression
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
      permittedInsecurePackages = [ "adobe-reader-9.5.5" ];
    };
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      warn-dirty = true;
    };
  };

  programs = { home-manager.enable = true; };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
