{ config, lib, pkgs, cfg, ... }:
{
  xdg = {
    enable = true;
    configHome = "~/.config";
    userDirs = {
      enable = true;
      desktop = "${config.home.homeDirectory}/_des";
      documents = "${config.home.homeDirectory}/_doc";
      download = "${config.home.homeDirectory}/_dow";
      music = "${config.home.homeDirectory}/_mus";
      pictures = "${config.home.homeDirectory}/_pic";
      publicShare = "${config.home.homeDirectory}/_pub";
      templates = "${config.home.homeDirectory}/_tem";
      videos = "${config.home.homeDirectory}/_vid";
      extraConfig = {
        XDG_MISC_DIR = "${config.home.homeDirectory}/_mis";
      };
    };
  };
}
