# greetd display manager with tuigreet for Hyprland autologin
# Uses start-hyprland wrapper (required by Hyprland for proper XDG/portal setup)
{ config, pkgs, ... }:

{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd ${config.programs.hyprland.package}/bin/start-hyprland";
        user = "greeter";
      };
      initial_session = {
        command = "${config.programs.hyprland.package}/bin/start-hyprland";
        user = "marinadj";
      };
    };
  };
}
