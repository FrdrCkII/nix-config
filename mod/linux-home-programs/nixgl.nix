{ lib, pkgs, cfg, nixgl, ... }:
lib.mkMerge [
  {
    nixGL.packages = import nixgl { inherit pkgs; };
    nixGL.vulkan.enable = true;
  }

  ( lib.mkIf (cfg.opt.drivers.amd) {
    nixGL.defaultWrapper = "mesa";
    nixGL.installScripts = [ "mesa" ];
  } )

  ( lib.mkIf (cfg.opt.drivers.nvidia) {
    nixGL.defaultWrapper = "nvidia";
    nixGL.installScripts = [ "nvidia" ];
  } )

]
