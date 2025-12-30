{
  config,
  pkgs,
  lib,
  nix-colors,
  neovim-config,
  ...
}:

let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.networkmanagerapplet}/bin/nm-applet --indicator &
       ${pkgs.dunst}/bin/dunst &
       ${pkgs.waybar}/bin/waybar &
       ${pkgs.swww}/bin/swww init &

       sleep 1

    ${pkgs.swww}/bin/swww img ${./wallpapers/wallpaper.jpeg} &
       
  '';
  nvimAi = import ../../modules/home-manager/neovim/nvim-ai.nix { inherit pkgs; };
  notifyUponFinish = import ../../modules/home-manager/notify-upon-finish.nix { inherit pkgs; };

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
        # Right physical monitor placed on the left (DP-1)
        "eDP-1, 1920x1080, 1920x0, 1.0"

        # Left physical monitor placed on the right (HDMI-A-1)
        "HDMI-A-1, 1920x1080, 0x0, 1.0"
      ];
      # Rules to assign apps to specific workspaces (and monitors)
      workspace = [
        "1, monitor:HDMI-A-1"
        "2, monitor:eDP-1"
        "3, monitor:eDP-1"
      ];

      windowrulev2 = [
        "noanim, class:^(flameshot)$"
        "float, class:^(flameshot)$"
        "move 0 0, class:^(flameshot)$"
        "pin, class:^(flameshot)$"
        "monitor 1, class:^(flameshot)$"
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

        # Move between workspaces
        "$mainMod, comma, workspace, m-1"
        "$mainMod, period, workspace, m+1"

        # Move focused window to workspace 1–9 using $mainMod + SHIFT + number
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"

        # Focus workspaces 1–9 with mainMod + number
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"

        # Move focus between windows with hjkl
        "$mainMod, h, movefocus, l"
        "$mainMod, j, movefocus, d"
        "$mainMod, k, movefocus, u"
        "$mainMod, l, movefocus, r"

        # Move current workspace to other monitor
        "$mainMod, bracketleft, movecurrentworkspacetomonitor, l"
        "$mainMod, bracketright, movecurrentworkspacetomonitor, r"
      ];
    };

  };
  #
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  colorScheme = nix-colors.colorSchemes.catppuccin-mocha;
  home.username = "marinadj";
  home.homeDirectory = "/home/marinadj";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  nixpkgs.config.allowUnfree = true; # Add this line
  home.packages = [
    nvimAi
    notifyUponFinish
    # git
    pkgs.git
    pkgs.gitui

    pkgs.clojure
    pkgs.jdk21_headless
    pkgs.clj-kondo
    pkgs.rlwrap

    pkgs.joplin-desktop
    pkgs.oauth2c
    pkgs.python3

    pkgs.openssl
    pkgs.expect

    pkgs.libreoffice
    pkgs.galculator
    pkgs.wirelesstools

    # Notifications
    pkgs.libnotify
    pkgs.mako

    pkgs.sshpass

    pkgs.mtr

    pkgs.jq
    # Terminal UI tool for playing with jq
    pkgs.jqp

    pkgs.dunst
    pkgs.libnotify
    (pkgs.flameshot.overrideAttrs (old: {
      cmakeFlags = old.cmakeFlags or [ ] ++ [ "-DUSE_WAYLAND_GRIM=ON" ];
    })) # Only do this for wayland config
    pkgs.xdg-desktop-portal-gtk
    pkgs.swww
    pkgs.kitty
    pkgs.rofi 
    pkgs.grim
    pkgs.slurp
    pkgs.iperf
    pkgs.wl-clipboard
    pkgs.networkmanagerapplet
    pkgs.pipewire
    pkgs.wireplumber
    pkgs.xdg-desktop-portal-hyprland
    pkgs.leiningen

    pkgs.code-cursor

    pkgs.bundix
    pkgs.ruby

    # pkgs.IBMPlexMono
    pkgs.nerd-fonts.iosevka
    pkgs.nerd-fonts.iosevka-term

    pkgs.vagrant
    # pkgs.virt-manager
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  fonts.fontconfig.enable = true;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".zprint.edn".text = ''
      {:style :justified
       :width 120}
    '';
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/marinadj/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "vim";
  };
  catppuccin.flavor = "mocha";
  catppuccin.enable = true;

  programs.chromium = {
    enable = true;
    extensions = [
      { id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa"; } # 1password
      { id = "jdlkkmamiaikhfampledjnhhkbeifokk"; } # PDF Viewer
    ];
  };
  programs.git = {
    enable = true;
    extraConfig = {
      safe.directory = "/etc/nixos";
    };
    userName = "Marina Djordjevic";
    userEmail = "marina.guzvic@gmail.com";
  };

  programs.bash = {
    enable = true;
    sessionVariables = {
      TERM = "xterm-256color";
    };
    shellAliases = {
      ll = "ls -lahrt";
      ".." = "cd ..";

      # Git
      gm = "git commit -m";
      ga = "git add";
      gsr = "git reset --soft HEAD~1";
      gs = "git status";
      gpo = "git push origin";
      gcb = "git checkout -b";
      gsth = "git stash --keep-index";
      eni = "nvim /etc/nixos";
    };
  };

  programs.kitty = {

    keybindings = {
      "cmd+shift+t" = "new_tab_with_cwd";
    };
    enable = true;
  };

  services.dunst.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    nix-colors.homeManagerModules.default
    neovim-config.nixosModules.default
    ../../modules/home-manager/wayland/waybar.nix
  ];
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      disabled-extensions = "disabled";
      enabled-extensions = [
        # "pop-shell@system76.com"
        "forge@jmmaranan.com"
        "space-bar@luchrioh"
        "system-monitor@gnome-shell-extensions.gcampax.github.com"
        "hidetopbar@mathieu.bidon.ca"
        "notification-timeout@chlumskyvaclav.gmail.com"
      ];
    };
    "org/gnome/desktop/wm/keybindings" = {
      # activate-window-menu = "disabled";
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    configPackages = [
      pkgs.xdg-desktop-portal-gnome
    ];
  };

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

}
