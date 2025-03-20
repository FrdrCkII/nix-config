{ config, lib, pkgs, cfg, ... }:
{
  config = lib.mkMerge [
    {
      nixcfg.pkg.pkgs.hostPlatform = cfg.sys.system;
      environment = {
        systemPackages = with cfg.pkg.pkgs; []
        ++ cfg.opt.system-manager.packages;
        etc."hostname".text = "${cfg.sys.host}\n";
      };
    }

    ( lib.mkIf (cfg.sys.type == "linux") {
      system-manager.allowAnyDistro = true;
    } )
    
  ];
}
