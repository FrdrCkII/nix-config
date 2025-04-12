{ config, lib, pkgs, cfg, ... }:
{
  home.packages = with pkgs; [
    ghostty
  ];
  xdg.configFile."ghostty" = {
    source = cfg.lib.relativeToRoot "dot/${cfg.sys.config}/ghostty";
    recursive = true;
  };
}
