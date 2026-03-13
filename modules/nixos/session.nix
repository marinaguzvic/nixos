# Wayland/display session variables
{ config, pkgs, ... }:

{
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    TERM = "xterm-256color";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}
