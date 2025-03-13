{ lib, ... }:
{
  nixos-system = import ./nixos-system.nix;
  linux-home-manager = import ./linux-home-manager.nix;
  linux-system-manager = import ./linux-system-manager.nix;
  relativeToRoot = lib.path.append ../.;
}
