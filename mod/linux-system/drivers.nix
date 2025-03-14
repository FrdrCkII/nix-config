{ config, lib, pkgs, cfg, ... }:
{
  config = lib.mkMerge [
    # https://wiki.nixos.org/wiki/AMD_GPU
    # https://wiki.archlinuxcn.org/wiki/AMDGPU
    ( lib.mkIf (cfg.opt.drivers.amd) {
      environment.systemPackages = with pkgs; [
        lact
      ];
      systemd.services.lactd = {
        enable = true;
        unitConfig = {
          Description = "AMDGPU Control Daemon";
          After = [ "multi-user.target" ];
        };
        serviceConfig = {
          ExecStart = "${pkgs.lact}/bin/lact daemon";
          Nice = "-10";
          Restart = "on-failure";
        };
        wantedBy = [ "multi-user.target" ];
      };
    } )

    ( lib.mkIf (cfg.opt.drivers.nvidia) {
    } )

  ];
}
