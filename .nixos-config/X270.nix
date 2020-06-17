{ config, pkgs, lib, ... }:

{
  imports = [ ./shared.nix ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/8f87db4c-2dee-40aa-b7f0-05534052993e";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/23D5-5BC0";
      fsType = "vfat";
    };
  };

  boot = {
    initrd.luks.devices = {
      "crypto-root" = {
        device = "/dev/disk/by-uuid/08a570e2-2b1a-439d-9310-1ab87ae0f019";
        preLVM = true;
        allowDiscards = true;
      };
    };
    kernelModules = [ "kvm-intel" "acpi-call" ];
    kernelParams = [ "i915.enable_psr=0" ];
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
        DISK_APM_LEVEL_ON_AC="0 0"
        DISK_APM_LEVEL_ON_BAT="0 0"
        RESTORE_DEVICE_STATE_ON_STARTUP=1
      '';
    };
  };
}
