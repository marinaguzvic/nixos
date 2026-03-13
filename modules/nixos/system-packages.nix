{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    wget
    lshw
    unzip
  ];
}
