{ webAppEngine, ... }:

{
  programs.plasma = {
    enable = true;
    overrideConfig = true;

    # Desactivar Baloo (indexador de archivos) declarativamente
    configFile."baloorc"."Basic Settings"."Indexing-Enabled" = false;
  };

  # Desktop Entries allow applications to be shown in your desktop environment's app launcher.
  xdg.desktopEntries = {
    "app-canva" = {
      name = "Canva";
      genericName = "Graphic design platform";
      comment = "Open Canva as an application";
      exec = "firefox --start-maximized --app=https://www.canva.com/";
      icon = "${../../Packages/Icons/Canva.svg}";
      terminal = false;
      type = "Application";
      categories = [
        "Graphics"
        "Network"
      ];
    };

    "app-classroom" = {
      name = "Classroom";
      genericName = "Virtual classroom platform";
      comment = "Open Google Classroom as an application";
      exec = "firefox --start-maximized --app=https://classroom.google.com/";
      icon = "${../../Packages/Icons/Classroom.svg}";
      terminal = false;
      type = "Application";
      categories = [
        "Education"
        "Network"
      ];
    };

    "app-meet" = {
      name = "Meet";
      genericName = "Video Conferencing";
      comment = "Open Meet as an application";
      exec = "firefox --start-maximized --app=https://meet.google.com/";
      icon = "google-meet";
      terminal = false;
      type = "Application";
      categories = [
        "Network"
        "VideoConference"
      ];
    };
  };
}
