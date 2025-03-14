{ config, lib, pkgs, cfg, ... }:
lib.mkMerge [
  # https://wiki.nixos.org/wiki/AMD_GPU
  # https://wiki.archlinuxcn.org/wiki/AMDGPU
  ( lib.optionals (builtins.elem "amd" cfg.opt.drivers) {
    environment.systemPackages = with pkgs; [
      lact
    ];
    systemd = {
      packages = with pkgs; [ lact ];
      services.lactd.wantedBy = ["multi-user.target"];
    };
  } )

  ( lib.optionals (builtins.elem "nvidia" cfg.opt.drivers) {
  } )

]
