{ config, lib, pkgs, cfg, ... }:
{
  xdg.configFile."niri" = {
    source = cfg.lib.relativeToRoot "dot/${cfg.sys.config}/niri";
    recursive = true;
  };
}
