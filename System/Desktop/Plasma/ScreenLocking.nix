{ ... }:

{
  programs.plasma = {
    enable = true;

    kscreenlocker = {
      autoLock = false;
      timeout = 0;
      lockOnResume = false;
      passwordRequired = false;
      passwordRequiredDelay = 0;
    };

    # This matches the "Meta+L" state shown in the image.
    # If you actually want to disable it, change this back to [ ]
    shortcuts."ksmserver"."Lock Session" = [ "Meta+L" ];
  };
}
