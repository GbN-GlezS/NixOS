{
  pkgs,
  IconVariant ? "Light",
  CursorVariant ? "Classic",
  CursorSize ? 16,
  FontSize ? 10,
  AccentColor ? "233,58,154",
  LookAndFeel ? "",
  ...
}:

{
  # Set resolution to 1280x720 automatically upon graphical session startup
  systemd.user.services.set-display-resolution = {
    Unit = {
      Description = "Set KDE display resolution to 1280x720";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor output.eDP-1.mode.1280x720@60";
    };
  };

  programs.plasma = {
    enable = true;
    overrideConfig = true;

    configFile."kwalletrc"."Wallet"."Enabled" = false;

    configFile."kwinrc"."NightColor"."Active" = true;
    configFile."kwinrc"."NightColor"."Mode" = "Location";
    configFile."kwinrc"."NightColor"."LocationMode" = "Automatic";
    configFile."kwinrc"."NightColor"."DayTemperature" = 6500;
    configFile."kwinrc"."NightColor"."NightTemperature" = 3750;

    workspace = {
      lookAndFeel = "org.kde.breeze" + LookAndFeel + ".desktop";
      iconTheme = "Papirus-" + IconVariant;

      cursor = {
        theme = "Bibata-Modern-" + CursorVariant;
        size = CursorSize;
      };
    };

    configFile."kdeglobals"."General"."AccentColor" = AccentColor;
    configFile."kdeglobals"."General"."LastUsedCustomAccentColor" = AccentColor;
    configFile."kdeglobals"."Sounds"."Theme" = "freedesktop";
    configFile."ksplashrc"."KSplash"."Theme" = "None";

    fonts = {
      general = {
        family = "Inter";
        pointSize = FontSize;
      };
      fixedWidth = {
        family = "JetBrains Mono";
        pointSize = FontSize;
      };
      small = {
        family = "Inter";
        pointSize = FontSize * 0.8;
      };
      toolbar = {
        family = "Inter";
        pointSize = FontSize;
      };
      menu = {
        family = "Inter";
        pointSize = FontSize;
      };
      windowTitle = {
        family = "Inter";
        pointSize = FontSize;
      };
    };

    panels = [
      {
        location = "bottom";
        alignment = "center";
        lengthMode = "fill";
        hiding = "dodgewindows";
        opacity = "adaptive";
        floating = true;
        height = 35;

        widgets = [
          "org.kde.plasma.kickoff"
          "org.kde.plasma.icontasks"
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
        ];
      }
    ];
  };
}
