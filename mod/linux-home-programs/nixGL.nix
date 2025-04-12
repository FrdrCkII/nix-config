{ config, lib, pkgs, cfg, ... }:
{
  # nixGL = {
  #   enable = true;
  #   packages = cfg.pkg.nixGL.package;
  # };
  home.packages = cfg.pkg.nixGL.auto.nixGL;
}
