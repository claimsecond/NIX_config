{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "FiraCode Nerd Font";
      size = 12;
    };
    extraConfig = ''
      confirm_os_window_close 0
    '';
  };
} 