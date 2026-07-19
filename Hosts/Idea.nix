{ pkgs, ... }:

{
  systemd.tpm2.enable = false; # Whether to enable systemd TPM2 support.
  boot.initrd.systemd.tpm2.enable = false; # Whether to enable systemd initrd TPM2 support.

  # Configure keymap in X11.
  services.xserver.xkb = {
    layout = "latam"; # X keyboard layout, or multiple keyboard layouts separated by commas.
    variant = ""; # X keyboard variant.
  };

  # Auto login configuration attrset.
  services.displayManager.autoLogin = {
    user = "nixos"; # User to be used for the automatic login.
    enable = true; # Automatically log in as services.displayManager.autoLogin.user.
  };

  # The set of packages that appear in /run/current-system/sw.
  environment.systemPackages = with pkgs; [
    haruna # Open source video player built with Qt/QML and libmpv.
    kdePackages.kamoso # Application to take pictures and videos with your webcam.
  ];
}
