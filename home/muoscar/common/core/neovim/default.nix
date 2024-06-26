{ inputs, pkgs, ... }:
let
  # Needed because the one currently in nixpks relies on node_16 which has reached EOL.
  # Need to compile using node2nix with the -18 flag to use node_18.
  # See: https://github.com/znck/grammarly/issues/368
  # To solve error during LS init you must downgrade grammarly-sdk in node-packages.nix using
  #     "@grammarly/sdk-2.3.18" = {
  #       name = "_at_grammarly_slash_sdk";
  #       packageName = "@grammarly/sdk";
  #       version = "2.3.18";
  #       src = fetchurl {
  #         url = "https://registry.npmjs.org/@grammarly/sdk/-/sdk-2.3.18.tgz";
  #         sha512 =
  #           "Cs57YERKG4wYXWnQIAaPmQqM5Z4usXLzSfuqr3x32X5WQzGicfNM2sJhfJMYZdPKcJX8fvC8TuUduoTiDgxnkQ==";
  #       };
  #     };

  nodePackagesGrammarly =
    import ./grammarly-languageserver/default.nix { inherit pkgs; };
in {
  programs.neovim = {
    enable = true;
    package = pkgs.unstable.neovim-unwrapped;
    # package = pkgs.neovim-nightly;
    withRuby = true;
    withNodeJs = true;
    withPython3 = true;
    extraPackages = with pkgs; [
      ################# Language servers #################

      # nix
      nixd
      nil

      #lua
      lua-language-server

      # Latex
      ltex-ls
      texlab

      # Rust
      rust-analyzer

      # Python
      pyright

      # TOML
      taplo

      # Grammar
      # nodePackages_latest.grammarly-languageserver
      nodePackagesGrammarly.grammarly-languageserver-next

      ################# Formatters #################

      # nix
      nixfmt

      # lua
      stylua

      # json
      jq

      # Rust
      rustfmt
    ];
  };

  home.packages = [ pkgs.tree-sitter ];

  xdg.configFile.nvim = {
    source = ./config;
    recursive = true;
  };

  # See https://github.com/Janik-Haag/nix-languagetool-ngram/issues/1
  home.file.ngrams.source = inputs.ngrams.packages.${pkgs.system}.ngrams-en;
}
