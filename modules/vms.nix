{ pkgs, ... }:
  {
    environment.systemPackages = with pkgs; [
      libnotify
      libvirt
      qemu
      virt-manager
    ];
  services = {
    qemuGuest = {
      enable = true;
    };
    spice-vdagentd = {
      enable = true;
    };
  };
  virtualisation.libvirtd.enable = true;
  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
}
