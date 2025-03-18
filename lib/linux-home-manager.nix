{ custom-args, custom-config }: let
  inherit (custom-args) inputs lib custom-lib;
  inherit (custom-args.inputs) home-manager;
  system = custom-config.system.system;
  extraSpecialArgs = {
    inherit (custom-args) inputs custom-lib;
    cfg = {
      sys = custom-config.system;
      pkg = custom-config.packages;
      mod = custom-config.modules;
      opt = custom-config.options;
    };
  };
in home-manager.lib.homeManagerConfiguration {
  inherit extraSpecialArgs;
  pkgs = extraSpecialArgs.cfg.pkg.pkgs-unstable;
  modules = extraSpecialArgs.cfg.mod.home-manager-modules
  ++ [
    ({
      nixpkgs.overlays = [
        (final: prev: {
          myRepo = inputs.myRepo.packages."${system}";
        })
      ];
    })
  ];
}