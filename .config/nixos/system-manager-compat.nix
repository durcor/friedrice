# Compatibility shims for NixOS modules imported by system-manager.
#
# system-manager imports nixos/modules/config/nix.nix to implement nix.*. Its
# own smaller nix module now duplicates options declared upstream, and upstream
# also records generated nixbld users as hidden display-manager users. Neither
# module is part of a normal system-manager configuration, so disable the
# duplicate module, retain its replace-existing behavior, and declare the
# otherwise inert display-manager option.
{
  lib,
  inputs,
  ...
}:
{
  disabledModules = [
    "${inputs.system-manager}/nix/modules/upstream/nixpkgs/nix.nix"
  ];

  options = {
    services.displayManager.hiddenUsers = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Compatibility option for system-manager's imported NixOS Nix module.";
    };

    programs.bash.completion.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Compatibility option for system-manager's imported NixOS Nix module.";
    };
  };

  config.environment.etc."nix/nix.conf".replaceExisting = true;
}
