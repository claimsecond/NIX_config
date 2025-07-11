{ config, pkgs, ... }:

{
  programs.yazi = {
    enable = true; 
    enableBashIntegration = true;
    enableZshIntegration = true;

    keymap = {
      manager.prepend_keymap = [
        { on = [ "F" ]; run = "plugin smart-filter"; desc = "Smart filter"; }
        { on = [ "!" ]; run = "shell $SHELL --block"; desc = "Open shell here"; }
        { on = [ "f" "g" ]; run = "plugin fg --args rg"; desc = "Search file by content (rg)"; }
        { on = [ "f" "a" ]; run = "plugin fg --args rga"; desc = "Search file by content (rga)"; }
      ];
    };

    settings = {
      general = {
        show_hidden = true;
      };
      manager = {
        layout = [ 1 4 3 ];
        sort_by = "natural";
        sort_sensitive = true;
        sort_reverse = false;
        sort_dir_first = true;
        linemode = "none";
        show_hidden = true;
        show_symlink = true;
      };
      preview = {
        wrap = "yes";
      };
    };

    theme = { }; 

    plugins = { 
      rich-preview = pkgs.yaziPlugins.rich-preview; 
      glow = pkgs.yaziPlugins.glow; 
      smart-filter = pkgs.yaziPlugins.smart-filter; 
    };
  };

  # Добавляем fg plugin через home.file
  home.file.".config/yazi/plugins/fg.yazi/main.lua".source = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/lpnh/fr.yazi/refs/heads/main/main.lua";
    sha256 = "0cwjzw3mpgk93qik8irlvsssnxc167zmcd1k2zb5qpkdfbjwmz3v";
  };
} 