{ pkgs, ... }:

{
  users.users.yourusername.extraGroups = [ "video" ];
  programs.light.enable = true;
  environment.systemPackages = [ pkgs.pulseaudio ];
}
