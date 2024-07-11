# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./nvidia.nix
    ];

  nix.settings.experimental-features = [ "flakes" "nix-command" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  virtualisation.virtualbox.host.enable = true;
  nixpkgs.config.virtualbox.enableExtensionPack = true;


  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  
  # Enable networking
  networking.networkmanager.enable = true;
<<<<<<< HEAD
=======
  networking.extraHosts =
  ''
    127.0.0.1 pve
  '';
>>>>>>> 49c94be (latest fixes)
  systemd.services.NetworkManager-wait-online.enable = false;

  # Set your time zone.
  time.timeZone = "Africa/Johannesburg";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_ZA.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  
  # compositor
  services.picom.enable = false;

  # Configure keymap in X11
  services.xserver = {
    layout = "za";
    xkbVariant = "";
  };

  fonts.fontconfig.antialias = true;
  fonts.packages = with pkgs; [
    # https://nixos.wiki/wiki/Fonts
    (nerdfonts.override { fonts = [ "FiraCode" "SourceCodePro" ]; })
     fira
     fira-code
     roboto
     libertine
     source-serif-pro
     stix-two
     vistafonts
    ];

  # Virtualisation
  virtualisation.docker.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
<<<<<<< HEAD
=======
  security.sudo.configFile = "
   Cmnd_Alias GDMRST = /bin/restart-gdm.sh
   carl ALL=NOPASSWD:/bin/restart-gdm.sh
   ";
>>>>>>> 49c94be (latest fixes)

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.carl = {
    isNormalUser = true;
    description = "Carl";
    extraGroups = [ "networkmanager" "wheel" "docker" "vboxusers"];
    packages = with pkgs; [
       anydesk
    ];
  };

# +++++++++++++++++++++ PROGRAMS ++++++++++++++++++++++++++++++++++++
  # Install firefox.
  programs.firefox.enable = true;
  
  # Install tailscale
  services.tailscale.enable = true;

  programs.dconf = {
	 enable = true; 
  };

  # Install 1pass
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    polkitPolicyOwners = [ "carl" ];
  };

  # Install zsh
  programs.zsh = {
      enable = true;
      autosuggestions.enable = true;
      zsh-autoenv.enable = true;
      syntaxHighlighting.enable = true;
      ohMyZsh = {
         enable = true;
         theme = "af-magic";
         plugins = [
           "git"
           "npm"
           "history"
           "node"
           "rust"
           "deno"
         ];
      };
   };

users.defaultUserShell = pkgs.zsh;


  # Install steam
  programs.steam = {
   enable = true;
   remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
   dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true; 
  nixpkgs.config.nvidia.acceptLicense = true;
	
#packer = {
#		enable = true ;
#		required_plugins = {
#        virtualbox = {
#          version = "~> 1";
#          source  = "github.com/hashicorp/virtualbox";
#        };
#    };
#};

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
   # vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
<<<<<<< HEAD
    wget
    qemu
    neovim
    docker
    curl
    git
    zsh
    anydesk
    slack
    jetbrains.idea-community
    gitui
    clojure-lsp
    clojure
    libreoffice
    gnomeExtensions.notification-timeout
    gnomeExtensions.system-monitor
    gnomeExtensions.notification-banner-position
    dconf
=======
	wget
	qemu
	neovim
	docker
	curl
	git
	zsh
	anydesk
	slack
	jetbrains.idea-community
	gitui
	clojure-lsp
	clojure
	libreoffice
	gnomeExtensions.notification-timeout
	gnomeExtensions.system-monitor
	gnomeExtensions.notification-banner-reloaded
	dconf
	home-manager
	packer
	vagrant
	docker-compose
	python3
	kitty
>>>>>>> 49c94be (latest fixes)

   #WINE
   # support both 32- and 64-bit applications
    wineWowPackages.stable

    # support 32-bit only
    #wine

    # support 64-bit only
    (wine.override { wineBuild = "wine64"; })

    # support 64-bit only
    wine64

    # wine-staging (version with experimental features)
    wineWowPackages.staging

    # winetricks (all versions)
    winetricks

    # native wayland support (unstable)
<<<<<<< HEAD
    wineWowPackages.waylandFull
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
=======
    wineWowPackages.waylandFull];
>>>>>>> 49c94be (latest fixes)

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
    };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?


}

