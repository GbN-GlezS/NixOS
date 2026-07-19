{
  config,
  pkgs,
  lib,
  ...
}:

let
  papirus-custom = pkgs.papirus-icon-theme.overrideAttrs (oldAttrs: {
    # Blazing fast: disables the heavy Nix post-build scanning phases for static assets
    dontFixup = true;

    postInstall = (oldAttrs.postInstall or "") + ''
      export XDG_DATA_HOME=$out/share
      ${pkgs.papirus-folders}/bin/papirus-folders -o -C blue -t Papirus
      ${pkgs.papirus-folders}/bin/papirus-folders -o -C blue -t Papirus-Dark
    '';
  });
in

{
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    bibata-cursors # Material Based Cursor Theme.
    inter # Typeface specially designed for user interfaces.
    jetbrains-mono # Typeface made for developers.
    papirus-icon-theme # Pixel perfect icon theme for Linux.
    papirus-folders # Tool to change papirus icon theme color.
    papirus-custom
  ];

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 16;
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = papirus-custom;
    };
    font = {
      name = "Inter";
      size = 10;
      package = pkgs.inter;
    };
  };

  programs.plasma = {
    enable = true;
    overrideConfig = true;

    configFile."kdeglobals"."General"."AccentColor" = "61,174,233";
    configFile."kdeglobals"."General"."LastUsedCustomAccentColor" = "61,174,233";
    configFile."kdeglobals"."KDE"."widgetStyle" = "Breeze";
    configFile."kdeglobals"."Sounds"."Theme" = "freedesktop";

    fonts = {
      general = {
        family = "Inter";
        pointSize = 10;
      };
      fixedWidth = {
        family = "JetBrains Mono";
        pointSize = 10;
      };
      small = {
        family = "Inter";
        pointSize = 8;
      };
      toolbar = {
        family = "Inter";
        pointSize = 10;
      };
      menu = {
        family = "Inter";
        pointSize = 10;
      };
      windowTitle = {
        family = "Inter";
        pointSize = 10;
      };
    };

    workspace = {
      colorScheme = "BreezeDark";
      theme = "default";
      iconTheme = "Papirus-Dark";

      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 16;
      };

      windowDecorations = {
        library = "org.kde.breeze";
        theme = "Breeze";
      };

      splashScreen = {
        theme = "None";
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

  xdg.desktopEntries = {
    "brave-whatsapp" = {
      name = "WhatsApp";
      exec = "brave --app=https://web.whatsapp.com/";
      icon = "whatsapp";
      terminal = false;
      categories = [
        "Network"
        "InstantMessaging"
      ];
    };
    "brave-youtube" = {
      name = "YouTube";
      exec = "brave --app=https://www.youtube.com/";
      icon = "youtube";
      terminal = false;
      categories = [
        "Network"
        "Video"
      ];
    };
    "brave-github" = {
      name = "GitHub";
      exec = "brave --app=https://github.com/";
      icon = "github";
      terminal = false;
      categories = [
        "Network"
        "Development"
      ];
    };
    "brave-classroom" = {
      name = "Classroom";
      exec = "brave --app=https://classroom.google.com/";
      icon = "google-classroom";
      terminal = false;
      categories = [
        "Network"
        "Education"
      ];
    };
  };
}
