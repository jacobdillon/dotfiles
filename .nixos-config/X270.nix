{ config, pkgs, lib, ... }:

{
  imports = [ ./shared.nix ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/4c40f7bf-718a-427b-854d-7fb13571673b";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/0267-FFFC";
      fsType = "vfat";
    };
  };

  boot = {
    initrd.luks.devices = [{
      name = "crypto-root";
      device = "/dev/disk/by-uuid/4d1d3f4b-fc6b-4ee3-bf6e-a27da68d8866";
      preLVM = true;
      allowDiscards = true;
    }];
    kernelModules = [ "kvm-intel" "acpi-call" ];
  };

  hardware = {
    # Keep microcode up-to-date
    cpu.intel.updateMicrocode = true;

    # Trackpoint settings
    trackpoint = {
      enable = true;
      emulateWheel = true;
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
        DISK_APM_LEVEL_ON_AC="0 0"
        DISK_APM_LEVEL_ON_BAT="0 0"
        RESTORE_DEVICE_STATE_ON_STARTUP=1
      '';
    };
  };
}
