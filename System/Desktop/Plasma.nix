# https://wiki.nixos.org/wiki/KDE

{ config, pkgs, ... }:

{
  # Definition of systemd service units; see systemd.service(5).
  services = {
    desktopManager.plasma6.enable = true; # Enable the Plasma 6 (KDE 6) desktop environment.
    displayManager.plasma-login-manager.enable = true; # Whether to enable Plasma Login Manager.
  };

  # List of default packages to exclude from the configuratio
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration # Components necessary to integrate browsers into the Plasma Desktop.
    konsole # Terminal emulator by KDE.
    elisa # Simple music player aiming to provide a nice experience for its users.
  ];
}
