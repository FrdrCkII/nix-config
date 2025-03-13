{ config, lib, pkgs, ... }:
{
  # 建议参考 https://wiki.archlinuxcn.org/wiki/简体中文本地化
  time.timeZone = "Asia/Shanghai";
  i18n = {
    supportedLocales = [
      "C.UTF-8"
      "en_US.UTF-8"
      "zh_CN.UTF-8"
    ];
    defaultLocale = "zh_CN.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "zh_CN.UTF-8";
      LC_IDENTIFICATION = "zh_CN.UTF-8";
      LC_MEASUREMENT = "zh_CN.UTF-8";
      LC_MONETARY = "zh_CN.UTF-8";
      LC_NAME = "zh_CN.UTF-8";
      LC_NUMERIC = "zh_CN.UTF-8";
      LC_PAPER = "zh_CN.UTF-8";
      LC_TELEPHONE = "zh_CN.UTF-8";
      LC_TIME = "zh_CN.UTF-8";
    };
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          fcitx5-rime
          fcitx5-mozc
        ];
        settings = {

        };
      };
    };
  };
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      # 图标字体
      material-design-icons
      font-awesome

      # Noto 系列字体是 Google 主导的，名字的含义是「没有豆腐」（no tofu），因为缺字时显示的方框或者方框被叫作 tofu
      # Noto 系列字族名只支持英文，命名规则是 Noto + Sans 或 Serif + 文字名称。
      # 其中汉字部分叫 Noto Sans/Serif CJK SC/TC/HK/JP/KR，最后一个词是地区变种。
      noto-fonts # 大部分文字的常见样式，不包含汉字
      noto-fonts-cjk-sans # 汉字部分，由原来的noto-fonts-cjk拆成了两个包
      noto-fonts-cjk-serif
      noto-fonts-color-emoji # 彩色的表情符号字体，由noto-fonts-emoji重命名为noto-fonts-color-emoji
      # noto-fonts-extra # 提供额外的字重和宽度变种 # 包已移除

      # 思源系列字体是 Adobe 主导的。其中汉字部分被称为「思源黑体」和「思源宋体」，是由 Adobe + Google 共同开发的
      source-sans # 无衬线字体，不含汉字。字族名叫 Source Sans 3 和 Source Sans Pro，以及带字重的变体，加上 Source Sans 3 VF
      source-serif # 衬线字体，不含汉字。字族名叫 Source Code Pro，以及带字重的变体
      source-han-sans # 思源黑体
      source-han-serif # 思源宋体
      # source-han-mono # 等宽字体，大多数时候用不上

      # nerdfonts
      # https://github.com/NixOS/nixpkgs/blob/nixos-unstable-small/pkgs/data/fonts/nerd-fonts/manifests/fonts.json
      nerd-fonts.symbols-only
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.iosevka
      
      wqy_microhei
      wqy_zenhei
      arphic-ukai
      arphic-uming
    ];
    fontconfig.enable = true;
    fontconfig.defaultFonts = {
      serif = ["Noto Serif" "Source Han Serif CN" "Noto Color Emoji"];
      sansSerif = ["Noto Sans" "Source Han Sans CN" "Noto Color Emoji"];
      monospace = ["JetBrainsMono Nerd Font" "Noto Sans Mono CJK SC" "Noto Color Emoji"];
      emoji = ["Noto Color Emoji"];
    };
  };
}
