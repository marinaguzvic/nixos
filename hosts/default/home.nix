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

    # Home Manager modules (flake-parts style)
    ./home/wayland.nix
    ./home/git.nix
    ./home/clojure.nix
    ./home/utils.nix
    ./home/zprint.nix
    ./home/direnv.nix
    ./home/chromium.nix
    ./home/desktop-colors.nix
    ./home/terminal.nix
    ./home/shell.nix
    # ./home/gnome.nix  # Disabled - using Hyprland instead
  ];

  # Core Home Manager configuration
  home.username = "marinadj";
  home.homeDirectory = "/home/marinadj";
  home.stateVersion = "24.05";

  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
}
