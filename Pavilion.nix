{ pkgs, ... }:

{
  # Configure keymap in X11.
  services.xserver.xkb = {
    layout = "latam"; # X keyboard layout, or multiple keyboard layouts separated by commas.
    variant = ""; # X keyboard variant.
  };

  # List of default packages to exclude from the configuration.
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa # Simple music player aiming to provide a nice experience for its users.
  ];
}
