{ config, pkgs, ... }:

let
  notifyUponFinish = pkgs.writeShellScriptBin "notify-upon-finish" (builtins.readFile ./scripts/notify-upon-finish.sh);
in
{
  home.packages = [
    pkgs.libnotify
    notifyUponFinish
  ];
}

