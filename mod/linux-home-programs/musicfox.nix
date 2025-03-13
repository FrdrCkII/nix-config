{ config, pkgs, lib, cfg, ... }:
{
  home.packages = with pkgs; [
    go-musicfox
  ];
  xdg.configFile."go-musicfox" = {
    source = custom-lib.relativeToRoot "dot/${cfg.sys.config}/musicfox";
    recursive = true;
  };
}
