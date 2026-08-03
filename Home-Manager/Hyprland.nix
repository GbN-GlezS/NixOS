{ pkgs, ... }:

{
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
