{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.joplin-desktop
    pkgs.oauth2c
    pkgs.python3
    pkgs.openssl
    pkgs.expect
    pkgs.libreoffice
    pkgs.wirelesstools
    pkgs.libnotify
    pkgs.mako
    pkgs.sshpass
    pkgs.mtr
    pkgs.jq
    pkgs.jqp
    pkgs.iperf
    pkgs.code-cursor
    pkgs.bundix
    pkgs.ruby
    pkgs.vagrant
    pkgs.slack
    pkgs.trayscale
    pkgs.wmctrl
    pkgs.dnsutils
    pkgs.inetutils
    pkgs.mqttui
    pkgs.pciutils
    pkgs.speedtest-cli
    pkgs._1password-gui
    pkgs._1password-cli
    pkgs.nerd-fonts.iosevka
    pkgs.nerd-fonts.iosevka-term
  ];
}
