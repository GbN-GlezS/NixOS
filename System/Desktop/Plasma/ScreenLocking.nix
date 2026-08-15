{ ... }:

{
  programs.plasma = {
    enable = true;

    kscreenlocker = {
      autoLock = false; # Lock screen automatically: Never
      lockOnResume = false; # Lock after waking from sleep (False)
      passwordRequired = false; # Delay before password required: Never require password
    };

    shortcuts."ksmserver"."Lock Session" = [ ]; # Keyboard shortcut: None
  };
}
