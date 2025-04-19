{ config, lib, pkgs, cfg, ... }:
{
  home.packages = with pkgs; [
    rustup
  ];
  programs.zsh.initExtra = lib.mkMerge [
    (''
      export RUSTUP_UPDATE_ROOT=https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup
      export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup
      export PATH=$PATH:${config.home.homeDirectory}/.cargo/bin
    '')
  ];
  programs.bash.initExtra = lib.mkMerge [
    (''
      export RUSTUP_UPDATE_ROOT=https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup
      export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup
      export PATH=$PATH:${config.home.homeDirectory}/.cargo/bin
    '')
  ];
}
