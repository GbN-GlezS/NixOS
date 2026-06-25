{ pkgs, ... }:

{
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "colemak";
  };

# ### List of default packages to exclude from the configuration ###
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
  ];

  environment.systemPackages = with pkgs; [
# ### GNU Image Manipulation Program ###
    gimp

# ### Easy-to-use paint program ###
    kdePackages.kolourpaint

# Distributed version control system.
    git
  ];

# ### Whether to enable kdeconnect ###
  programs.kdeconnect.enable = true;
}
