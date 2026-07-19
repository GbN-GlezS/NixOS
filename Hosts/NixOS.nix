{ pkgs, ... }:

{
  # Configure keymap in X11.
  services.xserver.xkb = {
    layout = "us"; # X keyboard layout, or multiple keyboard layouts separated by commas.
    variant = "colemak"; # X keyboard variant.
  };

  # List of default packages to exclude from the configuration.
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    okular # KDE document viewer.
  ];

  # The set of packages that appear in /run/current-system/sw.
  environment.systemPackages = with pkgs; [
    gimp # GNU Image Manipulation Program.
    git # Distributed version control system.
    kdePackages.kolourpaint # Easy-to-use paint program.
    kdePackages.partitionmanager # Manage the disk devices, partitions and file systems on your computer.
    kdePackages.skanpage # Utility to scan images and multi-page documents.
  ];

  programs.kdeconnect.enable = true; # Whether to enable kdeconnect.
}
