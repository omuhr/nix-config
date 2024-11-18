{ pkgs, ... }: {
  programs.zsh = {
    enable = true;

    # relative to ~
    dotDir = ".config/zsh";
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    autosuggestion.enable = true;
    history.size = 10000;
    history.share = true;

    plugins = [{
      name = "cd-gitroot";
      src = "${pkgs.cd-gitroot}/share/zsh/cd-gitroot";
    }];

    sessionVariables = { ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=#484848"; };

    shellAliases = {
      ".." = "cd ..";
      grep = "batgrep";
      cat = "bat";
      diff = "batdiff";
      rg = "batgrep";
      man = "batman";
      l = "eza -lah";
      la = "eza -lah";
      ll = "eza -lh";
      ls = "eza";
    };
  };
}
