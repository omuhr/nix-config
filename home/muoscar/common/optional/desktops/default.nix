{
  imports = [
    # Packages with custom configs go here

    ./hyprland
    ./waybar
    ./ags
    ./swaync
    ./fuzzel.nix
    ./swww.nix
    ./ulauncher.nix
    ./kanshi.nix
    # ./apple-cursor.nix

    ########## Utilities ##########
    #    ./services/dunst.nix # Notification daemon
    #    ./waybar.nix # infobar
    #./rofi-wayland.nix #app launcher
    #./swww.nix #wallpaper daemon

    #    ./gtk.nix # mainly in gnome
    #    ./qt.nix # mainly in kde
    #./fonts.nix
  ];
}
