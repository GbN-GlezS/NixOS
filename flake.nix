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
      mkHost =
        {
          hostName,
          sysLocale ? "es_MX.UTF-8",
          kbdLayout ? "latam",
          extraHomeArgs ? { },
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
            ./System/Plymouth.nix
            ./System/PipeWire.nix
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

                extraSpecialArgs = extraHomeArgs // {
                  CursorSize = 16;
                  FontSize = 10;
                };

                users.nixos = {
                  imports = [
                    ./Home-Manager/Hosts/${hostName}.nix
                    ./Home-Manager/Hosts/Common.nix
                    ./Home-Manager/Packages/DesktopEntries.nix
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
          extraSystemModules = [
            ./System/Desktop/Xfce.nix
          ];
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
          extraSystemModules = [
            ./System/Desktop/Xfce.nix
          ];
          extraHomeModules = [
          ];
          extraHomeArgs = {
            ThemeColor = "pink";
            IconVariant = "Dark";
            CursorVariant = "Ice";
            AccentColor = "233,58,154";
            LookAndFeel = "dark";
            OrchisTheme = "pink";
            OrchisColor = "dark";
            OrchisSize = "standard";
            OrchisTweaks = [
              "solid"
              "primary"
            ];
          };
        };

        Pavilion = mkHost {
          hostName = "Pavilion";
          extraSystemModules = [
            ./System/Desktop/Plasma.nix
            ./Packages/Spotify.nix
          ];
          extraHomeModules = [
            plasma-manager.homeModules.plasma-manager
            ./Home-Manager/Plasma.nix
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
          extraSystemModules = [
            ./System/Desktop/Plasma.nix
            ./System/Desktop/Hyprland.nix
            ./Packages/Spotify.nix
            ./Packages/VirtManager.nix
          ];
          extraHomeModules = [
            plasma-manager.homeModules.plasma-manager
            ./Home-Manager/Plasma.nix
            ./Home-Manager/Hyprland.nix
            ./Home-Manager/Packages/VSCode.nix
            ./Home-Manager/Packages/PhotoGIMP.nix
          ];
          extraHomeArgs = {
            ThemeColor = "blue";
            IconVariant = "Dark";
            CursorVariant = "Ice";
            AccentColor = "61,174,233";
            LookAndFeel = "dark";
          };
        };

      };
    };
}
