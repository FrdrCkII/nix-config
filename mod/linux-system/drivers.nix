{ config, lib, pkgs, cfg, ... }:
{
  config = lib.mkMerge [
    # https://wiki.nixos.org/wiki/AMD_GPU
    # https://wiki.archlinuxcn.org/wiki/AMDGPU
    ( lib.mkIf (cfg.opt.drivers.amd) {
      environment.systemPackages = with pkgs; [
        lact
      ];
      systemd = {
        packages = with pkgs; [ lact ];
        services.lactd.wantedBy = ["multi-user.target"];
      };
    } )

    ( lib.mkIf (cfg.opt.drivers.nvidia) {
    } )

  ];
}
