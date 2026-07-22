{ ... }:

{
  # Desktop Entries allow applications to be shown in your desktop environment's app launcher.
  xdg.desktopEntries = {
    "brave-github" = {
      name = "GitHub";
      genericName = "Git repository hosting";
      comment = "Open GitHub as an application";
      exec = "brave --app=https://github.com/";
      icon = "github";
      terminal = false;
      type = "Application";
      categories = [
        "Development"
        "Network"
        "Utility"
      ];
    };

    "brave-mynixos" = {
      name = "MyNixOS";
      genericName = "NixOS package search";
      comment = "Open MyNixOS as an application";
      exec = "brave --app=https://mynixos.com/";
      icon = "nix-snowflake";
      terminal = false;
      type = "Application";
      categories = [
        "Development"
        "Documentation"
        "Network"
      ];
    };

    "brave-nixos-wiki" = {
      name = "NixOS Wiki";
      genericName = "NixOS documentation";
      comment = "Open NixOS Wiki as an application";
      exec = "brave --app=https://wiki.nixos.org/wiki/NixOS_Wiki";
      icon = "nix-snowflake";
      terminal = false;
      type = "Application";
      categories = [
        "Development"
        "Documentation"
        "Network"
      ];
    };

    "brave-youtube" = {
      name = "YouTube";
      genericName = "Video streaming service";
      comment = "Open YouTube as an application";
      exec = "brave --app=https://www.youtube.com/";
      icon = "youtube";
      terminal = false;
      type = "Application";
      categories = [
        "AudioVideo"
        "Network"
      ];
    };
  };
}
