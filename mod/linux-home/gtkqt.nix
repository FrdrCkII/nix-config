{ config, lib, pkgs, cfg, ... }:
{
  gtk = {
    enable = true;
    theme.name = "Breeze-Dark";
    theme.package = pkgs.kdePackages.breeze-gtk;
    iconTheme.name = "breeze-dark";
    cursorTheme.name = "breeze";
    gtk3.extraConfig = {
      gtk-im-module = "fcitx";
    };
    gtk4.extraConfig = {

    };
  };
  qt = {
    enable = true;
    platformTheme.name = "kde6";
    style.name = "Breeze";
    style.package = with pkgs; [
      kdePackages.breeze
      kdePackages.breeze-icons
    ];
  };
}
