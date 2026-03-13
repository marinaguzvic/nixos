{ config, pkgs, ... }:

{
  virtualisation.docker.enable = true;
  users.extraGroups.vboxusers.members = [ "marinadj" ];

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
    };
  };
}
