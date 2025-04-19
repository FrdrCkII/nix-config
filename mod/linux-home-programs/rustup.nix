{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    rustup
  ];
  programs.zsh.profileExtra = ''
    export RUSTUP_UPDATE_ROOT=https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup
    export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup
    export PATH=$PATH:${config.home.homeDirectory}/.cargo/bin
  '';
  programs.bash.profileExtra = ''
    export RUSTUP_UPDATE_ROOT=https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup
    export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup
    export PATH=$PATH:${config.home.homeDirectory}/.cargo/bin
  '';
}
