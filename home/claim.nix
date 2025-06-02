{ pkgs, ... }:

{
  home.username = "claim";
  home.homeDirectory = "/home/claim";
  home.stateVersion = "25.05";

  programs.neovim.enable = true;
  programs.zsh.enable = true;
  programs.git.enable = true;
  programs.firefox.enable = true;

  # Пример: добавить свои dotfiles, алиасы, плагины и т.д.
  # home.file.".config/nvim/init.vim".text = "...";
}
