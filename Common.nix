{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Which X11 packages to exclude from the default environment
  services.xserver.excludePackages = with pkgs; [ xterm ];

  # List of default packages to exclude from the configuration
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    #discover
    khelpcenter
    okular
    qrca
  ];

  environment.systemPackages = with pkgs; [
    # Navegador Web
    brave

    # Personalización KDE
    papirus-icon-theme
    bibata-cursors
  ];
}
