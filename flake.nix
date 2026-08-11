{
  inputs = {
    NixPkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    Home-Manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "NixPkgs";
    };

    Plasma-Manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "NixPkgs";
      inputs.home-manager.follows = "Home-Manager";
    };

    NUR = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "NixPkgs";
    };
  };

  outputs =
    {
      NixPkgs,
      Home-Manager,
      Plasma-Manager,
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
        NixPkgs.lib.nixosSystem {
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
            ./Hosts/${hostName}/Configuration.nix
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
            Home-Manager.nixosModules.default

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
                    ./Hosts/${hostName}-Home.nix

                    # Plasma Manager
                    Plasma-Manager.homeModules.plasma-manager

                    # Shared Home Manager configuration
                    ./Desktop/Plasma-Home.nix
                    ./Hosts/Common-Home.nix

                    # Common packages
                    ./Packages/BraveOrigin.nix
                    ./Packages/OnlyOffice.nix
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
            ./Packages/Firefox.nix
            ./Packages/PhotoGIMP.nix
            ./Packages/VSCode.nix
          ];
        };
      };
    };
}
