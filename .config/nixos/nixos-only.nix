{ ... }:

{
  environment.homeBinInPath = true;

  nix.optimise.automatic = true;
  nix.optimise.dates = [ "03:45" ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
  };
}
