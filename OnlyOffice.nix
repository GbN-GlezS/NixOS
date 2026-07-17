# https://wiki.nixos.org/wiki/ONLYOFFICE

{ pkgs, lib, ... }:

{
  # Office suite that combines text, spreadsheet and presentation editors allowing to create, view and edit local documents.
  environment.systemPackages = with pkgs; [
    onlyoffice-desktopeditors
  ];

  # Allow installation of unfree corefonts & vista-fonts packages
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "corefonts"
      "vista-fonts"
    ];

  fonts.packages = with pkgs; [
    corefonts
    vista-fonts
  ];
}
