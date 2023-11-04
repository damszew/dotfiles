{
    description = "System config flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    outputs = { self, nixpkgs }: {
        nixosConfigurations = {
            damian = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    ./configuration.nix
                ];
            };
        };
    };
}