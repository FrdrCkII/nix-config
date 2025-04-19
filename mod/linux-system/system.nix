{ lib, pkgs, cfg, ... }:
{
  config = lib.mkMerge [
    {
      nixpkgs.hostPlatform = cfg.sys.system;
      system-manager.allowAnyDistro = true;
      environment = {
        systemPackages = with pkgs; [ git vim curl wget ]
        ++ cfg.opt.system-manager.packages;
        etc."hostname".text = "${cfg.sys.host}";
      };
    }
  ];
}
