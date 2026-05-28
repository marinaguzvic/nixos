{ config, pkgs, nix-colors, ... }:

{
  colorScheme = nix-colors.colorSchemes.catppuccin-mocha;
  catppuccin.flavor = "mocha";
  catppuccin.enable = true;
  catppuccin.hyprland.enable = false;
}
