{
  description = "System config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      hm = home-manager.defaultPackage.${system};
      homeConfigurations.damian = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [ ./home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };

      nixosConfigurations = {
        nixos-vm = nixpkgs.lib.nixosSystem
          {
            inherit system;

            specialArgs = { inherit inputs; };
            modules = [
              # shared
              ./configuration.nix
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.damian = import ./home.nix;
                };
              }

              # per-machine
              ./hardware-configuration.nix
              { networking.hostName = "nixos-vm"; }
            ];
          };
      };
    };
}
