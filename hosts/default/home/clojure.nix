{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.clojure
    pkgs.jdk21_headless
    pkgs.clj-kondo
    pkgs.rlwrap
    pkgs.leiningen
  ];
}
