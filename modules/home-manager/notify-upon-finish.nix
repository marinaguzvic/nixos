{ pkgs }:

pkgs.writeShellScriptBin "notify-upon-finish" (builtins.readFile ./scripts/notify-upon-finish.sh)

