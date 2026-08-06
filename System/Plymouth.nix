# https://wiki.nixos.org/wiki/Plymouth

{ GPU, ... }:

{
  boot = {
    # Habilitar Plymouth para el arranque gráfico.
    # Por defecto, NixOS usa el tema "bgrt" que conserva el logo de tu BIOS (Lenovo/HP) [3, 4].
    # IMPORTANTE: No añadimos "splash" a kernelParams manualmente ya que 'plymouth.enable = true'
    # lo inyecta de forma automática y nativa [3, 5].
    plymouth.enable = true;

    # 1. Silenciar consola del kernel (máximo nivel 0 en lugar de tu actual 3)
    # Esto elimina automáticamente "loglevel=3" de tu /proc/cmdline y lo cambia por
    # "loglevel=0" de forma nativa, suprimiendo advertencias no críticas del kernel [6, 7].
    consoleLogLevel = 0;

    # 2. Desactivar la verbosidad de los scripts en el ramdisk inicial (initrd) [6].
    initrd.verbose = false;

    # 3. HABILITAR systemd en el initrd (Etapa 1 de arranque) [8].
    # Clave en NixOS Unstable: sustituye los antiguos scripts de arranque tradicionales
    # de NixOS (que imprimen ecos de texto inevitables) por systemd, el cual respeta
    # de manera impecable el modo "quiet".
    initrd.systemd.enable = true;

    # Carga temprana del driver gráfico. [11]
    initrd.kernelModules = [ GPU ];

    # 4. Parámetros del kernel simplificados para un silencio total y sin redundancias
    kernelParams = [
      "quiet" # Suprime los mensajes informativos estándar del kernel [9].
      "rd.systemd.show_status=false" # Desactiva estados de systemd en el initrd (evita el modo "auto") [9].
      "systemd.show_status=false" # Desactiva estados de systemd en el sistema real [9].
      "rd.udev.log_level=3" # Limita el registro de udev en la fase inicial [9].
      "udev.log_priority=3" # Limita el registro de udev en el sistema principal [9].
    ];

    # 5. Ocultar la selección de SO en el cargador de arranque [10].
    # Se puede seguir accediendo manteniendo pulsada una tecla durante el encendido.
    loader.timeout = 0;
  };
}
