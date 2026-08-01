# https://wiki.nixos.org/wiki/Plymouth

{ ... }:

{
  boot = {
    plymouth = {
      enable = true; # Whether to enable Plymouth boot splash screen.
    };

    consoleLogLevel = 0; # The kernel console loglevel.
    initrd.verbose = false; # Verbosity of the initrd.

    # Parameters added to the kernel command line.
    kernelParams = [
      "quiet"
      "rd.udev.log_level=3"
      "rd.systemd.show_status=auto"
    ];

    loader.timeout = 0; # Timeout (in seconds) until loader boots the default menu item.
  };
}
