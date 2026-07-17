# https://wiki.nixos.org/wiki/Spotify

{ pkgs, ... }:

{
  # These packages are automatically available to all users, and are automatically updated every time you rebuild the system configuration.
  environment.systemPackages = with pkgs; [
    spotify # Play music from the Spotify music service.
  ];

  networking.firewall.allowedTCPPorts = [ 57621 ]; # List of TCP ports on which incoming connections are accepted.
  networking.firewall.allowedUDPPorts = [ 5353 ]; # List of open UDP ports.
}
