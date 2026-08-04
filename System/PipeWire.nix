# https://wiki.nixos.org/wiki/PipeWire

{ ... }:

{
  # Disable PulseAudio to prevent conflicts with PipeWire
  services.pulseaudio.enable = false;

  # Enable RealtimeKit (rtkit) to grant PipeWire real-time priority
  # and prevent audio stuttering/dropouts under load
  security.rtkit.enable = true;

  # Core PipeWire configuration
  services.pipewire = {
    enable = true;

    # Enable ALSA support (allows ALSA apps to route through PipeWire)
    alsa.enable = true;
    alsa.support32Bit = true; # Required for 32-bit applications and Steam games

    # Enable PulseAudio emulation layer
    # Crucial for DE volume control applets (Plasma-PA, Xfce mixer, Waybar, pavucontrol)
    pulse.enable = true;

    # Uncomment if you run JACK applications (music production/DAWs)
    # jack.enable = true;
  };
}
