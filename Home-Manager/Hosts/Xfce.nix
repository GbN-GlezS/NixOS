{ pkgs, ... }:

{
  xfconf.settings = {
    # Para el tema GTK y bordes
    xfwm4 = {
      "/general/theme" = "Orchis-Pink-Dark";
    };

    xsettings = {
      "/Net/ThemeName" = "Orchis-Pink-Dark";
    };

    # Si usas arreglos en xfce4-panel, asegúrate de que los enteros se traten como int de Xfconf:
    xfce4-panel = {
      "/panels" = [
        {
          type = "int";
          value = 1;
        }
      ];
      "/panels/panel-1/plugin-ids" = [
        {
          type = "int";
          value = 1;
        }
        {
          type = "int";
          value = 2;
        }
        {
          type = "int";
          value = 3;
        }
        {
          type = "int";
          value = 4;
        }
      ];
      "/panels/panel-1/position" = "p=10;x=0;y=0";
      "/panels/panel-1/length" = {
        type = "int";
        value = 100;
      };
      "/panels/panel-1/size" = {
        type = "int";
        value = 36;
      };

      "/plugins/plugin-1" = "whiskermenu";
      "/plugins/plugin-2" = "tasklist";
      "/plugins/plugin-3" = "separator";
      "/plugins/plugin-4" = "clock";
    };
  };
}
