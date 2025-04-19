{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    rustup
  ];
  programs.zsh.initExtra = ''
    export RUSTUP_UPDATE_ROOT=https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup
    export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup
    export PATH=$PATH:${config.home.homeDirectory}/.cargo/bin
  '';
  programs.bash.initExtra = ''
    export RUSTUP_UPDATE_ROOT=https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup
    export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup
    export PATH=$PATH:${config.home.homeDirectory}/.cargo/bin
  '';
}
