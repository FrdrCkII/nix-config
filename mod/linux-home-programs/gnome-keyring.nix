{ config, lib, pkgs, cfg, ... }:
{
  services.gnome-keyring.enable = true;
  home.packages = with pkgs; [
    seahorse
  ];
}
