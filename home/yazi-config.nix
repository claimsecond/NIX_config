{ config, pkgs, ... }:
let
  fg = pkgs.fetchFromGitHub {
    owner = "lpnh";
    repo = "fg.yazi";
    rev = "9bba7430dbcd30995deea600499b069fe6067a3e";
    hash = "sha256-3VjTL/q4gSDIHyPXwUIQA/26bbhWya+01EZbxSKzzQo=";
  };
in
{
  programs.yazi = {
    enable = true; 
    enableBashIntegration = true;
    enableZshIntegration = true;

    keymap = {
      manager.prepend_keymap = [
        { on = [ "F" ]; run = "plugin smart-filter"; desc = "Smart filter"; }
        { on = [ "!" ]; run = "shell $SHELL --block"; desc = "Open shell here"; }
        { on = [ "f" "g" ]; run = "plugin fg"; desc = "find file by content (fuzzy match)"; }
        { on = [ "f" "a" ]; run = "plugin fg --args='rga'"; desc = "find file by content (ripgrep-all)"; }
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
      fg = fg;
    };
  };

} 