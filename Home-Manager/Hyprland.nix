{ pkgs, ... }:

{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";
  home.stateVersion = "26.05";

  # 1. Desactivar systemd en Home Manager para no pisotear UWSM
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;

    # Sincronizar paquetes con el módulo de NixOS
    package = null;
    portalPackage = null;

    # Forzar hyprlang tradicional
    configType = "hyprlang";

    settings = {
      "$mainMod" = "SUPER";

      # Binds explícitos
      bind = [
        "$mainMod, Q, exec, kitty"
        "$mainMod, E, exec, thunar"
        "$mainMod, R, exec, rofi -show drun"
        "$mainMod, SPACE, exec, rofi -show drun"
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
      ];
    };
  };

  # Aplicaciones del usuario
  home.packages = with pkgs; [
    thunar
    rofi
  ];

  programs.kitty = {
    enable = true;
  };

  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      targets = [ "graphical-session.target" ];
    };
  };
}
