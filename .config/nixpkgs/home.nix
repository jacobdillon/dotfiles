{ config, pkgs, ... }:

let unstable = import <nixpkgs-unstable> { };
in {
  home.packages = with pkgs; [
    audacity
    curl
    direnv
    discord
    gimp
    evince
    iosevka
    libreoffice
    magic-wormhole
    multimc
    nix-prefetch-scripts
    nixfmt
    pavucontrol
    qbittorrent
    ripgrep
    sc-controller
    spotify
    steam
    tdesktop
    texlive.combined.scheme-medium
    unstable.dwarf-fortress
    unstable.kepubify
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

  gtk.theme.package = pkgs.equilux-theme;

  services = {
    dbus.packages = with pkgs; [ gnome3.dconf ];

    gnome-keyring.enable = true;

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

    gnome-terminal = {
      enable = true;
      profile.default = {
        default = true;
        visibleName = "default";
        font = "DejaVu Sans Mono";
      };
      showMenubar = false;
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
