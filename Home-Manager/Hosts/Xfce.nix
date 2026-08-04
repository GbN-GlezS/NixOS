{
  OrchisColor,
  ...
}:

{
  xfconf.settings = {
    # Tema para los bordes de ventana (Xfwm4)
    xfwm4 = {
      "/general/theme" = "Orchis-" + OrchisColor + "-Dark";
    };

    # Tema GTK global
    xsettings = {
      "/Net/ThemeName" = "Orchis-" + OrchisColor + "-Dark";
    };
  };
}
