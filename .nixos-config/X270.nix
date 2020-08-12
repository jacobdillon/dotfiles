{ config, pkgs, lib, ... }:

{
  imports = [ ./shared.nix ];

  fileSystems = {
    "/" = {
      device = "/dev/mapper/crypto-root";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/3C79-AB5F";
      fsType = "vfat";
    };
  };

  boot = {
    initrd.luks.devices = {
      "crypto-root" = {
        device = "/dev/disk/by-uuid/11523d13-6f7e-4c97-951d-e5ea4f451564";
        preLVM = true;
        allowDiscards = true;
      };
    };
    kernelModules = [ "kvm-intel" "acpi-call" ];
    kernelParams = [ ];
  };

  hardware = {
    # Keep microcode up-to-date
    cpu.intel.updateMicrocode = true;

    # Trackpoint settings
    trackpoint = {
      enable = true;
      emulateWheel = true;
    };

    # acpilight
    acpilight.enable = true;

    opengl = {
      extraPackages = with pkgs; [
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
        intel-media-driver
      ];
    };
  };

  networking = {
    # Set hostname
    hostName = "X270";
  };

  services = {
    # Enable TLP
    tlp = {
      enable = true;
      extraConfig = ''
        RESTORE_DEVICE_STATE_ON_STARTUP=1
      '';
    };
  };
}
