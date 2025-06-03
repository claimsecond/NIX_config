{ pkgs, ... }:

{
  home.username = "claim";
  home.homeDirectory = "/home/claim";
  home.stateVersion = "25.05";

  programs.neovim.enable = true;
  programs.zsh.enable = true;
  programs.git.enable = true;
  programs.firefox.enable = true;

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      font = "pango:monospace 9";
      keybindings = {
        "Mod4+Return" = "exec kitty";
        "Mod4+q" = "kill";
      };
      # Здесь можно добавить другие настройки i3
    };
  };

  # Пример: добавить свои dotfiles, алиасы, плагины и т.д.
  # home.file.".config/nvim/init.vim".text = "...";
}
