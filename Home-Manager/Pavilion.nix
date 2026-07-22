{ ... }:

{
  # Desktop Entries allow applications to be shown in your desktop environment's app launcher.
  xdg.desktopEntries = {
    "brave-canva" = {
      name = "Canva";
      genericName = "Graphic design platform";
      comment = "Open Canva as an application";
      exec = "brave --app=https://www.canva.com/";
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
      exec = "brave --app=https://classroom.google.com/";
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
