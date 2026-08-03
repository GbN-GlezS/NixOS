{ pkgs, ... }:

{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";
  home.stateVersion = "26.05";

  wayland.windowManager.hyprland = {
    enable = true;

    # Forzar la sintaxis hyprlang tradicional
    configType = "hyprlang";

    settings = {
      "$mainMod" = "SUPER";

      exec-once = [
        "waybar"
      ];

      bind = [
        "$mainMod, Q, exec, kitty"
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
      ];

      windowrule = [
        "border_size 2, kitty"
      ];
    };
  };

  programs.kitty = {
    enable = true;
  };

  programs.waybar = {
    enable = true;
  };
}
