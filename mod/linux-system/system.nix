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
        # 请自行创建如下的systemd单元文件
        # [Unit]
        # Description=Restart system-manager after /nix is mounted
        # Requires=nix.mount
        # After=nix.mount

        # [Service]
        # Type=oneshot
        # ExecStart=/usr/bin/systemctl start system-manager.target

        # [Install]
        # WantedBy=multi-user.target
        systemd.targets.system-manager.enable = false;
        environment.etc = {
          "systemd/system/system-manager.target".text = ''
            [Unit]
            Description=System Manager Service
            Requires=multi-user.target
            After=multi-user.target rescue.service rescue.target
            AllowIsolate=yes
          '';
          "systemd/system/default.target.wants/system-manager.target".text = ''
            [Unit]
            Description=System Manager Service
            Requires=multi-user.target
            After=multi-user.target rescue.service rescue.target
            AllowIsolate=yes
          '';
        };
    } )
    
  ];
}
