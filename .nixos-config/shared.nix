{ config, pkgs, lib, ... }:

{
  swapDevices = [{ device = "/swapfile"; }];

  boot = {
    # Use systemd-boot bootloader
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    # Use latest kernel package
    kernelPackages = pkgs.linuxPackages_latest;

    # Clean /tmp/ on boot
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

  networking = {
    # Use Network Manager
    networkmanager.enable = true;
  };

  # Internationalization properties
  i18n = { defaultLocale = "en_US.UTF-8"; };

  # Set time zone
  time.timeZone = "US/Eastern";

  nix = {
    maxJobs = lib.mkDefault 5;
    useSandbox = true;
    autoOptimiseStore = true;
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    pulseaudio = true;
  };

  # Programs to enable
  programs = {
    # Autostart the ssh-agent;
    ssh.startAgent = true;

    # Enable fish
    fish.enable = true;

    # Enable slock
    slock.enable = true;
  };

  # Services to autostart
  services = {
    # CUPS printing support
    printing = {
      enable = true;
      drivers = with pkgs; [ hplipWithPlugin ];
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

    # X11
    xserver = {
      enable = true;
      displayManager.lightdm = { enable = true; };
      desktopManager.session = [{
        name = "home-manager";
        start = ''
          ${pkgs.runtimeShell} $HOME/.hm-xsession &
          waitPID=$!
        '';
      }];
      libinput.enable = true;
      xkbOptions = "ctrl:nocaps";
      xautolock = {
        enable = true;
        locker = "${pkgs.slock}/bin/slock";
      };
    };
  };

  # Define a user account
  users.extraUsers.jacob = {
    isNormalUser = true;
    createHome = true;
    description = "Jacob Dillon";
    extraGroups = [ "wheel" "networkmanager" "input" "video" ];
    shell = pkgs.fish;
    initialPassword = "password";
  };

  # Change this only after the NixOS release notes say you should
  system.stateVersion = "20.03";
}
