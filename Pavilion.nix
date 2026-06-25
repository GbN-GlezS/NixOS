{ pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
# ### Play music from the Spotify music service ###
    spotify
  ];

# ### Spotify - Local discovery ###
  networking.firewall = {
    allowedTCPPorts = [ 57621 ];
    allowedUDPPorts = [ 5353 ];
  };
}
