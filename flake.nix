{
  inputs = {
    # Nixpkgs unstable
    # ThinkPad
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # Nixpkgs 26.05 stable
    # IdeaCentre, IdeaPad y Pavilion
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.home-manager.follows = "home-manager";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs =
    {
      nixpkgs-unstable,
      nixpkgs,
      home-manager,
      plasma-manager,
      nur,
      ...
    }:
    let
      mkHost =
        {
          hostName,
          nixpkgsInput ? nixpkgs,
          GPU ? "amdgpu",
          sysLocale ? "es_MX.UTF-8",
          kbdLayout ? "latam",
          kbdVariant ? "",
          extraHomeArgs ? { },
          extraSystemModules ? [ ],
          extraHomeModules ? [ ],
        }:
        nixpkgsInput.lib.nixosSystem {
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
            nur.modules.nixos.default

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

        # ==========================================
        # FAMILY
        # NixOS 26.05 Stable
        # ==========================================

        IdeaCentre = mkHost {
          hostName = "IdeaCentre";
          nixpkgsInput = nixpkgs;

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
          nixpkgsInput = nixpkgs;

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
          nixpkgsInput = nixpkgs;

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

        # ==========================================
        # PERSONAL
        # NixOS Unstable
        # ==========================================

        ThinkPad = mkHost {
          hostName = "ThinkPad";
          nixpkgsInput = nixpkgs-unstable;

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
