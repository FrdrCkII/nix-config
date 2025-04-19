{ pkgs, cfg, ... }:
{
  home.packages = with pkgs; [
    flatpak
  ];
  programs.zsh.profileExtra = ''
    export XDG_DATA_DIRS=$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share
  '';
  programs.bash.profileExtra = ''
    export XDG_DATA_DIRS=$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share
  '';
}
