{ pkgs, ... }:

{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";
  home.stateVersion = "26.05"; # Se mantiene intacto según requerimiento

  # Aplicaciones del usuario
  home.packages = with pkgs; [
    thunar
    rofi
  ];

  # Terminal Kitty
  programs.kitty = {
    enable = true;
  };

  # Barra de estado Waybar
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

    # Al ser stateVersion >= 26.05, estructuramos settings de forma limpia
    settings = {
      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, Q, exec, ${pkgs.kitty}/bin/kitty"
        "$mainMod, E, exec, ${pkgs.thunar}/bin/thunar"
        "$mainMod, R, exec, ${pkgs.rofi}/bin/rofi -show drun"
        "$mainMod, SPACE, exec, ${pkgs.rofi}/bin/rofi -show drun"
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
      ];
    };
  };
}
