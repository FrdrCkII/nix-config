{ custom-args, custom-config }: let
  inherit (custom-args.inputs) system-manager;
  extraSpecialArgs = {
    inherit (custom-args) inputs custom-lib;
    pkgs = custom-config.packages.pkgs;
    cfg = {
      sys = custom-config.system;
      pkg = custom-config.packages;
      mod = custom-config.modules;
      opt = custom-config.options;
      lib = custom-args.custom-lib;
    };
  };
in system-manager.lib.makeSystemConfig {
  inherit extraSpecialArgs;
  modules = extraSpecialArgs.cfg.mod.system-manager-modules;
}
