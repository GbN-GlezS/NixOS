{ pkgs, lib, ... }:

let
  # Definimos la descarga del relase oficial de PhotoGIMP
  photoGimpSrc = pkgs.fetchzip {
    url = "https://github.com/Diolinux/PhotoGIMP/releases/download/3.0/PhotoGIMP-linux.zip";
    # Hash SHA256 para garantizar la integridad reproducible de Nix
    hash = lib.fakeHash;
  };
in
{
  # 1. Aseguramos que GIMP esté instalado en tu sistema
  home.packages = [
    pkgs.gimp # GNU Image Manipulation Program.
  ];

  # 2. Copiamos/Viculamos la configuración de PhotoGIMP automáticamente a ~/.config
  home.file.".config/GIMP/3.0" = {
    source = "${photoGimpSrc}/.config/GIMP/3.0";
    recursive = true;
  };
}
