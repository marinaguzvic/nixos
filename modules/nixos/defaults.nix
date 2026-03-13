{ config, pkgs, ... }:

{
  system.stateVersion = "24.11";
  xdg.portal.enable = true;
  fonts.fontDir.enable = true;
  services.envfs.enable = true;
}
