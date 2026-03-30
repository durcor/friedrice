{
  inputs = {
    self.submodules = true;

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";

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

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.flake-compat.follows = "flake-compat";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix = {
      url = "github:NixOS/nix";
      inputs.nixpkgs.follows = "nixpkgs";
      # inputs.nixpkgs-23-11.follows = "nixpkgs";
      # inputs.nixpkgs-regression.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
      inputs.flake-parts.follows = "flake-parts";
      inputs.git-hooks-nix.follows = "pre-commit-hooks";
    };

    nvim = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.flake-parts.follows = "flake-parts";
      inputs.nixpkgs.follows = "nixpkgs";
      # • Added input 'nvim/flake-parts':
      #     'github:hercules-ci/flake-parts'
      # • Added input 'nvim/flake-parts/nixpkgs-lib':
      #     follows 'nvim/nixpkgs'
      # • Added input 'nvim/neovim-src':
      #     'github:neovim/neovim'
      # • Added input 'nvim/nixpkgs':
      #     'github:NixOS/nixpkgs'
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
      # url = "path:./src/hypr/land";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.pre-commit-hooks.follows = "pre-commit-hooks";
      inputs.systems.follows = "systems";
      inputs.hyprlang.follows = "hyprlang";
      inputs.hyprutils.follows = "hyprutils";
    };

    ghostty = {
      url = "github:ghostty-org/ghostty";
      # url = "path:./src/ghostty";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hypr-dynamic-cursors = {
      url = "github:VirtCode/hypr-dynamic-cursors";
      # url = "path:./src/hypr-dynamic-cursors";
      inputs.hyprland.follows = "hyprland";
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

    llm-agents = {
      url = "github:numtide/llm-agents.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # simula = {
    #   url = "github:SimulaVR/Simula"
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.systems.follows = "systems";
    #   inputs.flake-parts.follows = "flake-parts";
    # };
  };

  outputs = {
    nixpkgs,
    nixpkgs-stable,
    nixpkgs-unstable,
    chaotic,
    home-manager,
    system-manager,
    nix-system-graphics,
    nix,
    self,
    ...
  }@inputs:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      mkArgs = system:
        let
          pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
        in {
          inherit pkgs;

          stablePkgs = import nixpkgs-stable { inherit system; config.allowUnfree = true; };
          unstablePkgs = import nixpkgs-unstable { inherit system; config.allowUnfree = true; };

          yaziPkgs = inputs.yazi.packages.${system};
          nhPkgs = inputs.nh.packages.${system};
          hyprlandPkgs = inputs.hyprland.packages.${system};
          gpuUsageWaybarPkgs = inputs.gpu-usage-waybar.packages.${system};
          televisionPkgs = inputs.television.packages.${system};
          systemManagerPkgs = inputs.system-manager.packages.${system};
          firefoxNightlyPkgs = inputs.firefox-nightly.packages.${system};
          nvimPkgs = inputs.nvim.packages.${system};
          rosePineHyprcursorPkgs = inputs.rose-pine-hyprcursor.packages.${system};
          nixGLPkgs = inputs.nixGL.packages.${system};
          llmAgentsPkgs = inputs.llm-agents.packages.${system};
          hyprDynamicCursorsPkgs = inputs.hypr-dynamic-cursors.packages.${system};
        };

      mkSpecialArgs = system:
        {
          inherit self inputs chaotic;
        } // removeAttrs (mkArgs system) [ "pkgs" ];

      mkExtraSpecialArgs = system:
        {
          inherit self inputs;
        } // removeAttrs (mkArgs system) [ "pkgs" ];
    in {
    formatter = nixpkgs.lib.genAttrs supportedSystems (
      system: (import nixpkgs { inherit system; }).nixfmt
    );

    nixosConfigurations = {
      noveria = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          "${self}/etc/nixos/configuration.nix"
          "${self}/etc/nixos/nixos-only.nix"
          "${self}/etc/nixos/hosts/noveria.nix"
          "${self}/etc/nixos/amdgpu.nix"
          "${self}/etc/nixos/ryzen.nix"
          "${self}/etc/nixos/gaming.nix"
          "${self}/etc/nixos/nsfw.nix"
          # "${self}/etc/nixos/secrets.nix"
          chaotic.nixosModules.default
        ];
        specialArgs = mkSpecialArgs "x86_64-linux";
      };
    };

    systemConfigs = {
      zorya = system-manager.lib.makeSystemConfig {
        modules = [
          "${self}/etc/nixos/configuration.nix"
          "${self}/etc/nixos/hosts/zorya.nix"
          nix-system-graphics.systemModules.default
        ];
        extraSpecialArgs = mkExtraSpecialArgs "x86_64-linux";
      };
    };

    homeConfigurations =
      let
        system = "x86_64-linux";
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        # pkgs = (mkArgs "x86_64-linux").pkgs;
        nixGLPkgs = import inputs.nixGL {
          inherit pkgs;
          enable32bits = pkgs.stdenv.hostPlatform.isx86;
          enableIntelX86Extensions = pkgs.stdenv.hostPlatform.system == "x86_64-linux";
          nvidiaVersion = "535.288.01";
        };
      in {
        tyler = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          # extraSpecialArgs = {
          #   inherit inputs;
          # };
          extraSpecialArgs = mkExtraSpecialArgs "x86_64-linux";
          modules = [
            {
              home.username = "tyler";
              home.homeDirectory = "/home/tyler";
              home.stateVersion = "26.05";

              programs.home-manager.enable = true;

              home.packages =
                let
                  args = mkArgs "x86_64-linux";
                in with args.pkgs; [
                  args.yaziPkgs.yazi
                  args.systemManagerPkgs.default
                  args.nhPkgs.nh
                  args.televisionPkgs.default
                  args.hyprlandPkgs.hyprland
                  args.rosePineHyprcursorPkgs.default
                  args.nixGLPkgs.default
                  args.nixGLPkgs.nixGLNvidia
                  args.nixGLPkgs.nixGLIntel
                  hyprpaper
                ];
            }
          ];
        };
      };
  };
}
