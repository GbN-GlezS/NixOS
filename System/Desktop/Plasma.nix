# https://wiki.nixos.org/wiki/KDE

{ pkgs, ... }:

{
  # Definition of systemd service units; see systemd.service(5).
  services = {
    displayManager.plasma-login-manager.enable = true; # Whether to enable Plasma Login Manager.
    desktopManager.plasma6.enable = true; # Enable the Plasma 6 (KDE 6) desktop environment.
  };

  # List of default packages to exclude from the configuratio
  environment.plasma6.excludePackages = with pkgs.kdePackages; [

    aurorae
    plasma-browser-integration
    plasma-workspace-wallpapers
    # konsole
    kwin-x11

    qttools # Expose qdbus in PATH

    ark
    elisa
    gwenview
    okular
    kate
    ktexteditor # provides elevated actions for kate
    khelpcenter
    # dolphin
    baloo-widgets # baloo information in Dolphin
    # dolphin-plugins
    # spectacle
    ffmpegthumbs
    krdp
    kconfig # required for xdg-terminal from xdg-utils
    qtbase # for qtpaths which is required for xdg-mime from xdg-utils
    plasma-keyboard # touch keyboard
    qtvirtualkeyboard # used by plasma-keyboard KCM

    qrca
    qtsensors # This is required for autorotation in Plasma 6
    discover # Since PackageKit Nix support is not there yet, only install discover if flatpak or fwupd is enabled.
  ];
}
