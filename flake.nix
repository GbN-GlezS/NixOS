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

    NUR = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      plasma-manager,
      NUR,
      ...
    }:
    let
      mkHost =
        {
          hostName,
          GPU ? "amdgpu",
          sysLocale ? "es_MX.UTF-8",
          kbdLayout ? "latam",
          kbdVariant ? "",
          extraHomeArgs ? { },
          extraSystemModules ? [ ],
          extraHomeModules ? [ ],
        }:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          specialArgs = {
            inherit
              GPU
              sysLocale
              kbdLayout
              kbdVariant
              ;
          };

          modules = [
            # NUR
            NUR.modules.nixos.default

            # Host
            ./Hosts/${hostName}/configuration.nix
            ./Hosts/Common.nix

            # System
            ./System/Plymouth.nix
            ./System/PipeWire.nix
            ./Services/Avahi.nix
            ./Services/GarbageCollector.nix
            ./System/Desktop/Plasma.nix

            # Hostname
            {
              networking.hostName = hostName;
            }
          ]
          ++ extraSystemModules
          ++ [
            # Home Manager
            home-manager.nixosModules.default

            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;

                backupFileExtension = "backup";
                overwriteBackup = true;

                extraSpecialArgs = extraHomeArgs // {
                  CursorSize = 16;
                  FontSize = 10;
                };

                users.nixos = {
                  imports = [
                    ./Home-Manager/Hosts/${hostName}.nix

                    # Plasma Manager
                    plasma-manager.homeModules.plasma-manager

                    # Shared Home Manager configuration
                    ./Home-Manager/Desktop/Plasma.nix
                    ./Home-Manager/Hosts/Common.nix

                    # Common packages
                    ./Home-Manager/Packages/BraveOrigin.nix
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

          extraHomeArgs = {
            ThemeColor = "pink";
            IconVariant = "Light";
            CursorVariant = "Classic";
            AccentColor = "233,58,154";
            LookAndFeel = "";
          };
        };

        IdeaPad = mkHost {
          hostName = "IdeaPad";

          extraHomeArgs = {
            ThemeColor = "pink";
            IconVariant = "Dark";
            CursorVariant = "Ice";
            AccentColor = "233,58,154";
            LookAndFeel = "dark";
          };
        };

        Pavilion = mkHost {
          hostName = "Pavilion";

          GPU = "i915";

          extraSystemModules = [
            ./Packages/Spotify.nix
          ];

          extraHomeArgs = {
            ThemeColor = "pink";
            IconVariant = "Light";
            CursorVariant = "Classic";
            AccentColor = "233,58,154";
            LookAndFeel = "";
          };
        };

        ThinkPad = mkHost {
          hostName = "ThinkPad";

          sysLocale = "en_US.UTF-8";
          kbdLayout = "us";
          kbdVariant = "colemak";

          extraSystemModules = [
            ./Packages/Spotify.nix
            # ./Packages/VirtManager.nix
          ];

          extraHomeArgs = {
            ThemeColor = "blue";
            IconVariant = "Dark";
            CursorVariant = "Ice";
            AccentColor = "61,174,233";
            LookAndFeel = "dark";
          };

          extraHomeModules = [
            ./Home-Manager/Packages/Firefox.nix
            ./Home-Manager/Packages/PhotoGIMP.nix
            ./Home-Manager/Packages/VSCode.nix
          ];
        };
      };
    };
}
