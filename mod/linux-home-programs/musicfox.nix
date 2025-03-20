{ config, lib, pkgs, cfg, ... }:
{
  home.packages = with pkgs; [
    go-musicfox
  ];
  xdg.configFile."go-musicfox" = {
    source = cfg.lib.relativeToRoot "dot/${cfg.sys.config}/musicfox";
    recursive = true;
  };
}
