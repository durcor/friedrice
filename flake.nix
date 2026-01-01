{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs-lib.url = "github:nix-community/nixpkgs.lib";

    systems.url = "github:nix-systems/default";

    flake-compat.url = "github:NixOS/flake-compat";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";
    flake-utils.inputs.systems.follows = "systems";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs-lib";

    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";

    naersk.url = "github:nix-community/naersk";
    naersk.inputs.nixpkgs.follows = "nixpkgs";

    lib-aggregate.url = "github:nix-community/lib-aggregate";
    lib-aggregate.inputs.flake-utils.follows = "flake-utils";
    lib-aggregate.inputs.nixpkgs-lib.follows = "nixpkgs-lib";

    nix.url = "github:NixOS/nix";
    nix.inputs.nixpkgs.follows = "nixpkgs";
    nix.inputs.flake-compat.follows = "flake-compat";
    nix.inputs.flake-parts.follows = "flake-parts";

    pre-commit-hooks.url = "github:cachix/git-hooks.nix";
    pre-commit-hooks.inputs.flake-compat.follows = "flake-compat";
    pre-commit-hooks.inputs.nixpkgs.follows = "nixpkgs";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    chaotic.inputs.nixpkgs.follows = "nixpkgs";
    chaotic.inputs.rust-overlay.follows = "rust-overlay";
    chaotic.inputs.home-manager.follows = "home-manager";

    firefox-nightly.url = "github:nix-community/flake-firefox-nightly";
    firefox-nightly.inputs.nixpkgs.follows = "nixpkgs";
    firefox-nightly.inputs.flake-compat.follows = "flake-compat";
    firefox-nightly.inputs.lib-aggregate.follows = "lib-aggregate";

    hyprutils.url = "github:hyprwm/hyprutils";
    hyprutils.inputs.systems.follows = "systems";
    hyprutils.inputs.nixpkgs.follows = "nixpkgs";

    hyprlang.url = "github:hyprwm/hyprlang";
    hyprlang.inputs.systems.follows = "systems";
    hyprlang.inputs.hyprutils.follows = "hyprutils";
    hyprlang.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/hyprland";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.inputs.pre-commit-hooks.follows = "pre-commit-hooks";
    hyprland.inputs.systems.follows = "systems";
    hyprland.inputs.hyprlang.follows = "hyprlang";
    hyprland.inputs.hyprutils.follows = "hyprutils";

    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
    rose-pine-hyprcursor.inputs.nixpkgs.follows = "nixpkgs";
    rose-pine-hyprcursor.inputs.hyprlang.follows = "hyprlang";
    rose-pine-hyprcursor.inputs.utils.follows = "flake-utils";

    # transg-tui.url = "github:PanAeon/transg-tui";

    gpu-usage-waybar.url = "github:durcor/gpu-usage-waybar";
    gpu-usage-waybar.inputs.nixpkgs.follows = "nixpkgs";
    gpu-usage-waybar.inputs.flake-parts.follows = "flake-parts";
    gpu-usage-waybar.inputs.rust-overlay.follows = "rust-overlay";

    yazi.url = "github:sxyazi/yazi";
    yazi.inputs.nixpkgs.follows = "nixpkgs";
    yazi.inputs.rust-overlay.follows = "rust-overlay";
    yazi.inputs.flake-utils.follows = "flake-utils";

    system-manager.url = "github:numtide/system-manager";
    system-manager.inputs.nixpkgs.follows = "nixpkgs";

    television.url = "github:alexpasmantier/television";
    television.inputs.nixpkgs.follows = "nixpkgs";
    television.inputs.flake-utils.follows = "flake-utils";
    television.inputs.naersk.follows = "naersk";

    nixGL.url = "github:nix-community/nixGL";
    nixGL.inputs.nixpkgs.follows = "nixpkgs";
    nixGL.inputs.flake-utils.follows = "flake-utils";

    nh.url = "github:nix-community/nh";
    nh.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, chaotic, home-manager, nix, self, ... }@inputs: {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;

    nixosConfigurations = {
      noveria = nixpkgs.lib.nixosSystem {
        modules = [
          ./etc/nixos/hosts/noveria.nix
          ./etc/nixos/configuration.nix
          chaotic.nixosModules.default
        ];
        specialArgs = {
          inherit inputs;
          inherit chaotic;
        };
      };
    };

    homeConfigurations =
      let
        system = "x86_64-linux";
        pkgs = import nixpkgs { inherit system; };
      in {
        tyler = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit inputs;
          };
          modules = [
            ./etc/nixos/home.nix
          ];
        };
      };
  };
}
