{ pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  stylix = {
    enable = true;
    # image = /home/nixos/wallpaper.png; # Ruta a tu fondo de pantalla
    # Opcional: Si prefieres un esquema de colores específico en lugar de generarlo del fondo
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  };

  # List of default packages to exclude from the configuration.
  # environment.plasma6.excludePackages = with pkgs.kdePackages; [
  #   okular # KDE document viewer.
  # ];

  # The set of packages that appear in /run/current-system/sw.
  # environment.systemPackages = with pkgs.kdePackages; [
  #   kolourpaint # Easy-to-use paint program.
  #   partitionmanager # Manage the disk devices, partitions and file systems on your computer.
  #   skanpage # Utility to scan images and multi-page documents.
  # ];

  # programs.kdeconnect.enable = true; # Whether to enable kdeconnect.

  # programs.nix-ld.enable = true; # Whether to enable nix-ld.
}
