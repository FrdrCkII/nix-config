{ config, lib, pkgs, cfg, ... }:
{
  home.packages = with cfg.pkg.pkgs; [
    go-musicfox
  ];
  xdg.configFile."go-musicfox" = {
    source = cfg.lib.relativeToRoot "dot/${cfg.sys.config}/musicfox";
    recursive = true;
  };
}
