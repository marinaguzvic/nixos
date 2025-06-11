{ pkgs }:

pkgs.writeShellScriptBin "nvim-ai" (builtins.readFile ./scripts/nvim-ai.sh)

