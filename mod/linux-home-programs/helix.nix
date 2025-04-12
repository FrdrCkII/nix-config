{ config, lib, pkgs, cfg, ... }:
{
  programs.helix = {
    enable = true;
    settings = {
      theme = snazzy;
      editor = {
        rulers = [72,80];
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
    };
    languages.language = [{
      name = "nix";
      auto-format = true;
      formatter.command = lib.getExe pkgs.nixfmt-rfc-style;
    }];
  };
}
