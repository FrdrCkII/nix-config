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

      # 方法一 创建如下的systemd单元文件
      # [Unit]
      # Description=Restart system-manager after /nix is mounted
      # Requires=nix.mount
      # After=nix.mount

      # [Service]
      # Type=oneshot
      # ExecStart=/usr/bin/systemctl start system-manager.target

      # [Install]
      # WantedBy=multi-user.target
      # 问题：arch环境下会提示system-manager.target不存在

      # 方法二 覆盖system-manager.target设置
      # systemd.targets.system-manager = {
      #   wantedBy = [ "multi-user.target" ];
      #   after = [ "nix-daemon.service" ];
      # };
      # 问题：同上

      # 方法三 弃用system-manager.target和system-manager-path.service
      # systemd.targets.system-manager.enable = lib.mkForce false;
      # systemd.services.system-manager-path.enable = lib.mkForce false;
      systemd.services.system-manager-path-replace = {
        enable = true;
        description = "";
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
        };
        script =
          let
            pathDir = "/run/system-manager/sw";
            pathDrv = pkgs.buildEnv {
              name = "system-manager-path";
              paths = config.environment.systemPackages;
              inherit (config.environment) pathsToLink;
            };
          in
          ''
            mkdir --parents $(dirname "${pathDir}")
            if [ -L "${pathDir}" ]; then
              unlink "${pathDir}"
            fi
            ln --symbolic --force "${pathDrv}" "${pathDir}"
          '';
      };
    } )
    
  ];
}
