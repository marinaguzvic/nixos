# NixOS configuration for hp-linux
# Edit this configuration file to define what should be installed on your system.
# Help is available in the configuration.nix(5) man page and in the NixOS manual.

{
  config,
  pkgs,
  inputs,
  nix-colors,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default

    # NixOS modules
    ../../modules/nixos/boot.nix
    ../../modules/nixos/networking.nix
    ../../modules/nixos/locale.nix
    ../../modules/nixos/greetd.nix
    ../../modules/nixos/printing.nix
    ../../modules/nixos/audio.nix
    ../../modules/nixos/users.nix
    ../../modules/nixos/system-packages.nix
    ../../modules/nixos/tailscale.nix
    ../../modules/nixos/nix.nix
    ../../modules/nixos/programs.nix
    ../../modules/nixos/session.nix
    ../../modules/nixos/virtualization.nix
    ../../modules/nixos/defaults.nix
    # ../../modules/nixos/gnome.nix  # Uncomment when using GNOME
  ];

  # Home Manager - host-specific glue
  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
      inherit nix-colors;
      neovim-config = inputs.neovim-config;
      pkgs-stable = import inputs.nixpkgs-stable {
        system = pkgs.stdenv.hostPlatform.system;
        config = { allowUnfree = true; };
      };
    };
    users.marinadj = {
      imports = [
        ./home.nix
        inputs.catppuccin.homeModules.catppuccin
      ];
    };
  };
}
