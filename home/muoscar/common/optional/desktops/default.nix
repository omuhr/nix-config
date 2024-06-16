{
  imports = [
    # Packages with custom configs go here

    ./hyprland
    ./waybar
    ./fuzzel.nix
    ./swww.nix
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
