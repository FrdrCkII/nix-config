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
        # 修复 https://github.com/numtide/system-manager/issues/170
        systemd.services.system-manager-restart = {
          enable = true;
          description = "Restart system-manager after /nix is mounted";
          after = [ "nix.mount" ];
          requires = [ "nix.mount" ];
          serviceConfig = {
            ExecStart = "/usr/bin/systemctl start system-manager.target";
            Type = "oneshot";
          };
          wantedBy = [ "multi-user.target" ];
        };
    } )
    
  ];
}
