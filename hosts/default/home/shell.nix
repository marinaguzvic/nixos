# Bash shell configuration - suggested module for shell aliases and session vars
{ config, pkgs, ... }:

{
  home.sessionVariables = {
    EDITOR = "vim";
  };

  programs.bash = {
    enable = true;
    sessionVariables = {
      TERM = "xterm-256color";
    };
    shellAliases = {
      ll = "ls -lahrt";
      ".." = "cd ..";
      eni = "nvim /etc/nixos";
    };
  };
}
