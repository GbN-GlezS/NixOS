{ pkgs, ... }:

{
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "latam";
    variant = "";
  };
  
# ### List of default packages to exclude from the configuration ###
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
  ];
  
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
