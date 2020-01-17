{ config, pkgs, lib, ... }:

let
  unstable = import (fetchTarball {
    url =
      "https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz";
  }) { config = config.nixpkgs.config; };
in {
  swapDevices = [{ device = "/swapfile"; }];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    # Use latest kernel package
    kernelPackages = pkgs.linuxPackages_latest;

    cleanTmpDir = true;
  };

  # Enable sound
  sound.enable = true;

  hardware = {
    # Enable all redistributable firmwares
    enableRedistributableFirmware = true;

    # Pulseaudio support
    pulseaudio = {
      enable = true;
      support32Bit = true;
      package = pkgs.pulseaudioFull;
    };

    # OpenGL support
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    # Enable support for controllers under steam
    steam-hardware.enable = true;
  };

  # Workaround for Lutris
  systemd.extraConfig = "DefaultLimitNOFILE=524288";
  security.pam.loginLimits = [{
    domain = "*";
    type = "hard";
    item = "nofile";
    value = "524288";
  }];

  networking = {
    # Use Network Manager
    networkmanager.enable = true;
  };

  # Internationalization properties
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set time zone
  time.timeZone = "US/Eastern";

  nix = {
    maxJobs = lib.mkDefault 4;
    useSandbox = true;
    autoOptimiseStore = true;
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 30d";
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    pulseaudio = true;

    #firefox = { enableAdobeFlash = true; };

    packageOverrides = pkgs: {
      iosevka-type = pkgs.iosevka.override {
        set = "type";
        design = [ "type" "ss08" ];
      };
      dwarf-fortress = pkgs.dwarf-fortress-packages.dwarf-fortress-full.override {
        theme = "taffer";
      };
    };
  };

  # Packages installed in system profile
  environment.systemPackages = with pkgs; [
    (aspellWithDicts (ps: with ps; [ en en-computers en-science ]))
    dwarf-fortress
    calibre
    chocolateDoom
    colordiff
    curl
    direnv
    discord
    exfat
    file
    firefox
    gimp
    gitAndTools.gitFull
    gnome3.eog
    gnome3.gnome-calculator
    gnome3.gnome-screenshot
    gnome3.gnome-tweaks
    gnome3.nautilus
    gnupg
    imagemagick
    libreoffice
    unstable.lutris
    manpages
    mgba
    mpv
    multimc
    nixfmt
    opera
    p7zip
    pass
    posix_man_pages
    qbittorrent
    slack
    spotify
    steam
    tdesktop
    texlive.combined.scheme-full
    tree
    unstable.emacs
    unzip
  ];

  # Let nautilus find extensions
  environment.variables.NAUTILUS_EXTENSION_DIR =
    "${config.system.path}/lib/nautilus/extensions-3.0";
  environment.pathsToLink = [ "/share/nautilus-python/extensions" ];

  # Get full man pages
  documentation.dev.enable = true;
  documentation.doc.enable = true;

  # Font settings
  fonts = {
    # Install a sane set of default fonts
    enableDefaultFonts = true;

    # Better font look
    fontconfig.ultimate.enable = true;

    # Extra fonts to install
    fonts = with pkgs; [ iosevka-type ];
  };

  # Programs to enable
  programs = {
    # Autostart the ssh-agent;
    ssh.startAgent = true;

    # Enable fish shell
    fish.enable = true;

    # Enable some graphical programs
    evince.enable = true;
    file-roller.enable = true;
    gnome-disks.enable = true;
    gnome-terminal.enable = true;
  };

  # Services to autostart
  services = {
    # CUPS printing support
    printing = {
      enable = true;
      drivers = with pkgs; [ hplipWithPlugin gutenprint ];
    };

    # Trim disks weekly
    fstrim.enable = true;

    # Use systemd-timesyncd to keep time
    timesyncd.enable = true;

    # Make sure my SSDs don't die without warning
    smartd = {
      enable = true;
      notifications.x11.enable = true;
    };

    # Enable syncthing
    syncthing = {
      enable = true;
      user = "jacob";
      dataDir = "/home/jacob/.syncthing";
      openDefaultPorts = true;
    };

    # X11
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome3.enable = true;
      xkbOptions = "ctrl:nocaps";
    };

    # Gnome3
    gnome3 = {
      core-shell.enable = true;
      core-utilities.enable = false;
      gnome-remote-desktop.enable = false;
    };
  };

  virtualisation = {
    # Enable docker
    #docker.enable = true;
  };

  # Define a user account
  users.extraUsers.jacob = {
    isNormalUser = true;
    uid = 1000;
    createHome = true;
    description = "Jacob Dillon";
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" "docker" "input" "video" ];
    initialPassword = "password";
  };

  # Change this only after the NixOS release notes say you should
  system.stateVersion = "19.09";
}
