{ pkgs, inputs, ... }: {
  programs.zellij = {
    enable = true;
    enableZshIntegration = false; # This autolaunches zellij
    package = pkgs.unstable.zellij;
    settings = {
      pane_frames = false;
      default_mode = "locked";
      # on_force_quit = "close";
      theme = "gruber_darker";
      themes = {
        gruber_darker = {
          # fg = "#484848";
          # fg = "#e4e4ef";
          fg = "#95a99f";
          bg = "#181818";
          black = "#282828";
          red = "#f43841";
          green = "#73c936";
          yellow = "#ffdd33";
          blue = "#565f73";
          magenta = "#9e95c7";
          cyan = "#96a6c8";
          white = "#ffffff";
          orange = "#cc8c3c";
        };
      };
    };
  };

  home.packages = [ inputs.zjstatus.packages.${pkgs.system}.default ];
  xdg.configFile.zellij = {
    source = ./config;
    recursive = true;
  };
}
