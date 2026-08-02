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
}
