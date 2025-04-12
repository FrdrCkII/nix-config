{ config, lib, pkgs, cfg, ... }:
{
  programs.helix = {
    enable = true;
    settings = {
      theme = "snazzy";
      editor = {
        rulers = [72 80];
      };
    };
    languages.language = [{
      name = "nix";
      auto-format = true;
      formatter.command = lib.getExe pkgs.nixfmt-rfc-style;
    }];
  };
}
