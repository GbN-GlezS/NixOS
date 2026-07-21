{ pkgs, ... }:

{
  # Configure keymap in X11.
  services.xserver.xkb = {
    layout = "us"; # X keyboard layout, or multiple keyboard layouts separated by commas.
    variant = "colemak"; # X keyboard variant.
  };
}
