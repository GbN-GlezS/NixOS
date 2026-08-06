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
      "rd.udev.log_level=0"
      "rd.systemd.show_status=no"

      "loglevel=0"
      "vt.global_cursor_default=0"
      "plymouth.ignore-serial-consoles"
      "rd.debug=0" # Asegura sin debug
      "rd.udev.children_max=0" # Reduce actividad de udev
      "systemd.show_status=no" # Sin status en el sistema principal
    ];

    loader.timeout = 0; # Timeout (in seconds) until loader boots the default menu item.
  };
}
