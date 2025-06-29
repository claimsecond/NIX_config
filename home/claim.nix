{ pkgs, ... }:

{
  home.username = "claim";
  home.homeDirectory = "/home/claim";
  home.stateVersion = "25.05"; 
  imports = [
    ./i3-config.nix
    ./kitty-config.nix 
    ./yazi-config.nix
  ];

  programs.neovim.enable = true;
  programs.zsh.enable = true;
  programs.git.enable = true;
  programs.firefox.enable = true; 
  programs.yazi.enable = true;

  home-manager.url = "github:nix-community/home-manager";
}
