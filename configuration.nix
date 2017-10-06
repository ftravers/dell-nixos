{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];


  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only


  # Networking
  networking = {
    # networkmanager.enable = true;
    wireless.enable = true;
    hostName = "delldesk"; # Define your hostname.
    interfaces.wlp1s0.ip4 = [ { address = "192.168.0.201"; prefixLength = 24; } ];
    defaultGateway = "192.168.0.1";
    nameservers = [ "8.8.8.8" ];
    nat = {
      enable = true;
      internalInterfaces = ["ve-+"];
      externalInterface = "wlp1s0";
      forwardPorts = [
        { sourcePort = 2222; destination = "192.168.0.202:22"; }
      ];
    };
  };



  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };


  # Set your time zone.
  time.timeZone = "America/Vancouver";


  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    wget vim dhcpcd
    git mkpasswd autoconf gnumake tree ncurses rxvt_unicode wpa_supplicant
    emacs firefox chromium
  ];


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };


  # List services that you want to enable:
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;


  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";


  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;


  system.stateVersion = "17.09"; # Did you read the comment?

}
