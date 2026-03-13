# GNOME configuration module - disabled by default (Hyprland is used instead)
# Include this module in home.nix imports to enable GNOME shell extensions and settings

{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.gnomeExtensions.appindicator
    pkgs.gnomeExtensions.forge
    pkgs.gnomeExtensions.space-bar
  ];

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      disabled-extensions = "disabled";
      enabled-extensions = [
        "forge@jmmaranan.com"
        "space-bar@luchrioh"
        "system-monitor@gnome-shell-extensions.gcampax.github.com"
        "hidetopbar@mathieu.bidon.ca"
        "notification-timeout@chlumskyvaclav.gmail.com"
      ];
    };
    "org/gnome/desktop/wm/keybindings" = { };
  };

}
