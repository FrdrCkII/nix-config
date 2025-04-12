{ config, lib, pkgs, cfg, ... }:
{
  gtk = {
    enable = true;
    theme.name = "Breeze-Dark";
    theme.package = with pkgs; [
      kdePackages.breeze-gtk
    ];
    iconTheme.name = "breeze-dark";
    cursorTheme.name = "breeze";
  };
  qt = {
    enable = true;
    style.name = "Breeze";
    style.package = with pkgs; [
      kdePackages.breeze
      kdePackages.breeze-icons
    ];
  };
}
