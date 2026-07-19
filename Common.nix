{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [ ./Packages/VSCode.nix ];

  # Which X11 packages to exclude from the default environment.
  services.xserver.excludePackages = with pkgs; [
    xterm # Terminal emulator for the X Window System.
  ];

  # List of default packages to exclude from the configuration.
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    discover # Helps you find and install applications, games, and tools.
    kate # Advanced text editor.
    khelpcenter # Software documentation viewer.
    qrca # QR code scanner for Plasma Mobile.
  ];

  # These packages are automatically available to all users, and are automatically updated every time you rebuild the system configuration
  environment.systemPackages = with pkgs; [
    brave # Privacy-oriented browser for Desktop and Laptop computers.
    haruna # Open source video player built with Qt/QML and libmpv.
  ];
}
