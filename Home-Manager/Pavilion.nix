{ ... }:

{
  programs.plasma = {
    enable = true;
    overrideConfig = true;

    # Desactivar Baloo (indexador de archivos) declarativamente
    configFile."baloorc"."Basic Settings"."Indexing-Enabled" = false;
  };

  # Desktop Entries allow applications to be shown in your desktop environment's app launcher.
  xdg.desktopEntries = {
    "brave-canva" = {
      name = "Canva";
      genericName = "Graphic design platform";
      comment = "Open Canva as an application";
      exec = "brave --start-maximized --app=https://www.canva.com/";
      icon = "${./Icons/Canva.svg}";
      terminal = false;
      type = "Application";
      categories = [
        "Graphics"
        "Network"
      ];
    };

    "brave-classroom" = {
      name = "Classroom";
      genericName = "Virtual classroom platform";
      comment = "Open Google Classroom as an application";
      exec = "brave --start-maximized --app=https://classroom.google.com/";
      icon = "${./Icons/Classroom.svg}";
      terminal = false;
      type = "Application";
      categories = [
        "Education"
        "Network"
      ];
    };
  };
}
