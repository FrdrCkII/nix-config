{ inputs, lib, custom-lib }@custom-args:
rec {
  custom-config = {inherit system packages modules options;};
  homeConfigurations."${system.name}" = custom-lib.linux-home-manager {inherit custom-args custom-config;};
  systemConfigs."${system.name}" = custom-lib.linux-system-manager {inherit custom-args custom-config;};

  system = {
    name = "arch";
    host = "arch";
    config = "config2-x86_64-linux-arch";
    system = "x86_64-linux";
    type = "linux";
  };

  packages = rec {
    allowed-unfree-packages = pkg: builtins.elem (inputs.nixpkgs.lib.getName pkg) [
      "wechat-uos"
      "dingtalk"
      "qq"
    ];
    allowed-insecure-packages = [
    ];
    pkgs = import inputs.nixpkgs-unstable {
      inherit (system) system;
      config.allowUnfreePredicate = allowed-unfree-packages;
      config.permittedInsecurePackages = allowed-insecure-packages;
      overlays = [ inputs.nixGL.overlays.default ];
    };
    pkgs-stable = import inputs.nixpkgs-stable {
      inherit (system) system;
      config.allowUnfreePredicate = allowed-unfree-packages;
      config.permittedInsecurePackages = allowed-insecure-packages;
      overlays = [ inputs.nixGL.overlays.default ];
    };
    nur = import inputs.nur {
      inherit (system) system;
      config.allowUnfreePredicate = allowed-unfree-packages;
      config.permittedInsecurePackages = allowed-insecure-packages;
      overlays = [ inputs.nixGL.overlays.default ];
    };
    myrepo = import inputs.myrepo.packages."${system.system}";
    nixgl = import inputs.nixgl.packages."${system.system}";
  };

  modules = {
    home-manager-modules = map custom-lib.relativeToRoot [
      "mod/linux-home/gtkqt.nix"
      "mod/linux-home/locale.nix"
      "mod/linux-home/nixpkgs.nix"
      "mod/linux-home/system.nix"
      "mod/linux-home/xdg.nix"

      "mod/linux-home-programs/ghostty.nix"
      "mod/linux-home-programs/helix.nix"
      "mod/linux-home-programs/aria2.nix"
      "mod/linux-home-programs/musicfox.nix"
      "mod/linux-home-programs/yazi.nix"
      "mod/linux-home-programs/zsh.nix"

      "mod/linux-home-desktop/niri.nix"
    ];
    system-manager-modules = map custom-lib.relativeToRoot [
      "mod/linux-system/locale.nix"
      "mod/linux-system/system.nix"
    ];
  };

  options = rec {
    users = {
      user.name = "FrdrCkII";
      user.passwd = "$y$j9T$fenbjjJWwGfICJPdwhI561$3Aiwlijs42HSUNPptXm444QDxBrWI9rPwFrOmqcqo2.";
      root.passwd = "$y$j9T$YHvpqmryW6Uk4LsBPj3S41$bAMv6EQYDOrQ3kAagjf.2TPFndEAuEjllKFeFrBlfM9";
    };
    git = {
      name = "FrdrCkII";
      mail = "c2h5oc2h4@outlook.com";
    };
    drivers = {
      amd = true;
    };
    desktop = {
      
    };
    boot = {
      grub.enable = true;
      efi-mount-point = "/efi";
    };

    system-manager = {
      packages = with packages.pkgs; [
      ];
    };

    home-manager = {
      version = "25.05";
      packages = with packages.pkgs; [
        fastfetch
        nix-tree
        wechat-uos qq
        libreoffice
        ffmpeg #gimp
        just
        tree
        htop
      ];
    };
  };

}
