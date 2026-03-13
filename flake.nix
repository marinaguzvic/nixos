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
    neovim-config.url = "path:/home/marinadj/Projects/nixos/neovim-nix";
  };

  outputs = inputs@{ flake-parts, nixpkgs, nixpkgs-stable, catppuccin, nix-colors, neovim-config, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      # Reusable Home Manager modules - import in home.nix or use with homeConfigurations
      flake.homeModules = {
        wayland = ./hosts/default/home/wayland.nix;
        git = ./hosts/default/home/git.nix;
        clojure = ./hosts/default/home/clojure.nix;
        utils = ./hosts/default/home/utils.nix;
        zprint = ./hosts/default/home/zprint.nix;
        direnv = ./hosts/default/home/direnv.nix;
        chromium = ./hosts/default/home/chromium.nix;
        desktop-colors = ./hosts/default/home/desktop-colors.nix;
        terminal = ./hosts/default/home/terminal.nix;
        shell = ./hosts/default/home/shell.nix;
        gnome = ./hosts/default/home/gnome.nix;
      };

      # NixOS configuration
      flake.nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit nix-colors;
        };
        modules = [
          catppuccin.nixosModules.catppuccin
          ./hosts/default/configuration.nix
        ];
      };
    };
}
