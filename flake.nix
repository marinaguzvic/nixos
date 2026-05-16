{
  description = "Nixos config flake";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nix-colors.url = "github:misterio77/nix-colors";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ flake-parts, nixpkgs, nixpkgs-stable, catppuccin, nix-colors, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      # Reusable Home Manager modules - import in home.nix or use with homeConfigurations
      flake.homeModules = {
        wayland = ./modules/home-manager/wayland.nix;
        git = ./modules/home-manager/git.nix;
        clojure = ./modules/home-manager/clojure.nix;
        utils = ./modules/home-manager/utils.nix;
        zprint = ./modules/home-manager/zprint.nix;
        direnv = ./modules/home-manager/direnv.nix;
        chromium = ./modules/home-manager/chromium.nix;
        desktop-colors = ./modules/home-manager/desktop-colors.nix;
        terminal = ./modules/home-manager/terminal.nix;
        shell = ./modules/home-manager/shell.nix;
        gnome = ./modules/home-manager/gnome.nix;
        neovim = ./modules/home-manager/neovim/default.nix;
      };

      # NixOS configuration
      flake.nixosConfigurations.hp-linux = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit nix-colors;
        };
        modules = [
          catppuccin.nixosModules.catppuccin
          ./hosts/hp-linux/configuration.nix
        ];
      };
    };
}
