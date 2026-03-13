{ config, pkgs, ... }:

let
  startupScript = pkgs.writeShellScriptBin "start" ''
    ${pkgs.networkmanagerapplet}/bin/nm-applet --indicator &
    ${pkgs.dunst}/bin/dunst &
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.swww}/bin/swww init &

    sleep 1

    ${pkgs.swww}/bin/swww img ${../wallpapers/wallpaper.jpeg} &
  '';
  notifyUponFinish = import ../../../modules/home-manager/notify-upon-finish.nix { inherit pkgs; };
in
{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      exec-once = [
        ''${startupScript}/bin/start''
        "[workspace 3 silent] slack"
        "[workspace 2 silent] chromium-browser --new-window https://chatgpt.com/"
        "[workspace 1 silent] kitty"
      ];
      "$mainMod" = "SUPER";

      monitor = [
        "eDP-1, 1920x1080, 1920x0, 1.0"
        "HDMI-A-1, 1920x1080, 0x0, 1.0"
      ];
      workspace = [
        "1, monitor:HDMI-A-1"
        "2, monitor:eDP-1"
        "3, monitor:eDP-1"
      ];

      general = {
        gaps_out = 8;
      };

      decoration = {
        rounding = 5;
      };

      input = {
        kb_layout = "us,rs";
        kb_variant = ",latin";
        kb_options = "grp:caps_toggle";
      };

      bind = [
        "$mainMod, P, exec, XDG_CURRENT_DESKTOP=sway flameshot gui"
        "$mainMod, S, exec, rofi -show drun -show-icons"

        "$mainMod, comma, workspace, m-1"
        "$mainMod, period, workspace, m+1"

        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"

        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"

        "$mainMod, h, movefocus, l"
        "$mainMod, j, movefocus, d"
        "$mainMod, k, movefocus, u"
        "$mainMod, l, movefocus, r"

        "$mainMod, bracketleft, movecurrentworkspacetomonitor, l"
        "$mainMod, bracketright, movecurrentworkspacetomonitor, r"
      ];
    };

    extraConfig = ''
      windowrule = match:class flameshot, no_anim on
      windowrule = match:class flameshot, float on
      windowrule = match:class flameshot, move 0 0
      windowrule = match:class flameshot, pin on
      windowrule = match:class flameshot, no_initial_focus on
      windowrule = match:class flameshot, monitor 1
    '';
  };

  home.packages = [
    notifyUponFinish
    pkgs.dunst
    pkgs.libnotify
    (pkgs.flameshot.overrideAttrs (old: {
      cmakeFlags = old.cmakeFlags or [ ] ++ [ "-DUSE_WAYLAND_GRIM=ON" ];
    }))
    pkgs.xdg-desktop-portal-gtk
    pkgs.swww
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

  imports = [
    ../../../modules/home-manager/wayland/waybar.nix
  ];
}
