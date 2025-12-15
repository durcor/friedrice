{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    chaotic.inputs.nixpkgs.follows = "nixpkgs";

    firefox-nightly.url = "github:nix-community/flake-firefox-nightly";
    firefox-nightly.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/hyprland";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";

    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
    rose-pine-hyprcursor.inputs.nixpkgs.follows = "nixpkgs";

    gpu-usage-waybar.url = "github:durcor/gpu-usage-waybar";
    gpu-usage-waybar.inputs.nixpkgs.follows = "nixpkgs";

    # transg-tui.url = "github:PanAeon/transg-tui";
  };

  outputs = { nixpkgs, chaotic, nix, self, ... }@inputs: {
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
  };
}
