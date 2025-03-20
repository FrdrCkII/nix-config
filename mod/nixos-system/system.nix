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
    system.stateVersion = if (cfg.opt.system.version != null) then cfg.opt.system.version else "25.05";
    boot.kernelPackages = if (cfg.opt.system.channel != null) then cfg.opt.system.kernel else cfg.pkgs.linux;
  }

  ( lib.mkIf (cfg.opt.system.version != null) {
  } )
  ( lib.mkIf (cfg.opt.system.channel != null) {
    system.autoUpgrade.channel = cfg.opt.system.channel;
  } )
  ( lib.mkIf (cfg.opt.system.kernel != null) {
  } )
  ( lib.mkIf (cfg.opt.users.root.passwd != null) {
    users.users.root.hashedPassword = cfg.opt.users.root.passwd;
  } )
  ( lib.mkIf (cfg.opt.users.user.passwd != null) {
    users.users.${cfg.opt.users.user.name}.hashedPassword = cfg.opt.users.user.passwd;
  } )
]
