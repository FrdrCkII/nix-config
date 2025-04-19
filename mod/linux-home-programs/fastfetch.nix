{ config, lib, pkgs, cfg, ... }:
{
  home.packages = with pkgs; [
    fastfetch
  ];
  xdg.configFile."fastfetch" = {
    source = cfg.lib.relativeToRoot "dot/${cfg.sys.config}/fastfetch";
    recursive = true;
  };
}
