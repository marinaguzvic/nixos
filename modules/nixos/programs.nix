# Hyprland, 1Password - requires inputs.hyprland
{ config, pkgs, inputs, ... }:

{
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland;
  };
  programs._1password.enable = true;
  programs._1password-gui.enable = true;
}
