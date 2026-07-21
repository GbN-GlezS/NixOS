{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      plasma-manager,
      ...
    }@inputs:
    {
      nixosConfigurations = {

        NixOS = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            ./Hosts/NixOS.nix
            ./Common.nix
            ./Boot/Plymouth.nix
            ./Packages/OnlyOffice.nix
            ./Packages/Spotify.nix
            ./Packages/VirtManager.nix
            ./Packages/VSCode.nix
            ({ networking.hostName = "NixOS"; })

            home-manager.nixosModules.default
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                overwriteBackup = true;
                sharedModules = [ plasma-manager.homeModules.plasma-manager ];
                users.nixos = {
                  imports = [
                    ./Home-Manager/NixOS.nix
                    ./Home-Manager/Common.nix
                  ];
                };
              };
            }
          ];
        };

        IdeaCentre = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            ./Hosts/Idea.nix
            ./Boot/Plymouth.nix
            ./Common.nix
            ./Packages/OnlyOffice.nix
            ({ networking.hostName = "IdeaCentre"; })

            home-manager.nixosModules.default
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                overwriteBackup = true;
                sharedModules = [ plasma-manager.homeModules.plasma-manager ];
                users.nixos = {
                  imports = [
                    ./Home-Manager/IdeaCentre.nix
                    ./Home-Manager/Common.nix
                  ];
                };
              };
            }
          ];
        };

        IdeaPad = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            ./Hosts/Idea.nix
            ./Boot/Plymouth.nix
            ./Common.nix
            ./Packages/OnlyOffice.nix
            ({ networking.hostName = "IdeaPad"; })

            home-manager.nixosModules.default
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                overwriteBackup = true;
                sharedModules = [ plasma-manager.homeModules.plasma-manager ];
                users.nixos = {
                  imports = [
                    ./Home-Manager/IdeaPad.nix
                    ./Home-Manager/Common.nix
                  ];
                };
              };
            }
          ];
        };

        Pavilion = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            ./Hosts/Pavilion.nix
            ./Boot/Plymouth.nix
            ./Common.nix
            ./Packages/Spotify.nix
            ./Packages/OnlyOffice.nix
            ({ networking.hostName = "Pavilion"; })

            home-manager.nixosModules.default
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                overwriteBackup = true;
                sharedModules = [ plasma-manager.homeModules.plasma-manager ];
                users.nixos = {
                  imports = [
                    ./Home-Manager/Pavilion.nix
                    ./Home-Manager/Common.nix
                  ];
                };
              };
            }
          ];
        };
      };
    };
}
