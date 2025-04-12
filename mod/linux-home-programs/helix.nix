{ config, lib, pkgs, cfg, ... }:
{
  home.packages = with pkgs; [
    helix
  ];
  xdg.configFile."helix" = {
    source = cfg.lib.relativeToRoot "dot/${cfg.sys.config}/helix";
    recursive = true;
  };
}
