{ pkgs, ... }:

{
  home.stateVersion = "26.05"; # It is occasionally necessary for Home Manager to change configuration defaults in a way that is incompatible with stateful data.

  home.packages = with pkgs; [
    kitty
    fuzzel
    waybar
  ];

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "waybar"
    ];
  };
}
