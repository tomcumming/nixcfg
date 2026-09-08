{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    unixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helixpkgs = {
      url = "github:helix-editor/helix/079a789e8cb08ead67f19e1971a1b7438b37354b";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      unixpkgs,
      home-manager,
      helixpkgs,
      ...
    }@inputs:
    {
      nixosConfigurations.beelink = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/beelink.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              unixpkgs = unixpkgs;
              helixpkgs = helixpkgs;
            };
            home-manager.users.tommo = import ./users/tommo/home.nix;
            home-manager.users.robot = import ./users/robot/home.nix;
            home-manager.users.steam = import ./users/steam/home.nix;
          }
        ];
      };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
    };
}
