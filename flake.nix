{
  inputs = {
    self.submodules = true;

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # my-nixpkgs.url = "github:durcor/nixpkgs/xonotic-fix-c23";

    nixpkgs-lib.url = "github:nix-community/nixpkgs.lib";

    systems.url = "github:nix-systems/default";

    flake-compat.url = "github:NixOS/flake-compat";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs-lib";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lib-aggregate = {
      url = "github:nix-community/lib-aggregate";
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixpkgs-lib.follows = "nixpkgs-lib";
    };

    nix = {
      url = "github:NixOS/nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
      inputs.flake-parts.follows = "flake-parts";
    };

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.flake-compat.follows = "flake-compat";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    chaotic = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.rust-overlay.follows = "rust-overlay";
      inputs.home-manager.follows = "home-manager";
    };

    firefox-nightly = {
      url = "github:nix-community/flake-firefox-nightly";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
      inputs.lib-aggregate.follows = "lib-aggregate";
    };

    hyprutils = {
      url = "github:hyprwm/hyprutils";
      inputs.systems.follows = "systems";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprlang = {
      url = "github:hyprwm/hyprlang";
      inputs.systems.follows = "systems";
      inputs.hyprutils.follows = "hyprutils";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.pre-commit-hooks.follows = "pre-commit-hooks";
      inputs.systems.follows = "systems";
      inputs.hyprlang.follows = "hyprlang";
      inputs.hyprutils.follows = "hyprutils";
    };

    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hyprlang.follows = "hyprlang";
      inputs.utils.follows = "flake-utils";
    };

    # transg-tui.url = "github:PanAeon/transg-tui";

    gpu-usage-waybar = {
      url = "github:durcor/gpu-usage-waybar";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
      inputs.rust-overlay.follows = "rust-overlay";
    };

    yazi = {
      url = "github:sxyazi/yazi";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.rust-overlay.follows = "rust-overlay";
      inputs.flake-utils.follows = "flake-utils";
    };

    system-manager = {
      url = "github:numtide/system-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    television = {
      url = "github:alexpasmantier/television";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
      inputs.rust-overlay.follows = "rust-overlay";
    };

    nixGL = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    nix-system-graphics = {
      url = "github:soupglasses/nix-system-graphics";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nh = {
      url = "github:nix-community/nh";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # simula = {
    #   url = "github:SimulaVR/Simula"
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.systems.follows = "systems";
    #   inputs.flake-parts.follows = "flake-parts";
    # };
  };

  outputs = { nixpkgs, chaotic, home-manager, system-manager, nix-system-graphics, nix, self, ... }@inputs: {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt;

    nixosConfigurations = {
      noveria = nixpkgs.lib.nixosSystem {
        modules = [
          "${self}/etc/nixos/hosts/noveria.nix"
          "${self}/etc/nixos/configuration.nix"
          "${self}/etc/nixos/amdgpu.nix"
          "${self}/etc/nixos/ryzen.nix"
          "${self}/etc/nixos/gaming.nix"
          chaotic.nixosModules.default
        ];
        specialArgs = {
          inherit inputs;
          inherit chaotic;
        };
      };
    };

    systemConfigs = {
      zorya = system-manager.lib.makeSystemConfig {
        modules = [
          "${self}/etc/nixos/hosts/zorya.nix"
          "${self}/etc/nixos/configuration.nix"
          nix-system-graphics.systemModules.default
        ];
        extraSpecialArgs = {
          inherit inputs;
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
            {
              home.username = "tyler";
              home.homeDirectory = "/home/tyler";
              home.stateVersion = "26.05";

              programs.home-manager.enable = true;

              home.packages = with pkgs; [
                inputs.yazi.packages.${pkgs.stdenv.hostPlatform.system}.yazi
                inputs.system-manager.packages.${pkgs.stdenv.hostPlatform.system}.default
                inputs.nh.packages.${pkgs.stdenv.hostPlatform.system}.nh
                inputs.television.packages.${pkgs.stdenv.hostPlatform.system}.default
                inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland
                inputs.rose-pine-hyprcursor.packages.${pkgs.stdenv.hostPlatform.system}.default
                inputs.nixGL.packages.${pkgs.stdenv.hostPlatform.system}.default
              ];
            }
          ];
        };
      };
  };
}
