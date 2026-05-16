{ config, pkgs, ... }:

{
  imports = [
    ./notify-upon-finish.nix
    ./hyprland.nix
    ./waybar.nix
  ];

  home.packages = [
    pkgs.dunst
    (pkgs.flameshot.overrideAttrs (old: {
      cmakeFlags = old.cmakeFlags or [ ] ++ [ "-DUSE_WAYLAND_GRIM=ON" ];
    }))
    pkgs.xdg-desktop-portal-gtk
    pkgs.awww
    pkgs.rofi
    pkgs.grim
    pkgs.slurp
    pkgs.wl-clipboard
    pkgs.networkmanagerapplet
    pkgs.pipewire
    pkgs.wireplumber
    pkgs.xdg-desktop-portal-hyprland
  ];

  services.dunst.enable = true;

  # psi-notify is a user service for PSI notifications
  systemd.user.services.psi-notify = {
    Unit = {
      Description = "psi-notify daemon";
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.psi-notify}/bin/psi-notify";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    configPackages = [
      pkgs.xdg-desktop-portal-gnome
    ];
  };
}
