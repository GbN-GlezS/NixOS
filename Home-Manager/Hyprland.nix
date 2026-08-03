{ pkgs, ... }:

{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";
  home.stateVersion = "24.05";

  # Instalación del explorador de archivos (Thunar)
  home.packages = with pkgs; [
    xfce.thunar
  ];

  # Configuración de Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "hyprlang";

    settings = {
      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, Q, exec, kitty"
        "$mainMod, E, exec, thunar" # Atajo para abrir el explorador de archivos
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
