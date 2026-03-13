{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.git
    pkgs.gitui
  ];

  programs.git = {
    enable = true;
    settings = {
      safe.directory = "/etc/nixos";
      user = {
        name = "Marina Djordjevic";
        email = "marina.guzvic@gmail.com";
      };
    };
  };

  programs.bash.shellAliases = {
    gm = "git commit -m";
    ga = "git add";
    gsr = "git reset --soft HEAD~1";
    gs = "git status";
    gpo = "git push origin";
    gcb = "git checkout -b";
    gsth = "git stash --keep-index";
  };
}
