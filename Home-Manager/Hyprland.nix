{ pkgs, ... }:

{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";
  home.stateVersion = "26.05";

  # Aplicaciones del usuario
  home.packages = with pkgs; [
    xfce.thunar
  ];

  # Menú de aplicaciones (Rofi)
  programs.rofi = {
    enable = true;
    # No es necesario especificar package, usará pkgs.rofi automáticamente
  };

  # Terminal Kitty
  programs.kitty = {
    enable = true;
  };

  # Barra de estado Waybar
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "graphical-session.target";
    };
  };

  # Configuración de Hyprland
  wayland.windowManager.hyprland = {
    enable = true;

    extraConfig = ''
      $mainMod = SUPER

      # Atajos de teclado
      bind = $mainMod, Q, exec, kitty
      bind = $mainMod, E, exec, thunar
      bind = $mainMod, R, exec, rofi -show drun
      bind = $mainMod, SPACE, exec, rofi -show drun
      bind = $mainMod, C, killactive,
      bind = $mainMod, M, exit,
    '';
  };
}
