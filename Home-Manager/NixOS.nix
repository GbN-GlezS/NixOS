{ ... }:

{
  xdg.desktopEntries = {
    "brave-github" = {
      name = "GitHub";
      exec = "brave --app=https://github.com/";
      icon = "github";
      terminal = false;
      categories = [
        "Development"
        "Network"
        "Utility"
      ];
    };

    "brave-mynixos" = {
      name = "MyNixOS";
      exec = "brave --app=https://mynixos.com/";
      icon = "nix-snowflake";
      terminal = false;
      categories = [
        "Development"
        "Documentation"
        "Network"
      ];
    };

    "brave-nixos-wiki" = {
      name = "NixOS Wiki";
      exec = "brave --app=https://wiki.nixos.org/wiki/NixOS_Wiki";
      icon = "nix-snowflake";
      terminal = false;
      categories = [
        "Development"
        "Documentation"
        "Network"
      ];
    };

    "brave-youtube" = {
      name = "YouTube";
      exec = "brave --app=https://www.youtube.com/";
      icon = "youtube";
      terminal = false;
      categories = [
        "Network"
        "AudioVideo"
      ];
    };
  };
}
