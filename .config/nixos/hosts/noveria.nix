{
lib,
pkgs,
# system,
...
}:

{
  hardware.enableRedistributableFirmware = lib.mkDefault true;

  networking.hostName = "noveria";

  swapDevices = [ ];

  # Main user account. Password must be set with ‘passwd’.
  users.users.ty = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      # audio
      # render
      "libvirtd"
      # human # is this better than 'users' as a group name?
      # i2c
      # boinc
      # plugdev
    ];
    uid = 1000;
    shell = pkgs.zsh;
  };
  hardware.openrazer.users = ["ty"];

  environment.systemPackages = with pkgs; [
    liquidctl # TODO: -git?
    # linux-firmware-intel
  ];

  # services.mpd = {
  #   enable = true;
  #   user = "ty";
  #   musicDirectory = "/home/ty/data/mus";
  #   playlistDirectory = "/home/ty/doc/playlists";
  #   extraConfig = ''
  #     audio_output {
  #       type "pipewire"
  #       name "PipeWire Output"
  #     }
  #     audio_output {
  #       type "fifo"
  #       name "ncmpcpp_fifo"
  #       path "/tmp/mpd.fifo"
  #       format "44100:16:2"
  #     }
  #   '';
  #   network.listenAddress = "any";
  # };
  # systemd.services.mpd.environment = {
  #   XDG_RUNTIME_DIR = "/run/user/1000";
  # };


  # Drive Configuration
  #
  # If the options attribute is not set, it'll default to "defaults"
  # boot options for fstab. Search up fstab mount options you can use
  # "users": Allows any user to mount and unmount
  # "nofail": Prevent system from failing if this drive doesn't mount

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max";
        editor = false;
      };
      efi.canTouchEfiVariables = true;
    };

    initrd = {
      systemd.enable = true;
      availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" ];
      kernelModules = [ "dm-snapshot" ];
      luks.devices."nix".device = "/dev/disk/by-uuid/cf94998a-6cae-45da-8ebd-b42ad8cdad64";
    };

    kernelPackages = pkgs.linuxPackages_latest;
    kernel.sysctl."kernel.sysrq" = 1;
  };

  fileSystems = {
    "/" = {
      device = "/dev/mapper/nix";
      fsType = "ext4";
    };

    # 3TB Seagate Barracuda
    "/mnt/data" = {
      device = "/dev/disk/by-uuid/1cc1e9b2-6994-4ec0-a4e2-93583f1e483f";
      fsType = "ext4";
      options = [
        "rw"
        "relatime"
        # dump=0 pass=2
      ];
    };

    # 1TB Western Digital - Pretty old
    "/mnt/old" = {
      device = "/dev/disk/by-uuid/80e51b2c-98b3-41f9-b4c9-51b6fc27122d";
      fsType = "ext4";
      options = [
        "rw"
        "relatime"
        # dump=0 pass=2
      ];
    };

    "/boot" = {
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
  };

  time.timeZone = "America/Los_Angeles";

  system.stateVersion = "26.05";
}
