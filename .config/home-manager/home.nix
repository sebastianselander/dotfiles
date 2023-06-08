{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "sebastian";
  home.homeDirectory = "/home/sebastian";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.language.base = "en_US.UTF-8";

  nixpkgs = {
      config = {
          allowUnfree = true;
      };
  };

  fonts.fontconfig.enable = true;

  programs = {
      git = {
          enable = true;
          userName  = "sebastianselander";
          userEmail = "sebastian.selander@gmail.com";
      };
  };

  home.packages = with pkgs; [
    agda
    pandoc
    happy
    alex
    xmonad-log
    thunderbird
    exa
    git
    rofi
    discord
    polybarFull
    neovim
    flameshot
    pcmanfm
    rofi
    blueberry
    wine
    texlive.combined.scheme-basic
    neofetch
    htop
    neovim
    networkmanagerapplet
    lutris
    nitrogen
    feh
    obs-studio
    wget
    dmenu
    betterlockscreen

    julia-mono
    iosevka
    nerdfonts

  ];

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
