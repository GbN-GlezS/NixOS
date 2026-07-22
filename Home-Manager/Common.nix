{
  StateVersion,
  pkgs,
  ThemeColor,
  IconVariant,
  CursorVariant,
  CursorSize,
  FontSize,
  AccentColor,
  LookAndFeel,
  ...
}:

let
  papirus-icon-theme-custom = pkgs.papirus-icon-theme.overrideAttrs (oldAttrs: {
    dontFixup = true;
    postInstall = (oldAttrs.postInstall or "") + ''
      export XDG_DATA_HOME="$out/share"
      ${pkgs.papirus-folders}/bin/papirus-folders -o -C ${ThemeColor} -t Papirus
      ${pkgs.papirus-folders}/bin/papirus-folders -o -C ${ThemeColor} -t Papirus-${IconVariant}
    '';
  });
in

{
  home.stateVersion = StateVersion; # It is occasionally necessary for Home Manager to change configuration defaults in a way that is incompatible with stateful data.

  # The set of packages to appear in the user environment.
  home.packages = with pkgs; [
    bibata-cursors # Material Based Cursor Theme.
    inter # Typeface specially designed for user interfaces.
    jetbrains-mono # Typeface made for developers.
    papirus-folders # Tool to change papirus icon theme color.
    papirus-icon-theme-custom # Pixel perfect icon theme for Linux.
  ];

  # Cursor configuration.
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    name = "Bibata-Modern-" + CursorVariant;
    package = pkgs.bibata-cursors;
    size = CursorSize;
  };

  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus-" + IconVariant;
      package = papirus-icon-theme-custom;
    };

    font = {
      name = "Inter";
      size = FontSize;
      package = pkgs.inter;
    };
  };

  programs.plasma = {
    enable = true;
    overrideConfig = true;

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

  # Desktop Entries allow applications to be shown in your desktop environment's app launcher.
  xdg.desktopEntries = {
    "brave-chatgpt" = {
      name = "ChatGPT";
      genericName = "AI assistant";
      comment = "Open ChatGPT as an application";
      exec = "brave --start-maximized --app=https://chatgpt.com/";
      icon = "${./Icons/ChatGPT-Dark.svg}";
      terminal = false;
      type = "Application";
      categories = [
        "Network"
        "Utility"
      ];
    };

    "brave-gemini" = {
      name = "Gemini";
      genericName = "AI assistant";
      comment = "Open Gemini as an application";
      exec = "brave --start-maximized --app=https://gemini.google.com/";
      icon = "${./Icons/Gemini.svg}";
      terminal = false;
      type = "Application";
      categories = [
        "Network"
        "Utility"
      ];
    };

    "brave-whatsapp" = {
      name = "WhatsApp";
      genericName = "Messaging application";
      comment = "Open WhatsApp Web as an application";
      exec = "brave --start-maximized --app=https://web.whatsapp.com/";
      icon = "whatsapp";
      terminal = false;
      type = "Application";
      categories = [
        "Network"
      ];
    };
  };
}
