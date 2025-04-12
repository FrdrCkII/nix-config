{ config, lib, pkgs, cfg, ... }:
{
  nixGL = {
    packages = cfg.pkg.nixgl
  };
}
