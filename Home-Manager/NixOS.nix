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
