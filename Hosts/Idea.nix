{ pkgs, ... }:

{
  systemd.tpm2.enable = false; # Whether to enable systemd TPM2 support.
  boot.initrd.systemd.tpm2.enable = false; # Whether to enable systemd initrd TPM2 support.

  # Auto login configuration attrset.
  services.displayManager.autoLogin = {
    user = "nixos"; # User to be used for the automatic login.
    enable = true; # Automatically log in as services.displayManager.autoLogin.user.
  };
}
