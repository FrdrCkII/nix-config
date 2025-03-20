{ config, lib, pkgs, cfg, ... }:
{
  config = lib.mkMerge [
    {
      nixcfg.pkg.pkgs.hostPlatform = cfg.sys.system;
      system-manager.allowAnyDistro = true;
      environment = {
        systemPackages = with cfg.pkg.pkgs; []
        ++ cfg.opt.system-manager.packages;
        etc."hostname".text = "${cfg.sys.host}";
      };
    }
  ];
}
