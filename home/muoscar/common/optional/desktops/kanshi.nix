{ pkgs, ... }: {
  services.kanshi = {
    enable = true;
    package = pkgs.unstable.kanshi;
    systemdTarget = "hyprland-session.target";

    settings = [
      {
        profile = {
          name = "undocked";
          outputs = [{
            criteria = "eDP-1";
            scale = 1.0;
          }];
        };
      }
      {
        profile = {
          name = "work0";
          outputs = [
            {
              criteria = "eDP-1";
              position = "0,1650";
              scale = 1.0;
            }
            {
              criteria = "DP-4";
              position = "1920,530";
            }
            {
              criteria = "HDMI-A-2";
              transform = "270";
              position = "4480,0";
            }
          ];
        };
      }
      {
        profile = {
          name = "work1";
          outputs = [
            {
              criteria = "eDP-1";
              position = "0,1650";
              scale = 1.0;
            }
            {
              criteria = "DP-5";
              position = "1920,530";
            }
            {
              criteria = "HDMI-A-2";
              transform = "270";
              position = "4480,0";
            }
          ];
        };
      }
      {
        profile = {
          name = "work2";
          outputs = [
            {
              criteria = "eDP-1";
              position = "0,1650";
              scale = 1.0;
            }
            {
              criteria = "DP-6";
              position = "1920,530";
            }
            {
              criteria = "HDMI-A-2";
              transform = "270";
              position = "4480,0";
            }
          ];
        };
      }
      {
        profile = {
          name = "work3";
          outputs = [
            {
              criteria = "eDP-1";
              position = "0,1650";
              scale = 1.0;
            }
            {
              criteria = "DP-1";
              position = "1920,530";
            }
            {
              criteria = "HDMI-A-2";
              transform = "270";
              position = "4480,0";
            }
          ];
        };
      }
    ];

  };
}

