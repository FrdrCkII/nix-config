{ inputs, lib, custom-lib }@custom-args:
rec {
  custom-config = {inherit system packages modules options;};
  nixosConfigurations."${system.name}" = custom-lib.nixos-system {inherit custom-args custom-config;};

  system = {
    name = "nixos";
    host = "nixos";
    config = "config1-x86_64-linux-nixos";
    system = "x86_64-linux";
    type = "nixos";
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
      overlays = [
        (final: prev: {
          nur = import inputs.nur {
            pkgs = prev;
            nurpkgs = prev;
            # repoOverrides = { paul = import paul { pkgs = prev; }; };
          };
        })
        ( final: prev: {
          FrdrCkII = inputs.FrdrCkII.packages."${prev.system}";
        } )
      ];
    };
    pkgs-stable = import inputs.nixpkgs-stable {
      inherit (system) system;
      config.allowUnfreePredicate = allowed-unfree-packages;
      config.permittedInsecurePackages = allowed-insecure-packages;
    };
    pkgs-unstable = import inputs.nixpkgs-unstable {
      inherit (system) system;
      config.allowUnfreePredicate = allowed-unfree-packages;
      config.permittedInsecurePackages = allowed-insecure-packages;
    };
  };

  modules = {
    nixos-modules = map custom-lib.relativeToRoot [
      "mod/nixos-core/boot.nix"
      "mod/nixos-core/drivers.nix"
      "mod/nixos-core/locale.nix"
      "mod/nixos-core/nixpkgs.nix"
      "mod/nixos-core/system.nix"
    ];
    home-manager-modules = map custom-lib.relativeToRoot [
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
      nvidia = false;
      intel = false;
    };
    desktop = {

    };
    boot = {
      grub.enable = true;
      efi-mount-point = "/efi";
    };

    system = {
      version = "25.05";
      channel = "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixos-unstable";
      kernel = packages.pkgs.linuxPackages_zen;
      packages = with packages.pkgs; [
        fastfetch
        nix-tree
      ];
    };

    home-manager = {
      version = "25.05";
      packages = with packages.pkgs; [
        wechat-uos qq
        libreoffice
        ffmpeg gimp
      ];
    };
  };

}
