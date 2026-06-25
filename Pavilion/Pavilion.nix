{ pkgs, lib, ... }:

{
# ### Inicio de Sesión Automático (SDDM + KDE Plasma) ###
  services.displayManager.autoLogin = {
    enable = true;
    user = "nixos";
  };

# ### Which X11 packages to exclude from the default environment ###
  services.xserver.excludePackages = with pkgs; [ xterm ];

# ### List of default packages to exclude from the configuration ###
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    discover
    khelpcenter
    okular
  ];

  environment.systemPackages = with pkgs; [
# ### Navegador Web ###
    brave

# ### Personalización KDE ###
    papirus-icon-theme
    bibata-cursors

# ### Ofimática
    onlyoffice-desktopeditors

# ### Play music from the Spotify music service ###
    spotify
  ];

# ### Tipografías Microsoft ###
  fonts.packages = with pkgs; [
    corefonts   # sudo cp -r /nix/store/*-corefonts-*/share/fonts/truetype/* ~/.local/share/fonts/
    vista-fonts # sudo cp -r /nix/store/*-vista-fonts-*/share/fonts/truetype/* ~/.local/share/fonts/
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
