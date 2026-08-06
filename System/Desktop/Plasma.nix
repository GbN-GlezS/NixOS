# https://wiki.nixos.org/wiki/KDE

{ pkgs, lib, ... }:

{
  # Definition of systemd service units; see systemd.service(5).
  services = {
    displayManager.plasma-login-manager.enable = true; # Whether to enable Plasma Login Manager.
    desktopManager.plasma6.enable = true; # Enable the Plasma 6 (KDE 6) desktop environment.
  };

  # List of default packages to exclude from the configuratio
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    # ark # File archiver by KDE.
    aurorae # Aurorae is a themeable window decoration for KWin.
    baloo-widgets # Widgets for Baloo.
    discover # Helps you find and install applications, games, and tools.
    # dolphin # File manager by KDE.
    dolphin-plugins # Plugins for Dolphin.
    elisa # Simple music player aiming to provide a nice experience for its users.
    # ffmpegthumbs # FFmpeg-based thumbnail creator for video files.
    # gwenview # Image viewer by KDE.
    kate # Advanced text editor.
    kconfig # KConfig.
    khelpcenter # Software documentation viewer.
    konsole # Terminal emulator by KDE.
    krdp # Library and examples for creating an RDP server.
    ktexteditor # KTextEditor Framework.
    kwin-x11 # Easy to use, but flexible, X Window Manager.
    okular # KDE document viewer.
    plasma-browser-integration # Components necessary to integrate browsers into the Plasma Desktop.
    plasma-keyboard # Virtual Keyboard for Qt based desktops.
    plasma-workspace-wallpapers # Wallpapers for Plasma Workspaces.
    qrca # QR code scanner for Plasma Mobile.
    # qtbase # Cross-platform application framework for C++.
    qtsensors # Cross-platform application framework for C++.
    (lib.getBin qttools) # Cross-platform application framework for C++.
    qtvirtualkeyboard # Cross-platform application framework for C++.
    # spectacle # Screenshot capture utility.
  ];

  # If enabled, pam_wallet will attempt to automatically unlock the user's default KDE wallet upon login.
  security.pam.services = {
    login.kwallet.enable = lib.mkForce false;
    kde.kwallet.enable = lib.mkForce false;
  };

  # A set of environment variables used in the global environment.
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
