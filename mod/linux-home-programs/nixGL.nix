{ config, lib, pkgs, cfg, ... }:
{
  nixGL = {
    enable = true;
    packages = inputs.nixGL.package;
  };
}
