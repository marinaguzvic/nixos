{
  config,
  pkgs,
  lib,
  nix-colors,
  neovim-config,
  ...
}:

{
  imports = [
    nix-colors.homeManagerModules.default
    neovim-config.nixosModules.default

    # Home Manager modules
    ../../modules/home-manager/wayland.nix
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/clojure.nix
    ../../modules/home-manager/utils.nix
    ../../modules/home-manager/zprint.nix
    ../../modules/home-manager/direnv.nix
    ../../modules/home-manager/chromium.nix
    ../../modules/home-manager/desktop-colors.nix
    ../../modules/home-manager/terminal.nix
    ../../modules/home-manager/shell.nix
    # ../../modules/home-manager/gnome.nix  # Disabled - using Hyprland instead
  ];

  # Core Home Manager configuration
  home.username = "marinadj";
  home.homeDirectory = "/home/marinadj";
  home.stateVersion = "24.05";

  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
}
