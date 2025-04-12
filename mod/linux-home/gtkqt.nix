{ config, lib, pkgs, cfg, ... }:
{
  gtk = {
    enable = true;
    theme.name = "Breeze-Dark";
    theme.package = pkgs.kdePackages.breeze-gtk;
    iconTheme.name = "breeze-dark";
    cursorTheme.name = "breeze";
  };
  qt = {
    enable = true;
    style.name = "Breeze";
    style.package = pkgs.kdePackages.breeze;
  };
}
