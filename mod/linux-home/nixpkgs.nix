{ config, lib, pkgs, cfg, ... }:
{
  nixpkgs = {
    pkgs = cfg.pks.pkgs;
  };
  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = [
        "flakes"
        "nix-command"
        "ca-derivations"
      ];
      substituters = [
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://cache.nixos.org"
      ];
    };
  };
}
