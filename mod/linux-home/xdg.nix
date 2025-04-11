{ config, lib, pkgs, cfg, ... }:
{
  xdg.configFile."user-dirs.dirs" = {
    source = cfg.lib.relativeToRoot "dot/${cfg.sys.config}/xdg/user-dirs.dirs";
    recursive = true;
  };
  xdg.configFile."user-dirs.locale" = {
    source = cfg.lib.relativeToRoot "dot/${cfg.sys.config}/xdg/user-dirs.locale";
    recursive = true;
  };
}
