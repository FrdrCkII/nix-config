{ config, lib, pkgs, cfg, ... }:
{
  home.packages = with cfg.pkg.pkgs; [
    zsh zimfw
    fzf fd bat
  ];
  home.file.".config/zsh/.zimrc".source = cfg.lib.relativeToRoot "dot/${cfg.sys.config}/zsh/zimrc";
  programs = {
    fd = {
      enable = true;
      hidden = true;
    };
    bat = {
      enable = true;
      config = {
        pager = "less -FR";
        theme = "catppuccin-mocha";
      };
      # themes = {
      #   # https://raw.githubusercontent.com/catppuccin/bat/main/Catppuccin-mocha.tmTheme
      #   catppuccin-mocha = {
      #     src =  	cfg.pkg.nur.repos.ryan4yin.catppuccin-alacritty;
      #     file = "Catppuccin-mocha.tmTheme";
      #   };
      # };
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "fd --type f";
      defaultOptions = [
        "--height 40%"
        "--border"
        "--layout reverse"
        "--preview 'bat --color=always {}'"
        "--bind 'ctrl-/:change-preview-window(50%|hidden|)'"
      ];
      colors = {
        "bg+" = "#313244";
        "bg" = "#1e1e2e";
        "spinner" = "#f5e0dc";
        "hl" = "#f38ba8";
        "fg" = "#cdd6f4";
        "header" = "#f38ba8";
        "info" = "#cba6f7";
        "pointer" = "#f5e0dc";
        "marker" = "#f5e0dc";
        "fg+" = "#cdd6f4";
        "prompt" = "#cba6f7";
        "hl+" = "#f38ba8";
      };
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      enableVteIntegration = true;
      dotDir = ".config/zsh";
      initExtra = lib.mkMerge [
        (''
          ZIM_HOME=~/.config/zsh
          # Install missing modules and update ''${ZIM_HOME}/init.zsh if missing or outdated.
          if [[ ! ''${ZIM_HOME}/init.zsh -nt ''${ZIM_CONFIG_FILE:-''${ZDOTDIR:-''${HOME}}/.zimrc} ]]; then
            source ${cfg.pkg.pkgs.zimfw}/zimfw.zsh init
          fi
          # Initialize modules.
          source ''${ZIM_HOME}/init.zsh
        '')
        (''
          export FZF_COMPLETION_TRIGGER='\'
          # Use fd (https://github.com/sharkdp/fd) for listing path candidates.
          # - The first argument to the function ($1) is the base path to start traversal
          # - See the source code (completion.{bash,zsh}) for the details.
          _fzf_compgen_path() {
            fd --follow --exclude ".git" . "$1"
          }
          # Use fd to generate the list for directory completion
          _fzf_compgen_dir() {
            fd --type d --follow --exclude ".git" . "$1"
          }
        '')
      ];
    };
    bash = {
      enable = true;
      enableCompletion = true;
      initExtra = ''
        # chsh -s ${cfg.pkg.pkgs.zsh}/bin/zsh ${cfg.opt.users.user.name}
        exec zsh
        # zsh
      '';
    };
  };
}