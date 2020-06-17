{ config, lib, pkgs, ... }:

let
  my-2bwm = pkgs._2bwm.overrideAttrs (_: {
    configurePhase = "cp ${./config.h} config.h";
  });
in {
  options.xsession.windowManager.my-2bwm = {
    enable = lib.mkEnableOption "enable";
  };

  config = lib.mkIf config.xsession.windowManager.my-2bwm.enable {
    home.packages = [ my-2bwm ];
    xsession.windowManager.command = "${my-2bwm}/bin/2bwm";
  };
}
