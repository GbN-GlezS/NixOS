{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    {
      nixosConfigurations = {

        NixOS = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            ./Plymouth.nix
            ./Common.nix
            ./OnlyOffice.nix
            ./Spotify.nix
            ./NixOS.nix
            ./Virtualization.nix
            ./VSCode.nix
            ({ networking.hostName = "NixOS"; })

            home-manager.nixosModules.default
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.nixos = ./Home-NixOS.nix;
              };
            }
          ];
        };

        IdeaCentre = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            ./Plymouth.nix
            ./Common.nix
            ./OnlyOffice.nix
            ./Idea.nix
            ({ networking.hostName = "IdeaCentre"; })

            home-manager.nixosModules.default
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.nixos = ./Home-IdeaCentre.nix;
              };
            }
          ];
        };

        IdeaPad = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            ./Plymouth.nix
            ./Common.nix
            ./OnlyOffice.nix
            ./Idea.nix
            ({ networking.hostName = "IdeaPad"; })

            home-manager.nixosModules.default
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.nixos = ./Home-IdeaPad.nix;
              };
            }
          ];
        };

        Pavilion = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            ./Plymouth.nix
            ./Common.nix
            ./Spotify.nix
            ./Pavilion.nix
            ({ networking.hostName = "Pavilion"; })

            home-manager.nixosModules.default
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.nixos = ./Home-Pavilion.nix;
              };
            }
          ];
        };

      };
    };
}
