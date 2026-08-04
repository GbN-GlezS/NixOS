# https://wiki.nixos.org/wiki/Xfce

{
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
