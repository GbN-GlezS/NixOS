{ pkgs, ... }:

{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";
  home.stateVersion = "26.05";

  # Instalación de paquetes de usuario
  home.packages = with pkgs; [
    xfce.thunar
  ];

  # Configuración de Rofi (Menú de aplicaciones para Wayland)
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };

  # Configuración de Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "hyprlang";

    settings = {
      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, Q, exec, kitty"
        "$mainMod, E, exec, thunar"
        "$mainMod, R, exec, rofi -show drun" # Menú de aplicaciones con SUPER + R
        "$mainMod, SPACE, exec, rofi -show drun" # Opción alternativa con SUPER + Espacio
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
      ];
    };
  };

  # Configuración e integración de Waybar vía systemd
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "graphical-session.target";
    };
  };

  # Configuración de Kitty
  programs.kitty = {
    enable = true;
  };
}
