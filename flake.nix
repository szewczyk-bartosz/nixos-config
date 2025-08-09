{
  description = "k1v1 config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    disko.url = "github:nix-community/disko";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, disko, home-manager,  ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations.k1v1 = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./configuration.nix
        disko.nixosModules.disko
      ];
    };

    homeConfigurations.cheryllamb = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./home.nix 
      ];
    };

  };
}
