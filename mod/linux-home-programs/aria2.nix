{ config, pkgs, lib, cfg, custom-lib, inputs, ... }:
{
  home.packages = [
    inputs.myrepo.packages."${cfg.sys.system}".aria2-fast
  ];
  home.file.".aria2" = {
    source = custom-lib.relativeToRoot "dot/${cfg.sys.config}/aria2";
    recursive = true;
  };
  systemd.user.services.aria2cd = {
    Unit = {
      Description = "Aria2 Daemon";
    };
    Service = {
      ExecStart = "/usr/bin/aria2c --conf-path=/home/${cfg.opt.users.user.name}/.aria2/aria2.conf";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
