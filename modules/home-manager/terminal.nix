{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.kitty
  ];

  programs.kitty = {
    enable = true;
    keybindings = {
      "cmd+shift+t" = "new_tab_with_cwd";
    };
  };
}
