{ config, pkgs, ... }:

let unstable = import <nixpkgs-unstable> { };
in {
  imports = [ ./modules/dwm ./modules/st ./modules/dmenu ];

  home.packages = with pkgs; [
    audacity
    curl
    kdenlive
    youtube-dl
    (vlc.override { chromecastSupport = true; })
    ffmpeg
    scrot
    toilet
    direnv
    discord
    gimp
    libreoffice
    magic-wormhole
    multimc
    nix-prefetch-scripts
    nixfmt
    pavucontrol
    pfetch
    qbittorrent
    ripgrep
    sc-controller
    spotify
    steam
    tamsyn
    tdesktop
    texlive.combined.scheme-full
    unstable.dwarf-fortress
    unstable.kepubify 
  ];

  xsession = {
    enable = true;
    windowManager.my-dwm.enable = true;
    scriptPath = ".hm-xsession";
    initExtra = ''
      ${pkgs.hsetroot}/bin/hsetroot -fill ~/pictures/wallpapers/lain_noise.png &
      ${pkgs.lightlocker}/bin/light-locker --lock-on-lid --lock-on-suspend &
    '';   
  };

  home.keyboard.options = [ "crtl:nocaps" ];
  
  xdg.userDirs = {
    enable = true;
    desktop = "~/.desktop";
    documents = "~/documents";
    download = "~/downloads";
    music = "~/music";
    pictures = "~/pictures";
    publicShare = "~/documents/public";
    templates = "~/documents/templates";
    videos = "~/videos";
  };

  fonts.fontconfig.enable = true;

  services = {
    gnome-keyring.enable = true;

    dunst = {
      enable = true;
      settings = {
        global = {
          geometry = "250x100-20+32";
          transparency = 90;
          font = "Tamsyn 12";
        };
      };
    };

    dwm-status = {
      enable = true;
      order = [ "audio" "network" "battery" "time"];
      extraConfig = {
        separator = " - ";
        time = {
          format = "%a, %b %d %H:%M";
        };
        battery = {
          charging = "bat charging";
          discharging = "bat discharging";
          separator = "/";
        };
        network = {
          no_value = "no network";
          template = "net: {ESSID}";
        };
        audio = {
          template = "vol: {VOL}%";
        };
      };
    };

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

    zathura = {
      enable = true;
      options = { default-bg = "#000000"; default-fg = "#d2738a"; };
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
