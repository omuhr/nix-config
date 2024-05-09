{ pkgs, ... }: {
  programs.zsh = {
    enable = true;

    # relative to ~
    dotDir = ".config/zsh";
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    enableAutosuggestions = true;
    history.size = 10000;
    history.share = true;

    plugins = [
      {
        name = "cd-gitroot";
        src = "${pkgs.cd-gitroot}/share/zsh/cd-gitroot";
      }
    ];

    shellAliases = {
      ".." = "cd ..";
    };
    #   # Overrides those provided by OMZ libs, plugins, and themes.
    #   # For a full list of active aliases, run `alias`.
    #
    #   #-------------Bat related------------
    #   cat = "bat";
    #   diff = "batdiff";
    #   rg = "batgrep";
    #   man = "batman";
    #
    #   #------------Navigation------------
    #   doc = "cd $HOME/documents";
    #   scripts = "cd $HOME/scripts";
    #   ts = "cd $HOME/.talon/user/fidget";
    #   src = "cd $HOME/src";
    #   edu = "cd $HOME/src/edu";
    #   dfs = "cd $HOME/src/dotfiles";
    #   dfsw = "cd $HOME/src/dotfiles.wiki";
    #   nfs = "cd $HOME/src/nix-config";
    #   uc = "cd $HOME/src/unmovedcentre";
    #   l = "eza -lah";
    #   la = "eza -lah";
    #   ll = "eza -lh";
    #   ls = "eza";
    #   lsa = "eza -lah";
    #
    #   #-------------Neovim---------------
    #   e = "nvim";
    #   vi = "nvim";
    #   vim = "nvim";
    #
    #   #-----------Nix related----------------
    #   ne = "nix-instantiate --eval";
    #   nb = "nix-build";
    #   ns = "nix-shell";
    #
    #   #-----------Remotes----------------
    #   cakes = "ssh -l freshcakes freshcakes.memeoid.cx";
    #   gooey = "ssh -l pi 10.13.37.69";
    #   gusto = "ssh -l ta 10.13.37.5";
    #   grief = "ssh -l ta 10.13.37.7";
    #
    #   #-------------Git Goodness-------------
    #   # just reference `$ alias` and use the defautls, they're good.
    # };
  };
}
