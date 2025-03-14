{ config, lib, pkgs, cfg, ... }:
lib.mkMerge [
  # https://wiki.nixos.org/wiki/AMD_GPU
  # https://wiki.archlinuxcn.org/wiki/AMDGPU
  ( lib.mkIf (cfg.opt.drivers.amd) {
    home.packages = with pkgs; [
      lact
    ];
  } )

  ( lib.mkIf (cfg.opt.drivers.nvidia) {
  } )

]
