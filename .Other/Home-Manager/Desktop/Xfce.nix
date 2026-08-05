{
  pkgs,
  OrchisColor,
  IconVariant ? "Light",
  ...
}:

{
  # 1. Archivo XML para los bordes de ventana de Xfwm4
  xdg.configFile."xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml".text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <channel name="xfwm4" version="1.0">
      <property name="general" type="empty">
        <property name="theme" type="string" value="Orchis-${OrchisColor}-Dark"/>
      </property>
    </channel>
  '';

  # 2. Archivo XML para el tema GTK global (Xsettings)
  xdg.configFile."xfce4/xfconf/xfce-perchannel-xml/xsettings.xml".text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <channel name="xsettings" version="1.0">
      <property name="Net" type="empty">
        <property name="ThemeName" type="string" value="Orchis-${OrchisColor}-Dark"/>
        <property name="IconThemeName" type="string" value="Papirus-${IconVariant}"/>
      </property>
    </channel>
  '';

  # 3. Archivo XML para los paneles
  xdg.configFile."xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml".text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <channel name="xfce4-panel" version="1.0">
      <property name="panels" type="array">
        <value type="int" value="1"/>
        <property name="panel-1" type="empty">
          <property name="position" type="string" value="p=10;x=0;y=0"/>
          <property name="length" type="uint" value="100"/>
          <property name="position-locked" type="bool" value="true"/>
          <property name="size" type="uint" value="36"/>
          <property name="plugin-ids" type="array">
            <value type="int" value="1"/>
            <value type="int" value="2"/>
            <value type="int" value="3"/>
            <value type="int" value="4"/>
          </property>
        </property>
      </property>
      <property name="plugins" type="empty">
        <property name="plugin-1" type="string" value="whiskermenu"/>
        <property name="plugin-2" type="string" value="tasklist"/>
        <property name="plugin-3" type="string" value="separator">
          <property name="expand" type="bool" value="true"/>
          <property name="style" type="uint" value="0"/>
        </property>
        <property name="plugin-4" type="string" value="clock"/>
      </property>
    </channel>
  '';
}
