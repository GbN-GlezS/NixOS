{
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
      nixpkgs,
      home-manager,
      plasma-manager,
      ...
    }:

    {
      nixosConfigurations = {

        ThinkPad = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          specialArgs = {
            sysLocale = "en_US.UTF-8";
            kbdLayout = "us";
            kbdVariant = "";
          };

          modules = [
            ./configuration.nix
            ./Hosts/ThinkPad.nix
            ./Hosts/Common.nix
            ./Boot/Plymouth.nix
            ./Packages/OnlyOffice.nix
            ./Packages/Spotify.nix
            #./Packages/VirtManager.nix
            ({ networking.hostName = "ThinkPad"; })

            home-manager.nixosModules.default
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                overwriteBackup = true;

                extraSpecialArgs = {
                  ThemeColor = "blue";
                  IconVariant = "Dark";
                  CursorVariant = "Ice";
                  CursorSize = 16;
                  FontSize = 10;
                  AccentColor = "61,174,233";
                  LookAndFeel = "dark";
                };

                sharedModules = [ plasma-manager.homeModules.plasma-manager ];
                users.nixos = {
                  imports = [
                    ./Home-Manager/Home-ThinkPad.nix
                    ./Home-Manager/Hosts/Home-Common.nix
                    ./Home-Manager/Packages/Home-VSCode.nix
                    ./Home-Manager/Packages/Home-PhotoGIMP.nix
                  ];
                };
              };
            }
          ];
        };

        IdeaCentre = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          specialArgs = {
            sysLocale = "es_MX.UTF-8";
            kbdLayout = "latam";
            kbdVariant = "";
          };

          modules = [
            ./configuration.nix
            ./Hosts/Idea.nix
            ./Boot/Plymouth.nix
            ./Hosts/Common.nix
            ./Packages/OnlyOffice.nix
            ({ networking.hostName = "IdeaCentre"; })

            home-manager.nixosModules.default
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                overwriteBackup = true;

                extraSpecialArgs = {
                  ThemeColor = "pink";
                  IconVariant = "Light";
                  CursorVariant = "Classic";
                  CursorSize = 16;
                  FontSize = 10;
                  AccentColor = "233,58,154";
                  LookAndFeel = "";
                };

                sharedModules = [ plasma-manager.homeModules.plasma-manager ];
                users.nixos = {
                  imports = [
                    ./Home-Manager/Home-IdeaCentre.nix
                    ./Home-Manager/Hosts/Home-Common.nix
                  ];
                };
              };
            }
          ];
        };

        IdeaPad = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          specialArgs = {
            sysLocale = "es_MX.UTF-8";
            kbdLayout = "latam";
            kbdVariant = "";
          };

          modules = [
            ./configuration.nix
            ./Hosts/Idea.nix
            ./Boot/Plymouth.nix
            ./Hosts/Common.nix
            ./Packages/OnlyOffice.nix
            ({ networking.hostName = "IdeaPad"; })

            home-manager.nixosModules.default
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                overwriteBackup = true;

                extraSpecialArgs = {
                  ThemeColor = "pink";
                  IconVariant = "Dark";
                  CursorVariant = "Ice";
                  CursorSize = 16;
                  FontSize = 10;
                  AccentColor = "233,58,154";
                  LookAndFeel = "dark";
                };

                sharedModules = [ plasma-manager.homeModules.plasma-manager ];
                users.nixos = {
                  imports = [
                    ./Home-Manager/Home-IdeaPad.nix
                    ./Home-Manager/Hosts/Home-Common.nix
                  ];
                };
              };
            }
          ];
        };

        Pavilion = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          specialArgs = {
            sysLocale = "es_MX.UTF-8";
            kbdLayout = "latam";
            kbdVariant = "";
          };

          modules = [
            ./configuration.nix
            ./Boot/Plymouth.nix
            ./Hosts/Common.nix
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

                extraSpecialArgs = {
                  ThemeColor = "pink";
                  IconVariant = "Light";
                  CursorVariant = "Classic";
                  CursorSize = 16;
                  FontSize = 10;
                  AccentColor = "233,58,154";
                  LookAndFeel = "";
                };

                sharedModules = [ plasma-manager.homeModules.plasma-manager ];
                users.nixos = {
                  imports = [
                    ./Home-Manager/Home-Pavilion.nix
                    ./Home-Manager/Hosts/Home-Common.nix
                  ];
                };
              };
            }
          ];
        };
      };
    };
}
