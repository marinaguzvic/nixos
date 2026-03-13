{ config, pkgs, ... }:

{
  home.file.".zprint.edn".text = ''
    {:style :justified
     :width 120}
  '';
}
