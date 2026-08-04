{
  OrchisColor,
  IconVariant ? "Light",
  ...
}:

{
  # Habilita la gestión de configuraciones de Xfce mediante Home Manager
  xfconf.settings = {
    # Canal para la configuración del gestor de ventanas (Xfwm4)
    xfwm4 = {
      # Establece el tema de bordes de ventana para que coincida con el tema GTK
      "general/theme" = "Orchis-" + OrchisColor + "-" + IconVariant;
    };
  };
}
