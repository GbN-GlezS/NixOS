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
          ./Boot.nix            # Silent boot y animación Plymouth para ti
          ./Common.nix          # Brave, Papirus, Bibata
          ./OnlyOffice.nix      # OnlyOffice + fuentes Microsoft para tu productividad
          ./Spotify.nix         # Spotify + Firewall local abierto para ti
          ./NixOS.nix           # Tus herramientas (Gimp, Kolourpaint, Colemak)
          ./Virtualization.nix  # Entorno QEMU/KVM
          ({ networking.hostName = "NixOS"; })
        ];
      };

      # 2. La de tu hermana (IdeaCentre)
      IdeaCentre = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./Boot.nix            # Animación fluida de arranque para ella
          ./Common.nix          # Entorno común básico
          ./OnlyOffice.nix      # OnlyOffice para sus tareas académicas
          ./Idea.nix            # Autologin + Fix de teclado Latam y TPM unificado
          ({ networking.hostName = "IdeaCentre"; })
        ];
      };

      # 3. La de tu mamá (IdeaPad)
      IdeaPad = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./Boot.nix            # Animación fluida de arranque para ella
          ./Common.nix
          ./OnlyOffice.nix      # OnlyOffice para sus documentos
          ./Idea.nix            # Autologin + Fix de teclado Latam y TPM unificado
          ({ networking.hostName = "IdeaPad"; })
        ];
      };

      # 4. La de tu prima (Pavilion)
      Pavilion = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./Boot.nix            # Animación fluida de arranque para ella
          ./Common.nix
          ./Spotify.nix         # Tu prima solo ocupa Spotify con su Firewall abierto
          ./Pavilion.nix        # Exclusiones de paquetes locales
          ({ networking.hostName = "Pavilion"; })
        ];
      };

    };
  };
}