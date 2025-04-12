{ config, lib, pkgs, cfg, ... }:
{
  home.packages = [
    cfg.pkg.myrepo.aria2-fast
  ];
  home.file.".aria2" = {
    source = cfg.lib.relativeToRoot "dot/${cfg.sys.config}/aria2";
    recursive = true;
  };
  systemd.user.services.aria2cd = {
    Unit = {
      Description = "Aria2 Daemon";
    };
    Service = {
      ExecStart = "${cfg.pkg.myrepo.aria2-fast}/bin/aria2c --conf-path=/home/${cfg.opt.users.user.name}/.aria2/aria2.conf";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
