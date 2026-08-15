{ ... }:

{
  programs.plasma = {
    enable = true;

    kscreenlocker = {
      # Lock screen automatically: Never
      autoLock = false;
      timeout = 0;

      # Lock after waking from sleep (False)
      lockOnResume = false;

      # Delay before password required: Never require password
      passwordRequired = false;
      # passwordRequiredDelay = 0;
    };

    # Keyboard shortcut: Meta+L
    shortcuts."ksmserver"."Lock Session" = [ "Meta+L" ];
  };
}
