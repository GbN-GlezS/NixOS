{ pkgs, ... }:

{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";
  home.stateVersion = "26.05"; # Asegúrate de que coincida con tu versión de NixOS

  # Configuración de Hyprland
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mainMod" = "SUPER";

      # Autostart: Ejecuta Waybar al iniciar Hyprland
      exec-once = [
        "waybar"
      ];

      # Atajos básicos para Kitty y gestión de ventanas
      bind = [
        "$mainMod, Q, exec, kitty"
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
      ];

      # Regla de ventana para Kitty (mencionada en el manual)
      windowrule = [
        "border_size 2, match:class:kitty"
      ];
    };
  };

  # Habilitación e instalación de Kitty
  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      background_opacity = "0.9";
    };
  };

  # Habilitación e instalación de Waybar
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "clock" ];

        clock = {
          format = "{:%H:%M - %d/%m/%Y}";
        };
      };
    };
  };
}
