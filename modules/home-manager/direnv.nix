{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.direnv
  ];

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };
}
