{ pkgs, ... }:

{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";
  home.stateVersion = "26.05";

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "hyprlang";

    settings = {
      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, Q, exec, kitty"
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

  programs.kitty = {
    enable = true;
  };
}
