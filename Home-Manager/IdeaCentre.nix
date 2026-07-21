{ ... }:

{
  xdg.desktopEntries = {
    "brave-canva" = {
      name = "Canva";
      exec = "brave --app=https://www.canva.com/";
      icon = "${./Icons/Canva.svg}";
      terminal = false;
      categories = [
        "Graphics"
        "Network"
      ];
    };
    "brave-classroom" = {
      name = "Classroom";
      exec = "brave --app=https://classroom.google.com/";
      icon = "${./Icons/Classroom.svg}";
      terminal = false;
      categories = [
        "Education"
        "Network"
      ];
    };
  };
}
