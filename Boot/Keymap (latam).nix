{ pkgs, ... }:

{
  # Configure keymap in X11.
  services.xserver.xkb = {
    layout = "latam"; # X keyboard layout, or multiple keyboard layouts separated by commas.
    variant = ""; # X keyboard variant.
  };
}
