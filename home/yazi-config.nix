{ config, pkgs, ... }:

{
  programs.yazi = {
    enable = true;

    keymap = {
      manager.keymap = [
        { on = [ "F" ]; run = "plugin smart-filter"; desc = "Smart filter"; }
        { on = [ "!" ]; run = "shell \"$SHELL\" --block"; desc = "Open shell here"; }
        { on = [ "f" "g" ]; run = "plugin fg"; desc = "find file by content (fuzzy match)"; }
        { on = [ "f" "a" ]; run = "plugin fg --args='rga'"; desc = "find file by content (ripgrep-all)"; }
        { on = [ "g" "s" ]; run = "cd /mnt/samba"; desc = "Go to the network drive"; }
        { on = [ "g" "w" ]; run = "cd /mnt/windisk/Documents and Settings/claim"; desc = "Go to the Windows profile"; }
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
  };

} 