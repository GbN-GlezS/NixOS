{ pkgs, ... }:

{
#  ### Remove KDE Packages ###
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    discover
    elisa
    gwenview
    khelpcenter
    okular
    qrca
  ];

# ### Remove XTrem ###
  services.xserver.excludePackages = [ pkgs.xterm ];

  environment.systemPackages = with pkgs; [
# ### Material Based Cursor Theme ###
    bibata-cursors

# ### Privacy-oriented browser for Desktop and Laptop computers ###
    brave

# ### GNU Image Manipulation Program ###
    gimp

# ### Easy-to-use paint program ###
    kdePackages.kolourpaint

# ### Office suite that combines text, spreadsheet and presentation editors allowing to create, view and edit local documents ###
    onlyoffice-desktopeditors

# ### Pixel perfect icon theme for Linux ###
    papirus-icon-theme

# ### Play music from the Spotify music service ###
    spotify
  ];

# ### Whether to enable kdeconnect ###
  programs.kdeconnect.enable = true;

# ### OnlyOffice - Install and use missing corefonts & vista-fonts ###
  fonts.packages = with pkgs; [
    # mkdir -p ~/.local/share/fonts
    corefonts   # sudo cp -r /nix/store/*corefonts*/share/fonts/truetype/* ~/.local/share/fonts/
    vista-fonts # sudo cp -r /nix/store/*vista-fonts*/share/fonts/truetype/* ~/.local/share/fonts/
    # sudo chmod 644 ~/.local/share/fonts/*
  ];

# ### Spotify - Local discovery ###
  networking.firewall = {
    allowedTCPPorts = [ 57621 ];
    allowedUDPPorts = [ 5353 ];
  };

# ### Silent boot and native graphical animation ###
  boot = {
    plymouth = {
      enable = true;
    };

    # Enable "Silent boot"
    consoleLogLevel = 0;
    initrd.verbose = false;

    kernelParams = [
      "quiet"
      "rd.udev.log_level=3"
      "rd.systemd.show_status=auto"
    ];

    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    # It will just not appear on screen unless a key is pressed
    loader.timeout = 0;
  };
}
