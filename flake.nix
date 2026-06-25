{
  description = "Configuración multi-máquina centralizada (Estructura Plana)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      
      # 1. Tu PC Principal (Desktop)
      NixOS = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix   # Base de tu S.O.
          ./NixOS.nix           # Gimp, Kolourpaint, Spotify
          ./Virtualization.nix  # Entorno QEMU/KVM
          ({ networking.hostName = "NixOS"; }) # Inyección nativa de hostName
        ];
      };

      # 2. La de tu hermana (IdeaCentre)
      IdeaCentre = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./Idea.nix      # Autologin de tu hermana
          ({ networking.hostName = "IdeaCentre"; })
        ];
      };

      # 3. La de tu mamá (IdeaPad)
      IdeaPad = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./Idea.nix         # Autologin de tu mamá + fix TPM
          ({ networking.hostName = "IdeaPad"; })
        ];
      };

      # 4. La de tu prima (Pavilion)
      Pavilion = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./Pavilion.nix        # Spotify + Firewall local
          ({ networking.hostName = "Pavilion"; })
        ];
      };

    };
  };
}