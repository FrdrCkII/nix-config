{ config, lib, pkgs, cfg, ... }:
lib.mkMerge [
  {
    environment.systemPackages = with cfg.pkg.pkgs; [
      vim wget curl git
    ]
    ++ cfg.opt.system.packages;
    networking.hostName = cfg.hostname;
    networking.networkmanager.enable = true;
    nixcfg.pkg.pkgs.config = {
      allowUnfreePredicate = cfg.pkg.allowed-unfree-packages;
      permittedInsecurePackages = cfg.pkg.allowed-insecure-packages;
    };
    users.users.${cfg.opt.users.user.name} = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ];
    };
  }

  {
    options.cfg.opt = {
      system.version = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = "25.05";
        description = "system state version";
      };
      system.channel = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "system channel";
      };
      system.kernel = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = cfg.pkg.pkgs.linuxPackages;
        description = "kernel packages";
      };
      users.root.passwd = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "root hashed password";
      };
      users.user.passwd = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "user hashed password";
      };
    };
    config = lib.mkMerge [
      ( lib.mkIf (cfg.opt.system.version != null) {
        system.stateVersion = cfg.opt.system.version;
      } )
      ( lib.mkIf (cfg.opt.system.channel != null) {
        system.autoUpgrade.channel = cfg.opt.system.channel;
      } )
      ( lib.mkIf (cfg.opt.system.kernel != null) {
        boot.kernelPackages = cfg.opt.system.kernel;
      } )
      ( lib.mkIf (cfg.opt.users.root.passwd != null) {
        users.users.root.hashedPassword = cfg.opt.users.root.passwd;
      } )
      ( lib.mkIf (cfg.opt.users.user.passwd != null) {
        users.users.${cfg.opt.users.user.name}.hashedPassword = cfg.opt.users.user.passwd;
      } )
    ];
  }

]
