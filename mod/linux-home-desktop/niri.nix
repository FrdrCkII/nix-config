{ cfg, ... }:
{
  xdg.configFile."fuzzel" = {
    source = cfg.lib.relativeToRoot "dot/${cfg.sys.config}/fuzzel";
    recursive = true;
  };
  xdg.configFile."waybar" = {
    source = cfg.lib.relativeToRoot "dot/${cfg.sys.config}/waybar";
    recursive = true;
  };
  xdg.configFile."niri" = {
    source = cfg.lib.relativeToRoot "dot/${cfg.sys.config}/niri";
    recursive = true;
  };
}
