# https://wiki.nixos.org/wiki/Plymouth

{
  GPU ? "amdgpu",
  ...
}:

{
  boot = {
    plymouth = {
      enable = true; # Whether to enable Plymouth boot splash screen.
      theme = "breeze"; # Splash screen theme.
    };

    consoleLogLevel = 3; # The kernel console loglevel.

    initrd = {
      verbose = false; # Verbosity of the initrd.
      kernelModules = [ GPU ]; # Set of modules that are always loaded by the initrd.
    };

    loader.timeout = 0; # Timeout (in seconds) until loader boots the default menu item.

    # Parameters added to the kernel command line.
    kernelParams = [
      "quiet"
      "rd.udev.log_level=3"
      "rd.systemd.show_status=auto"
      # "systemd.show_status=false"
      # "rd.udev.log_level=3"
      # "udev.log_priority=3"
    ];
  };
}
