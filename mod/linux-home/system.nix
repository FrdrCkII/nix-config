{ config, lib, pkgs, cfg, ... }:
lib.mkMerge [
  {
    programs.home-manager.enable = true;
    home = {
      username = cfg.opt.users.user.name;
      homeDirectory = "/home/${cfg.opt.users.user.name}";
      stateVersion = cfg.opt.home-manager.version;
      packages = with pkgs; []
      ++ cfg.opt.home-manager.packages;
    };
  }

  ( lib.mkIf (cfg.sys.type == "linux") {
    targets.genericLinux.enable = true;
  } )
]
