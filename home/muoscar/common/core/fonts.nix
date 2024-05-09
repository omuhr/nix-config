{ pkgs, ... }: {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs;
    [
      # noto-fonts
      unstable.nerdfonts # loads the complete collection. look into overide for FiraMono or potentially mononoki
      # (unstable.nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
      # unstable.nerdfonts # loads the complete collection. look into overide for FiraMono or potentially mononoki
      # meslo-lgs-nf
    ];
}
