{ ... }:

{
  xfconf.settings = {
    xfce4-panel = {
      # 1. Definir cuántos paneles existen por su ID
      "/panels" = [ 1 ];

      # 2. Configurar las propiedades del Panel 1
      "/panels/panel-1/position" = "p=10;x=0;y=0"; # Posición (p=10 es Bottom Center)
      "/panels/panel-1/position-locked" = true;
      "/panels/panel-1/length" = 100; # Longitud en % (100 = Fill)
      "/panels/panel-1/length-adjust" = true;
      "/panels/panel-1/size" = 36; # Altura en pixeles
      "/panels/panel-1/autohide-behavior" = 0; # 0 = Nunca, 1 = Inteligente, 2 = Siempre
      "/panels/panel-1/background-style" = 0; # 0 = Por defecto (Tema GTK)

      # 3. Asignar el orden de los plugins dentro del Panel 1 por su ID único
      "/panels/panel-1/plugin-ids" = [
        1 # Menú Whisker / Kickoff
        2 # Lanzadores / Accesos rápidos
        3 # Separador expandible
        4 # Área de notificación (Systray)
        5 # Reloj digital
      ];

      # 4. Definir qué tipo de widget es cada ID de plugin

      # Plugin 1: Menú Aplicaciones
      "/plugins/plugin-1" = "whiskermenu"; # O "applicationsmenu"

      # Plugin 2: Lista de tareas / ventanas abiertas
      "/plugins/plugin-2" = "tasklist";
      "/plugins/plugin-2/show-labels" = true;
      "/plugins/plugin-2/grouping" = 1;

      # Plugin 3: Separador (para empujar el reloj/systray a la derecha)
      "/plugins/plugin-3" = "separator";
      "/plugins/plugin-3/expand" = true;
      "/plugins/plugin-3/style" = 0; # 0 = Transparente

      # Plugin 4: Tray de sistema
      "/plugins/plugin-4" = "systray";
      "/plugins/plugin-4/square-icons" = true;

      # Plugin 5: Reloj
      "/plugins/plugin-5" = "clock";
      "/plugins/plugin-5/digital-format" = "%H:%M %d/%m/%Y";
    };
  };
}
