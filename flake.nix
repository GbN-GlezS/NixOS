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
    let
      # Function to generate a host configuration with default fallback values
      mkHost =
        {
          hostName,
          sysLocale ? "es_MX.UTF-8",
          kbdLayout ? "latam",
          ThemeColor ? "pink",
          IconVariant ? "Light",
          CursorVariant ? "Classic",
          AccentColor ? "233,58,154",
          LookAndFeel ? "",
          extraSystemModules ? [ ],
          extraHomeModules ? [ ],
        }:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          specialArgs = {
            inherit sysLocale kbdLayout;
            kbdVariant = "";
          };

          modules = [
            ./Hosts/${hostName}/configuration.nix
            ./Hosts/Common.nix
            ./Boot/Plymouth.nix
            ./Services/Avahi.nix
            ./Services/GarbageCollector.nix
            ({ networking.hostName = hostName; })
          ]
          ++ extraSystemModules
          ++ [

            home-manager.nixosModules.default
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                overwriteBackup = true;

                extraSpecialArgs = {
                  inherit
                    ThemeColor
                    IconVariant
                    CursorVariant
                    AccentColor
                    LookAndFeel
                    ;
                  CursorSize = 16;
                  FontSize = 10;
                };

                sharedModules = [ plasma-manager.homeModules.plasma-manager ];
                users.nixos = {
                  imports = [
                    ./Home-Manager/Hosts/${hostName}.nix
                    ./Home-Manager/Hosts/Common.nix
                    ./Home-Manager/Packages/OnlyOffice.nix
                  ]
                  ++ extraHomeModules;
                };
              };
            }
          ];
        };

    in
    {
      nixosConfigurations = {

        IdeaCentre = mkHost {
          hostName = "IdeaCentre";
        };

        IdeaPad = mkHost {
          hostName = "IdeaPad";
          IconVariant = "Dark";
          CursorVariant = "Ice";
          LookAndFeel = "dark";
        };

        Pavilion = mkHost {
          hostName = "Pavilion";
          extraSystemModules = [ ./Packages/Spotify.nix ];
        };

        ThinkPad = mkHost {
          hostName = "ThinkPad";
          sysLocale = "en_US.UTF-8";
          kbdLayout = "us";
          ThemeColor = "blue";
          IconVariant = "Dark";
          CursorVariant = "Ice";
          AccentColor = "61,174,233";
          LookAndFeel = "dark";
          extraSystemModules = [
            ./Packages/Spotify.nix
            ./Packages/VirtManager.nix
          ];
          extraHomeModules = [
            ./Home-Manager/Packages/VSCode.nix
            ./Home-Manager/Packages/PhotoGIMP.nix
          ];
        };

      };
    };
}
