{ pkgs, ... }:

{
  # Configure keymap in X11.
  services.xserver.xkb = {
    layout = "us"; # X keyboard layout, or multiple keyboard layouts separated by commas.
    variant = "colemak"; # X keyboard variant.
  };

  # List of default packages to exclude from the configuration.
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa # Simple music player aiming to provide a nice experience for its users.
  ];

  # The set of packages that appear in /run/current-system/sw.
  environment.systemPackages = with pkgs; [
    gimp # GNU Image Manipulation Program.
    git # Distributed version control system.
    kdePackages.kolourpaint # Easy-to-use paint program.
  ];

  programs.kdeconnect.enable = true; # Whether to enable kdeconnect.
}
