{ pkgs, config, ... }:

{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";
  home.stateVersion = "26.05";

  # Aplicaciones del usuario
  home.packages = with pkgs; [
    thunar
    rofi
  ];

  # Exportar variables de entorno de Home Manager a UWSM
  xdg.configFile."uwsm/env".source =
    "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";

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

  # Configuración de Hyprland alineada con UWSM
  wayland.windowManager.hyprland = {
    enable = true;

    # 1. Usar el paquete y portal de NixOS UWSM
    package = null;
    portalPackage = null;

    # 2. OBLIGATORIO: Desactivar systemd en HM para no generar conflicto con UWSM
    systemd.enable = false;

    # 3. Formato de configuración plano
    configType = "hyprlang";

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
