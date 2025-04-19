{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
    package = pkgs.zed-editor;
    extraPackages = with pkgs; [
      nixd nil
    ];
    userSettings = {
      icon_theme = "Zed (Default)";
      ui_font_size = 16;
      buffer_font_size = 16;
      theme = {
        mode = "system";
        light = "Ayu Dark";
        dark = "One Dark";
      };
      lsp = {
        rust-analyzer = {
          binary = {
            ignore_system_version = false;
          };
        };
        nixd = {
          settings = {
            diagnostic = {
              suppress = ["sema-extra-with"];
            };
          };
          initialization_options = {
            formatting = {
              command = ["nixfmt"];
            };
          };
        };
        nil = {
          settings = {
            diagnostics = {
              ignored = ["unused_binding"];
            };
          };
          initialization_options = {
            formatting = {
              command = ["nixfmt"];
            };
          };
        };
      };
      languages = {
        Nix = {
          language_servers = ["nixd" "!nil"];
        };
      };
    };
  };
}
