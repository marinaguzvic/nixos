# NixOS GNOME system configuration
# Required for GNOME shell extensions (e.g. appindicator) to work properly.
# Import this in configuration.nix when using the GNOME home-manager module.

{ config, pkgs, ... }:

{
  services.udev.packages = with pkgs; [ gnome-settings-daemon ];
}
