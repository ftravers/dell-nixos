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


  # Containers

    containers.fud = {
    autoStart = true; 
    privateNetwork = true;
    hostAddress = "192.168.1.200";
    localAddress = "192.168.1.201";
    config = { config, pkgs, ...}: {

      # Set your time zone.
      time.timeZone = "America/Vancouver";

      networking.firewall.enable = false;
      services.openssh.enable = true;

      # List packages installed in system profile
      environment.systemPackages = with pkgs; [
        wget vim emacs git zsh autoconf gnumake tree 
        ncurses rxvt_unicode openjdk leiningen
      ];

      users.extraUsers.fenton = {
        isNormalUser = true;
        uid = 1000;
        hashedPassword = "$6$/pK0lFCWLEBBWMJ$S9vMo8Qd2YL1jRuw4S8O7xdB/S4bBaPUVgWQOCkfUK19fJAD2cVGwRKG3017YnbjzFbMkVG5Xe3RuNhWY6zZY/";
        extraGroups = [ "wheel" ];
        openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDAG5wvPKRrqqiOBKZ5dUqF5oK7vd1zNuVsrrAAQCcEkVC2SBXVy5yiCiO7xPz7Wk6oSl+5nvkitYQ4HVuNO+mroUcmbge/e344sfyOytrV2BqFTuijlc+BkBTMk55piHKBgl50l4gIdtTdKk1b0iiTxc5gdhlUr4LUF+mPc5NnuKgMEJLApoFeNKrzbR+Z5ZsLypeFNxzkaAw8mjqRoDoi1lab7tDN/KrVKZ46AYXm9Tix64MdxXI6T+p6Z+2rAQQ0ieexVtVUJBiifaKrvqgr57v8WPFk8VIYb9MbtlxtHdHz/regzZA4L6K+46QpSFeBX29esx1/tuihv/hU8ndf fenton@ss9" ];
      };
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
    git mkpasswd autoconf gnumake tree ncurses rxvt_unicode 
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
  services.xserver.enable = true;
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";


  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;


  system.stateVersion = "17.09"; # Did you read the comment?

}
