{ pkgs, ... }:

{
# Play music from the Spotify music service.
    environment.systemPackages = with pkgs; [
        spotify
    ];

# Local discovery
    networking.firewall.allowedTCPPorts = [ 57621 ];
    networking.firewall.allowedUDPPorts = [ 5353 ];
}