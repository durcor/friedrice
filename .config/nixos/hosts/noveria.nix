{ config, lib, pkgs, modulesPath, system, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  networking.hostName = "noveria";

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.blacklistedKernelModules = [ "k10temp" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ zenpower ];

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Drive Configuration
  #
  # If the options attribute is not set, it'll default to "defaults"
  # boot options for fstab. Search up fstab mount options you can use
  # "users": Allows any user to mount and unmount
  # "nofail": Prevent system from failing if this drive doesn't mount

  fileSystems."/" = {
    device = "/dev/mapper/nix";
    fsType = "ext4";
  };

  # 3TB Seagate Barracuda
  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-uuid/1cc1e9b2-6994-4ec0-a4e2-93583f1e483f";
    fsType = "ext4";
    options = [
      "rw"
      "relatime"
      # dump=0 pass=2
    ];
  };

  # 1TB Western Digital - Pretty old
  fileSystems."/mnt/old" = {
    device = "/dev/disk/by-uuid/80e51b2c-98b3-41f9-b4c9-51b6fc27122d";
    fsType = "ext4";
    options = [
      "rw"
      "relatime"
      # dump=0 pass=2
    ];
  };

  boot.initrd.luks.devices."nix".device = "/dev/disk/by-uuid/cf94998a-6cae-45da-8ebd-b42ad8cdad64";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/5E37-A80D";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };

  # FIXME: these are LUKS partitions:
  # Samsung 970 Evo Plus: root (lvm) -> /dev/mapper/vga-root
  # fileSystems."/mnt/arch" = {
  #   device = "/dev/disk/by-uuid/d14958e8-e0e0-4896-9098-18f0b7ada01d";
  #   fsType = "ext4";
  #   options = [
  #     "rw"
  #     "relatime"
  #     # "dump=0" "pass=1"
  #   ];
  # };

  # Samsung 970 Evo Plus: home (lvm) -> /dev/mapper/vga-home
  # fileSystems."/mnt/arch/home" = {
  #   device = "/dev/disk/by-uuid/45b78262-d5e8-4613-b502-8c93e1db8356";
  #   fsType = "ext4";
  #   options = [
  #     "rw"
  #     "relatime"
  #     # "dump=0" "pass=2"
  #   ];
  # };

  # Samsung 970 Evo Plus: boot
  # fileSystems."/mnt/arch/boot" = {
  #   device = "/dev/disk/by-uuid/C8E3-CBEE";
  #   fsType = "vfat";
  #   options = [
  #     "rw"
  #     "relatime"
  #     "fmask=0022"
  #     "dmask=0022"
  #     "codepage=437"
  #     "iocharset=iso8859-1"
  #     "shortname=mixed"
  #     "utf8"
  #     "errors=remount-ro"
  #     # dump=0 pass=2
  #   ];
  # };
}
