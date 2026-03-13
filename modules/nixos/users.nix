{ config, pkgs, ... }:

{
  users.users.marinadj = {
    isNormalUser = true;
    description = "Marina Djordjevic";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    packages = with pkgs; [ ];
  };
}
