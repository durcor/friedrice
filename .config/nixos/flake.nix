{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    firefox-nightly.url = "github:nix-community/flake-firefox-nightly";
    hyprland.url = "github:hyprwm/hyprland";

    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
    };

    gpu-usage-waybar = {
      url = "path:/home/ty/src/gpu-usage-waybar";
    };
  };

  outputs = { nixpkgs, chaotic, nix, self, ... }@inputs: {
    nixosConfigurations = {
      noveria = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
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
