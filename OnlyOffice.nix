# https://wiki.nixos.org/wiki/ONLYOFFICE

{ pkgs, lib, ... }:

{
  # These packages are automatically available to all users, and are automatically updated every time you rebuild the system configuration.
  environment.systemPackages = with pkgs; [
    onlyoffice-desktopeditors # Office suite that combines text, spreadsheet and presentation editors allowing to create, view and edit local documents.
  ];

  # Allow installation of unfree corefonts & vista-fonts packages.
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "corefonts" # Microsoft's TrueType core fonts for the Web.
      "vista-fonts" # Some TrueType fonts from Microsoft Windows Vista (Calibri, Cambria, Candara, Consolas, Constantia, Corbel).
    ];

  # List of primary font packages.
  fonts.packages = with pkgs; [
    corefonts # Microsoft's TrueType core fonts for the Web.
    vista-fonts # Some TrueType fonts from Microsoft Windows Vista (Calibri, Cambria, Candara, Consolas, Constantia, Corbel).
  ];
}
