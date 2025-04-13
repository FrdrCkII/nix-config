{ config, lib, pkgs, cfg, ... }:
{
  home.file.".aria2" = {
    source = cfg.lib.relativeToRoot "dot/${cfg.sys.config}/aria2";
    recursive = true;
  };
  home.packages = with pkgs; [
    ariang
  ];
  systemd.user.services.aria2cd = {
    Unit = {
      Description = "Aria2 Daemon";
    };
    Service = {
      ExecStart = "${pkgs.myrepo.aria2-fast}/bin/aria2c --conf-path=/home/${cfg.opt.users.user.name}/.aria2/aria2.conf";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
  programs.aria2 = {
    enable = true;
    package = pkgs.myrepo.aria2-fast;
  };
}
