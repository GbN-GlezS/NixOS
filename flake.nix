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
          ./configuration.nix   # Archivo base suelto en la raíz
          ./NixOS.nix           # Gimp, Kolourpaint, etc.
          ./Virtualization.nix  # QEMU/KVM
        ];
      };

      # 2. La de tu hermana (IdeaCentre)
      IdeaCentreHost = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./IdeaCentre.nix      # Autologin de tu hermana
        ];
      };

      # 3. La de tu mamá (IdeaPad)
      IdeaPadHost = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./IdeaPad.nix         # Autologin de tu mamá + fix TPM
        ];
      };

      # 4. La de tu prima (Pavilion)
      PavilionHost = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./Pavilion.nix        # Spotify + Firewall de tu prima
        ];
      };

    };
  };
}