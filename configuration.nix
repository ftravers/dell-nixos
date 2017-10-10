{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];


  # GRUB boot loader ###############################
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";


  # Networking #####################################
  networking = {
    # networkmanager.enable = true;


    interfaces.wlp1s0.ip4 = [ { address = "192.168.1.201"; prefixLength = 24; } ];
    defaultGateway = "192.168.1.254";
    nameservers = [ "8.8.8.8" ];


    wireless = {
      enable = true;
      interfaces = ["wlp1s0"];
      userControlled.enable = true;
      userControlled.group = "wheel";
      networks = {
        "1529-5G" = {
      	  psk = "abc7654321";
        };
      };
    };

    hostName = "delldesk"; # Define your hostname.

    # interfaces.wlp1s0.ip4 = [ { address = "192.168.0.201"; prefixLength = 24; } ];
    # defaultGateway = "192.168.0.1";
    # nameservers = [ "8.8.8.8" ];
    # nat = {
    #   enable = true;
    #   internalInterfaces = ["ve-+"];
    #   externalInterface = "wlp1s0";
    #   forwardPorts = [
    #     { sourcePort = 2222; destination = "192.168.0.202:22"; }
    #   ];
    # };
  };



  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };


  time.timeZone = "America/Vancouver";


  # Packages ############################################
  environment.systemPackages = with pkgs; [
    wget vim dhcpcd emacs firefox chromium git mkpasswd
    autoconf gnumake tree ncurses rxvt_unicode wpa_supplicant
  ];


  programs.bash.enableCompletion = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };


  # Enabled Services ##################################
  services.openssh.enable = true;


  networking.firewall.enable = false;


  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";


  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;


  system.stateVersion = "17.09";
}
