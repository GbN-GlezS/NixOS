{ pkgs, ... }:

{
  networking.hostName = "NixOS"; # Define your hostname.

  environment.systemPackages = with pkgs; [
# ### GNU Image Manipulation Program ###
    gimp

# ### Easy-to-use paint program ###
    kdePackages.kolourpaint

# ### Play music from the Spotify music service ###
    spotify
  ];

# ### Whether to enable kdeconnect ###
  programs.kdeconnect.enable = true;

# ### Spotify - Local discovery ###
  networking.firewall = {
    allowedTCPPorts = [ 57621 ];
    allowedUDPPorts = [ 5353 ];
  };
}
