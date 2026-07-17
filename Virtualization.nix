# Virtualization.nix
# Configuración de QEMU/KVM con Virt-Manager para NixOS
# Importado desde configuration.nix

{ config, pkgs, ... }:

{
  # ---------------------------------------------------------------
  # Virt-Manager: interfaz gráfica para crear y administrar VMs
  # ---------------------------------------------------------------
  programs.virt-manager.enable = true;

  # ---------------------------------------------------------------
  # Libvirtd: demonio que administra QEMU/KVM
  # ---------------------------------------------------------------
  virtualisation.libvirtd = {
    enable = true;

    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;

      # vTPM, necesario para instalar Windows 11 (requiere TPM 2.0)
      swtpm.enable = true;

      # Nota: a partir de NixOS 26.05 la submodule "ovmf" fue eliminada.
      # Las imágenes OVMF (soporte UEFI) ya vienen incluidas por defecto
      # con QEMU, no requieren configuración adicional.
    };
  };

  # Redirección de dispositivos USB del host hacia el guest vía SPICE
  virtualisation.spiceUSBRedirection.enable = true;

  # ---------------------------------------------------------------
  # Permisos de usuario
  # ---------------------------------------------------------------
  # IMPORTANTE: cambia "nixos" por tu nombre de usuario si es distinto
  users.groups.libvirtd.members = [ "nixos" ];
  users.users."nixos".extraGroups = [ "libvirtd" ];

  # ---------------------------------------------------------------
  # Paquetes adicionales
  # ---------------------------------------------------------------
  environment.systemPackages = with pkgs; [
    qemu
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    virtio-win # drivers VirtIO para guests Windows
  ];

  # ---------------------------------------------------------------
  # Autostart de la red virtual "default" (virbr0)
  # Equivalente declarativo a:
  #   virsh net-autostart default
  #   virsh net-start default
  # ---------------------------------------------------------------
  systemd.services.libvirtd-default-net-autostart = {
    description = "Autostart de la red 'default' de libvirt";
    after = [ "libvirtd.service" ];
    requires = [ "libvirtd.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "oneshot";
    script = ''
      ${pkgs.libvirt}/bin/virsh net-autostart default || true
      ${pkgs.libvirt}/bin/virsh net-start default || true
    '';
  };
}
