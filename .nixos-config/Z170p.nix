{ config, pkgs, lib, ... }:

{
  imports = [ ./shared.nix ];
 
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/af47febf-22c2-4596-8f01-aa889953dc9e";
      fsType = "ext4";
    };
    
    "/boot" = {
      device = "/dev/disk/by-uuid/DD7C-5EEA";
      fsType = "vfat";
    };
    
    "/run/media/jacob/hdd" = {
      device = "/dev/disk/by-uuid/3ff621dc-4a28-465f-b492-f96df234641f";
      fsType="ext4";
    };
  };
  
  boot = {
    kernelModules = [ "kvm-intel" ];
  };

  hardware = {
    # Keep microcode up-to-date
    cpu.intel.updateMicrocode = true;
  };

  networking = {
    # Set hostname
    hostName = "Z170p";
  };
}
