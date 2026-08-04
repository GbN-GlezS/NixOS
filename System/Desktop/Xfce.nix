# https://wiki.nixos.org/wiki/Xfce

{
  programs.xfconf.enable = true;

  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };

    displayManager = {
      lightdm.enable = true;
    };
  };

  services.displayManager.defaultSession = "xfce";
}
