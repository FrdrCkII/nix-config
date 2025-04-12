{ custom-args, custom-config }: let
  inherit (custom-args) inputs lib custom-lib;
  inherit (custom-args.inputs) home-manager;
  system = custom-config.system.system;
  pkgs = custom-config.packages.pkgs;
  extraSpecialArgs = {
    inherit (custom-args) inputs custom-lib;
    pkgs = custom-config.packages.pkgs;
    nixgl = inputs.nixgl;
    cfg = {
      sys = custom-config.system;
      pkg = custom-config.packages;
      mod = custom-config.modules;
      opt = custom-config.options;
      lib = custom-args.custom-lib;
    };
  };
in home-manager.lib.homeManagerConfiguration {
  inherit extraSpecialArgs;
  pkgs = extraSpecialArgs.cfg.pkg.pkgs;
  modules = extraSpecialArgs.cfg.mod.home-manager-modules;
}