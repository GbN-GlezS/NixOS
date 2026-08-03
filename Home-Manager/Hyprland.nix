{ pkgs, ... }:

{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";
  home.stateVersion = "26.05";

  # Aplicaciones del usuario (usando pkgs.thunar en lugar de xfce.thunar)
  home.packages = with pkgs; [
    thunar
  ];

  # Menú de aplicaciones (Rofi)
  programs.rofi = {
    enable = true;
  };

  # Terminal Kitty
  programs.kitty = {
    enable = true;
  };

  # Barra de estado Waybar (actualizado a targets como lista)
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      targets = [ "graphical-session.target" ];
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
