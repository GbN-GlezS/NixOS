{ ... }:

{
  programs.plasma.panels = [
    {
      height = 44; # The height of the panel.
      lengthMode = "fill"; # The length mode of the panel.
      location = "bottom"; # The location of the panel.
      alignment = "center"; # The alignment of the panel.
      hiding = "dodgewindows"; # The hiding mode of the panel.
      floating = true; # Floating style.

      # The widgets to use in the panel.
      widgets = [
        "org.kde.plasma.kickoff"
        "org.kde.plasma.pager"
        "org.kde.plasma.icontasks"
        "org.kde.plasma.marginsseparator"
        "org.kde.plasma.systemtray"
        "org.kde.plasma.digitalclock"
        "org.kde.plasma.showdesktop"
      ];
    }
  ];
}
