{ lib, cfg, ... }:
lib.mkMerge [
  {
    boot = {
      supportedFilesystems = {
        ext4 = true;
        btrfs = true;
        ntfs = true;
        fat = true;
        vfat = true;
        exfat = true;
      };
      kernelParams = [
        "video=1920x1080@60"
        "loglevel=5"
        "nowatchdog"
      ];
    };
  }

  ( lib.mkIf cfg.opt.boot.grub.enable {
    loader = {
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = lib.mkDefault "/efi";
      grub = {
        enable = true;
        device = lib.mkDefault "nodev";
        efiSupport = lib.mkDefault true;
        gfxmodeEfi = lib.mkDefault "1920x1080@60";
        gfxpayloadEfi = lib.mkDefault "keep";
        configurationName = lib.mkDefault "GRUB";
      };
    };
  } )

  ( lib.mkIf cfg.opt.boot.systemd-boot.enable {
    loader = {
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = lib.mkDefault "/efi";
      systemd-boot = {
        enable = true;
        consoleMode = "keep";
      };
    };
  } )

  ( lib.mkIf (cfg.opt.boot.efi-mount-point != null) {
    loader.efi.efiSysMountPoint = cfg.opt.boot.efi-mount-point;
  } )

]
