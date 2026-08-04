{
  OrchisColor,
  IconVariant ? "Light",
  ...
}:

{
  xfconf.settings = {
    # Tema para los bordes de ventana (Xfwm4)
    xfwm4 = {
      "/general/theme" = "Orchis-" + OrchisColor + "-" + IconVariant;
    };

    # Tema GTK global
    xsettings = {
      "/Net/ThemeName" = "Orchis-" + OrchisColor + "-" + IconVariant;
    };
  };
}
