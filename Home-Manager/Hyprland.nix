{ pkgs, ... }:

{
  home.stateVersion = "26.05"; # It is occasionally necessary for Home Manager to change configuration defaults in a way that is incompatible with stateful data.

  # Habilitar Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
  };

  # Configuración e instalación de Waybar
  programs.waybar = {
    enable = true;
  };

  # Configuración e instalación de Kitty
  programs.kitty = {
    enable = true;
  };
}
