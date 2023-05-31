{ pkgs, ... }: {

    nixpkgs.config.allowUnfree = true;

    home = {
        username = "sebastian";
        homeDirectory = "/home/sebastian";
        stateVersion = "22.11";
        pointerCursor = {
            name = "Catppuccin-Mocha-Dark-Cursors";
            package = pkgs.catppuccin-cursors.mochaDark;
            size = 16;
        };
    };


    programs.home-manager.enable = true;
    programs.git = {
        enable = true;
        userName = "sebastianselander";
        userEmail = "sebastian.selander@gmail.com";
    };

    home.packages = with pkgs; [
        htop
        neofetch
        lazygit
        thunderbird
        discord
        zsh
        kitty
        polybar
        networkmanagerapplet
        exa
        dmenu
        blueman
        tree
        zsh-powerlevel10k
    ];
}
