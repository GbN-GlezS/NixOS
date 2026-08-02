{ pkgs, ... }:

{
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    kitty
    fuzzel
    waybar
  ];

  services.waybar = {
    enable = true;
    systemd.enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mod" = "SUPER";

      bind = [
        "$mod, Return, exec, kitty"
        "$mod, D, exec, fuzzel"
        "$mod, Q, killactive"
      ];

      monitor = [
        ",preferred,auto,1"
      ];
    };
  };
}
