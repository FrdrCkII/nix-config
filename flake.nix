/*
官方手册 https://nixos.org/manual/nixos/unstable/
官方wiki https://wiki.nixos.org/wiki/NixOS_Wiki/zh-cn
官方中文网站 https://nixos-cn.org/
选项&软件包查询 https://search.nixos.org/options?
NUR软件包查询 https://nur.nix-community.org/
home-manager选项查询 https://home-manager-options.extranix.com/?query=&release=master
中文社区github https://github.com/nixos-cn
社区大佬的配置文件 https://github.com/NixOS-CN/NixOS-CN-telegram
中文教程 https://nixos-and-flakes.thiscute.world/zh/
上文作者的配置文件 https://github.com/ryan4yin/nix-config
视频教程 https://www.bilibili.com/video/BV1yxzkYYE3E/
视频作者的配置文件 https://github.com/novel2430/MyNix
Arch wiki https://wiki.archlinuxcn.org/wiki/首页
Gentoo wiki https://wiki.gentoo.org/wiki/Main_Page
*/
{
  description = "A very basic flake";
  # nixConfig = {
  #   experimental-features = [
  #     "flakes"
  #     "nix-command"
  #     "ca-derivations"
  #   ];
  #   substituters = [
  #     "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
  #     "https://mirrors.ustc.edu.cn/nix-channels/store"
  #     "https://cache.nixos.org"
  #   ];
  # };
  inputs = {
    # 软件源
    # https://github.com/nixos/nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # https://github.com/nix-community/NUR
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # 工具
    # https://github.com/numtide/flake-utils
    flake-utils.url = "github:numtide/flake-utils";
    # https://github.com/nix-community/home-manager
    home-manager = {
      url = github:nix-community/home-manager/master;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # https://github.com/numtide/system-manager
    system-manager = {
      url = "github:numtide/system-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # https://github.com/nix-community/haumea
    haumea = {
      url = "github:nix-community/haumea/v0.2.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # https://github.com/nix-community/nixos-generators
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # 其他软件包
    # https://github.com/nix-community/nixGL
    nixGL = {
      url = "github:guibou/nixGL";
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # 我的NUR软件包
    # 本地仓库，文件就在nur目录下，用于测试
    local = {
      url = "./nur";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # github仓库
    myrepo = {
      url = "github:FrdrCkII/nur";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, ... }@inputs: let
    inherit (inputs.nixpkgs) lib;
    inherit (inputs) haumea;
    custom-lib = import ./lib {inherit lib;};
    custom-args = {inherit inputs lib custom-lib;};
    config = haumea.lib.load {
      src = ./cfg;
      inputs = custom-args;
    };
    configWithoutPaths = builtins.attrValues config;
  in {
    nixosConfigurations = 
      lib.attrsets.mergeAttrsList (map (it: it.nixosConfigurations or {}) configWithoutPaths);
    homeConfigurations = 
      lib.attrsets.mergeAttrsList (map (it: it.homeConfigurations or {}) configWithoutPaths);
    systemConfigs = 
      lib.attrsets.mergeAttrsList (map (it: it.systemConfigs or {}) configWithoutPaths);
  };
}
