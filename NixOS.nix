{ pkgs, ... }:

{
  # Configure keymap in X11.
  services.xserver.xkb = {
    layout = "us";
    variant = "colemak";
  };

  # List of default packages to exclude from the configuration.
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa # Simple music player aiming to provide a nice experience for its users.
  ];

  # These packages are automatically available to all users, and are automatically updated every time you rebuild the system configuration.
  environment.systemPackages = with pkgs; [
    gimp # GNU Image Manipulation Program.
    kdePackages.kolourpaint # Easy-to-use paint program.
    git # Distributed version control system.
  ];

  programs.kdeconnect.enable = true; # Whether to enable kdeconnect.
}
