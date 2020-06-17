{ config, pkgs, ... }:

let unstable = import <nixpkgs-unstable> { };
in {
  imports = [ ./modules/2bwm ];

  nixpkgs.overlays = [
    (self: super: {
      st = super.st.override {
        conf = builtins.readFile ./modules/st/config.h;
        patches = builtins.map super.fetchurl [
          {
            url =
              "https://st.suckless.org/patches/scrollback/st-scrollback-0.8.2.diff";
            sha256 = "0rnigxkldl22dwl6b1743dza949w9j4p1akqvdxl74gi5z7fsnlw";
          }
          {
            url =
              "https://st.suckless.org/patches/anysize/st-anysize-0.8.1.diff";
            sha256 = "03z5vvajfbkpxvvk394799l94nbd8xk57ijq17hpmq1g1p2xn641";
          }
        ];
      };
      dmenu = super.dmenu.override {
        patches = builtins.map super.fetchurl [{
          url =
            "https://tools.suckless.org/dmenu/patches/line-height/dmenu-lineheight-4.9.diff";
          sha256 = "0v609mmz3i5dlfdf4b8wcp48njxp1i5g5vy7phw3zg1wn936yzsg";
        }];
      };
      spotifyd = unstable.spotifyd.override {
        withPulseAudio = true;
        withMpris = true;
      };
    })
  ];

  home.packages = with pkgs; [
    audacity
    curl
    direnv
    discord
    gimp
    go-font
    iosevka
    libreoffice
    magic-wormhole
    multimc
    neofetch
    nix-prefetch-scripts
    nixfmt
    pavucontrol
    qbittorrent
    ripgrep
    sc-controller
    siji
    spotify
    steam
    tamsyn
    tdesktop
    texlive.combined.scheme-medium
    unar
    unstable.dwarf-fortress
    unstable.kepubify
    unstable.spotify-tui
  ];

  xdg.userDirs = {
    enable = true;
    desktop = "~/.desktop";
    documents = "~/documents";
    download = "~/downloads";
    music = "~/music";
    pictures = "~/pictures";
    publicShare = "~/.public";
    templates = "~/.templates";
    videos = "~/videos";
  };
 
  fonts.fontconfig.enable = true;

  xsession = {
    enable = true;
    initExtra = ''
      ${pkgs.hsetroot}/bin/hsetroot -fill ~/pictures/wallpapers/fainfinity.jpg &
    '';
    windowManager.my-2bwm.enable = true;
    scriptPath = ".hm-xsession";
  };

  services = {
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      defaultCacheTtl = 86400;
      defaultCacheTtlSsh = 86400;
    };
    sxhkd = {
      enable = true;
      keybindings = {
        "super + Return" = "${pkgs.st}/bin/st";
        "super + space" =
          "${pkgs.dmenu}/bin/dmenu_run -fn 'Tamsyn:style=Regular:size=16' -nb '#191919' -nf '#fffae8' -sb '#4d9ea1' -h 48";
        "super + Escape" = "slock";
        "XF86Audio{Lower,Raise}Volume" =
          "${pkgs.pulseaudio-ctl}/bin/pulseaudio-ctl {down,up} 5";
        "XF86AudioMute" = "${pkgs.pulseaudio-ctl}/bin/pulseaudio-ctl mute";
        "XF86AudioMicMute" =
          "${pkgs.pulseaudio-ctl}/bin/pulseaudio-ctl mute-input";
        "XF86MonBrightness{Down,Up}" =
          "${pkgs.xorg.xbacklight}/bin/xbacklight -{dec,inc} 10";
        "Print" =
          "${pkgs.maim}/bin/maim ~/pictures/screenshots/$(${pkgs.coreutils}/bin/date +%s).png";
        "Print + Shift" =
          "${pkgs.maim}/bin/maim -i $(${pkgs.xdotool}/bin/xdotool getactivewindow) ~/pictures/screenshots/$(${pkgs.coreutils}/bin/date +%s).png";
        "Print + Control" =
          "${pkgs.maim}/bin/maim -s ~/pictures/screenshots/$(${pkgs.coreutils}/bin/date +%s).png";
      };
    };

    #password-store-sync.enable = true;

    spotifyd = {
      enable = false;
      settings = {
        global = {
          username = "jad340";
          password_cmd = "${pkgs.pass}/bin/pass spotify/jad340";
          backend = "pulseaudio";
          bitrate = "320";
          volume_normalisation = "false";
          device_name = "X270";
        };
      };
    };

    picom = {
      enable = true;
      shadow = true;
      vSync = true;
      shadowExclude = [ "name = 'Dmenu'" ];
    };

    polybar = {
      enable = true;
      package = (pkgs.polybar.override {
        iwSupport = true;
        nlSupport = false;
        pulseSupport = true;
      });
      script = "polybar main &";
      config = {
        "color" = {
          background = "#191919";
          foreground = "#fffae8";
          red = "#bb2222";
          orange = "#fb7280";
          yellow = "#ffff66";
          brown = "#8c7564";
          green = "#559955";
          cyan = "#4d9ea1";
          blue = "#0083b1";
          magenta = "#aa3377";
          white = "#9daeb2";
        };
        "bar/main" = {
          monitor = "eDP-1";
          width = "100%";
          height = "48";
          module-margin = 1;
          padding = 1;
          line-size = 7;
          background = "\${color.background}";
          foreground = "\${color.foreground}";
          font-0 = "Tamsyn:style=Regular:size=16;2";
          font-1 = "Siji:style=Regular:size=16;2";
          font-2 = "Go Mono:style=Regular:size=14;2";
          modules-left = "title";
          modules-right = "spotify network volume battery date";
        };
        "module/workspaces" = {
          type = "internal/xworkspaces";
          format-background = "\${color.green}";
        };
        "module/title" = {
          type = "internal/xwindow";
          label-maxlen = 50;
          format-padding = 2;
        };
        "module/spotify" = {
          type = "custom/script";
          interval = 5;
          format-prefix = " ";
          format = "<label>";
          label-maxlen = 50;
          format-padding = 2;
          format-background = "\${color.magenta}";
          format-overline = "\${color.background}";
          format-underline = "\${color.background}";
          exec = "${
              pkgs.writeScriptBin "polybar-playerctl" ''
                STATUS=$(${pkgs.playerctl}/bin/playerctl status 2> /dev/null)
                if [ "$STATUS" = "Playing" -o "$STATUS" = "Paused" ]; then
                  echo "$(${pkgs.playerctl}/bin/playerctl metadata artist)" - "$(${pkgs.playerctl}/bin/playerctl metadata title)"
                fi
              ''
            }/bin/polybar-playerctl";
        };
        "module/network" = {
          type = "internal/network";
          interface = "wlp3s0";
          label-connected = "%essid%";
          label-disconnected = "not connected";
          format-connected = "<ramp-signal> <label-connected>";
          format-disconnected = " <label-disconnected>";
          format-connected-background = "\${color.brown}";
          format-disconnected-background = "\${color.brown}";
          format-connected-padding = 2;
          format-disconnected-padding = 2;
          format-connected-overline = "\${color.background}";
          format-connected-underline = "\${color.background}";
          format-disconnected-overline = "\${color.background}";
          format-disconnected-underline = "\${color.background}";
          ramp-signal-0 = "";
          ramp-signal-1 = "";
          ramp-signal-2 = "";
          ramp-signal-3 = "";
          ramp-signal-4 = "";
          ramp-signal-5 = "";
        };
        "module/volume" = {
          type = "internal/pulseaudio";
          use-ui-max = false;
          label-muted = " %percentage%%";
          format-volume = "<ramp-volume> <label-volume>";
          format-volume-padding = 2;
          format-muted-padding = 2;
          format-volume-background = "\${color.red}";
          format-muted-background = "\${color.red}";
          format-volume-overline = "\${color.background}";
          format-volume-underline = "\${color.background}";
          format-muted-overline = "\${color.background}";
          format-muted-underline = "\${color.background}";
          ramp-volume-0 = "";
          ramp-volume-1 = "";
          ramp-volume-3 = "";
        };
        "module/battery" = {
          type = "custom/script";
          interval = 10;
          format-padding = 2;
          format-background = "\${color.blue}";
          format-overline = "\${color.background}";
          format-underline = "\${color.background}";
          exec = "${
              pkgs.writeScriptBin "battery" ''
                AC=$(${pkgs.coreutils}/bin/cat "/sys/class/power_supply/AC/online")
                BAT0=$(${pkgs.coreutils}/bin/cat "/sys/class/power_supply/BAT0/capacity")
                BAT1=$(${pkgs.coreutils}/bin/cat "/sys/class/power_supply/BAT1/capacity")
                BATC=$(("BAT0" + "BAT1"))
                BATP=$(("BATC" / 2))
                if [ "$AC" -eq 1 ]; then
                  ICON=""            
                else
                  if [ "$BATP" -gt 80 ]; then
                    ICON=""
                  elif [ "$BATP" -gt 30 ]; then
                    ICON=""
                  else
                    ICON=""
                  fi
                fi
                echo "$ICON $BATP%"
              ''
            }/bin/battery";
        };
        "module/date" = {
          type = "internal/date";
          date = "%A, %B %d, %Y";
          time = "%I:%M %p";
          label = " %date% %time%";
          format-padding = 2;
          format-background = "\${color.green}";
          format-overline = "\${color.background}";
          format-underline = "\${color.background}";
        };
      };
    };

    dunst = { enable = true; };

    syncthing.enable = true;

    lorri.enable = true;
  };

  programs = {
    home-manager = { enable = true; };

    gpg = { enable = true; };

    password-store = { enable = true; };

    emacs = { enable = true; };

    firefox.enable = true;

    mpv.enable = true;

    git = {
      enable = true;
      userName = "jacobdillon";
      userEmail = "jepityr@protonmail.com";
    };

    fish = {
      enable = true;
      promptInit = builtins.readFile (pkgs.fetchFromGitHub {
        owner = "oh-my-fish";
        repo = "theme-eclm";
        rev = "bd9abe5c5d0490a0b16f2aa303838a2b2cc98844";
        sha256 = "051wzwn4wr53mq27j1hra7y84y3gyqxgdgg2rwbc5npvbgvdkr09";
      } + "/fish_prompt.fish");
      plugins = [{
        name = "foreign-env";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-foreign-env";
          rev = "dddd9213272a0ab848d474d0cbde12ad034e65bc";
          sha256 = "00xqlyl3lffc5l0viin1nyp819wf81fncqyz87jx8ljjdhilmgbs";
        };
      }];
      interactiveShellInit = ''
        fenv source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
        eval (${pkgs.direnv}/bin/direnv hook fish)
        tput smkx
      '';
      functions = {
        dotfiles =
          "/usr/bin/env git --git-dir=$HOME/.dotfiles --work-tree=$HOME $argv";
      };
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.03";
}
