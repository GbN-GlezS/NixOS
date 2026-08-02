# https://wiki.nixos.org/wiki/ONLYOFFICE

{ pkgs, ... }:

{
  # The set of packages to appear in the user environment.
  home.packages = with pkgs; [
    onlyoffice-desktopeditors # Office suite that combines text, spreadsheet and presentation editors allowing to create, view and edit local documents.
    corefonts # Microsoft's TrueType core fonts for the Web.
    vista-fonts # Some TrueType fonts from Microsoft Windows Vista (Calibri, Cambria, Candara, Consolas, Constantia, Corbel).
  ];

  # Attribute set of files to link into the user home.
  home.file = {
    ".local/share/fonts/corefonts".source = "${pkgs.corefonts}/share/fonts/truetype"; # Path of the source file or directory.
    ".local/share/fonts/vista-fonts".source = "${pkgs.vista-fonts}/share/fonts/truetype"; # Path of the source file or directory.
  };
}
