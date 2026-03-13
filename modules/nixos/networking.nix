{ config, pkgs, ... }:

{
  networking.hostName = "hp-linux";
  networking.extraHosts = ''
    127.0.0.1 pve
    127.0.0.1 dashboard.docker.localhost
  '';
  networking.networkmanager.enable = true;
}
