{ ... }:

{
  programs.plasma = {
    enable = true;

    kscreenlocker = {
      timeout = 0; # Lock screen automatically: Never
      lockOnResume = false; # Lock after waking from sleep (False)
      passwordRequired = false; # Delay before password required: Never require password
    };

    shortcuts."ksmserver"."Lock Session" = [ "Meta+L" ]; # Keyboard shortcut: Meta+L
  };
}
