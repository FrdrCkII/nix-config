{ config, pkgs, lib, cfg, ... }: 
{
  config = lib.mkMerge [
    {
      nixpkgs.hostPlatform = cfg.sys.system;
      environment = {
        systemPackages = with pkgs; []
        ++ cfg.opt.system-manager.packages;
        etc."hostname".text = "${cfg.sys.host}\n";
      };
    }

    ( lib.mkIf (cfg.sys.type == "linux") {
        system-manager.allowAnyDistro = true;
    } )
    
  ];
}
