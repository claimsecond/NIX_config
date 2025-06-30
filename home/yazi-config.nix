{ config, pkgs, ... }:

{
  programs.yazi.enable = true;

  home.file.".config/yazi/yazi.toml".text = ''
    $schema = "https://yazi-rs.github.io/schemas/yazi.json"

    [general]
    show_hidden = true # Show hidden files by default 

    [manager]
    layout         = [1, 4, 3]
    sort_by        = "natural"
    sort_sensitive = true
    sort_reverse   = false
    sort_dir_first = true
    linemode       = "none"
    show_hidden    = true
    show_symlink   = true

    [preview]
    wrap = "yes"

    [opener]
    folder = [
    { run = 'hyprctl dispatch exec "[float; size 60% 60%; center 1] nautilus" "$@"', orphan = true, desc = "nautilus", for = "linux" },
    { run = 'kitty --detach nvim "$@"', orphan = true, desc = "neovim (detached)", for = "linux" },
    { run = 'cursor  "$@"', orphan = true, desc = "Cursor", for = "linux" },
    { run = 'kitty "$@"', orphan = true, desc = "kitty", for = "linux" },
    { run = 'nsxiv "$@"', orphan = true, desc = "nsxiv", for = "linux" },
    { run = 'xdg-open "$@"', orphan = true, desc = "xdg-open", for = "linux" },
    ]

    text = [
    { run = '$EDITOR "$@"', block = true, desc = "$EDITOR", for = "linux" },
    { run = 'nvim "$@"', block = true, desc = "neovim", for = "linux" },
    { run = 'kitty --detach nvim "$@"', block = true, desc = "neovim (detached)", for = "linux" },
    { run = 'cursor  "$@"', orphan = true, desc = "Cursor", for = "linux" },
    { run = 'xdg-open "$@"', orphan = true, desc = "xdg-open", for = "linux" },
    ]

    document = [
    { run = 'zathura "$@"', orphan = true, desc = "zathura", for = "linux" }, 
    { run = 'okular "$@"', orphan = true, desc = "okular", for = "linux" },
    { run = 'koodo-reader "$@"', orphan = true, desc = "koodo-reader", for = "linux" },
    { run = 'libreoffice "$@"', orphan = true, desc = "libreoffice", for = "linux" }, 
    { run = 'xdg-open "$@"', orphan = true, desc = "xdg-open", for = "linux" },
    ]

    image = [
    { run = 'xdg-open "$@"', orphan = true, desc = "xdg-open", for = "linux" }, 
    { run = 'nsxiv "$@"', orphan = true, desc = "nsxiv", for = "linux" },
    { run = 'krita "$@"', orphan = true, desc = "krita", for = "linux" },
    ]

    video = [
    { run = 'xdg-open "$@"', orphan = true, desc = "xdg-open", for = "linux" },
    { run = 'mpv --force-window "$@"', orphan = true, desc = "mpv", for = "linux" },
    { run = 'vlc "$@"', orphan = true, desc = "vlc", for = "linux" },
    ]

    audio = [
    { run = 'mpv --force-window "$@"', orphan = true, desc = "mpv", for = "linux" },
    { run = 'xdg-open "$@"', orphan = true, desc = "xdg-open", for = "linux" },
    { run = 'vlc "$@"', orphan = true, desc = "vlc", for = "linux" },
    ]

    html = [
    { run = 'google-chrome-stable "$@"', orphan = true, desc = "chrome", for = "linux" },
    ]

    edit = [
        { run = '${EDITOR:-vi} "$@"', desc = "$EDITOR", block = true, for = "unix" }, 
        { run = 'cursor "$@"', desc = "Cursor", orphan = true, for = "unix" }
    ] 

    fallback = [
    { run = 'xdg-open "$@"', orphan = true, desc = "xdg-open", for = "linux" },
    ]

    [open]
    rules = [
    { name = "*/", use = "folder" }, 

    { mime = "text/html", use = "html" },
    { mime = "text/*", use = "text" },
    { mime = "image/*", use = "image" },
    { mime = "video/*", use = "video" },
    { mime = "application/octet-stream", use = "video" },
    { mime = "audio/*", use = "audio" },
    { mime = "inode/x-empty", use = "text" },
    { mime = "application/json", use = "text" },

    { mime = "application/zip", use = "archive" },
    { mime = "application/gzip", use = "archive" },
    { mime = "application/x-bzip", use = "archive" },
    { mime = "application/x-bzip2", use = "archive" },
    { mime = "application/x-tar", use = "archive" },
    { mime = "application/x-7z-compressed", use = "archive" },
    { mime = "application/x-rar", use = "archive" },

    { mime = "application/pdf", use = "document" },
    { mime = "application/epub+zip", use = "document" },
    { mime = "application/x-mobipocket-ebook", use = "document" },

    { name = "*.lua", use = "edit" },

    { mime = "*", use = "fallback" },
    ]
    '';

  home.file.".config/yazi/package.toml".text = ''
    [plugin]
    deps = [{ use = "yazi-rs/plugins:smart-filter", rev = "e4aaf43" }, { use = "lpnh/fg", rev = "9bba743" }]

    [flavor]
    deps = []
    '';

  home.file.".config/yazi/keymap.toml".text = ''
    [[manager.prepend_keymap]]
    on   = "F"
    run  = "plugin smart-filter"
    desc = "Smart filter"

    [[manager.prepend_keymap]]
    on   = "!"
    run  = 'shell "$SHELL" --block'
    desc = "Open shell here"

    [[manager.prepend_keymap]]
    on   = [ "f","g" ]
    run  = "plugin fg"
    desc = "find file by content (fuzzy match)"

    [[manager.prepend_keymap]]
    on   = [ "f","a" ]
    run  = "plugin fg --args='rga'"
    desc = "find file by content (ripgrep-all)"

    [[manager.prepend_keymap]]
    on   = [ "g", "s" ]
    run  = "cd /mnt/samba"
    desc = "Go to the network drive"

    [[manager.prepend_keymap]] 
    on = [ "g", "w" ] 
    run = "cd /mnt/windisk/Documents and Settings/claim" 
    desc = "Go to the Windows profile"
    '';

  home.file.".config/yazi/theme.toml".text = "";
  home.file.".config/yazi/plugins".source = ./yazi/plugins;

  home.file.".config/yazi/plugins/fg.yazi/init.lua".text = ''
    local shell = os.getenv("SHELL"):match(".*/(.*)")

    local preview_opts = {
        default = [===[line={2} && begin=$( if [[ $line -lt 7 ]]; then echo $((line-1)); else echo 6; fi ) && bat --highlight-line={2} --color=always --line-range $((line-begin)):$((line+10)) {1}]===],
        fish = [[set line {2} && set begin ( test $line -lt 7  &&  echo (math "$line-1") || echo  6 ) && bat --highlight-line={2} --color=always --line-range (math "$line-$begin"):(math "$line+10") {1}]],

        nu = [[let line = ({2} | into int); let begin = if $line < 7 { $line - 1 } else { 6 }; bat --highlight-line={2} --color=always --line-range $'($line - $begin):($line + 10)' {1}]],
    }
    local preview_cmd = preview_opts[shell] or preview_opts.default

    local rg_prefix = "rg --column --line-number --no-heading --color=always --smart-case "
    local rga_prefix =
        "rga --files-with-matches --color ansi --smart-case --max-count=1 --no-messages --hidden --follow --no-ignore --glob '!.git' --glob !'.venv' --glob '!node_modules' --glob '!.history' --glob '!.Rproj.user' --glob '!.ipynb_checkpoints' "

    local fzf_args = [[fzf --preview='bat --color=always {1}']]
    local rg_args = {
        default = [[fzf --ansi --disabled --bind "start:reload:]]
            .. rg_prefix
            .. [[{q}" --bind "change:reload:sleep 0.1; ]]
            .. rg_prefix
            .. [[{q} || true" --delimiter : --preview ']]
            .. preview_cmd
            .. [[' --preview-window 'up,60%' --nth '3..']],

        nu = [[fzf --ansi --disabled --bind "start:reload:]]
            .. rg_prefix
            .. [[{q}" --bind "change:reload:sleep 100ms; try { ]]
            .. rg_prefix
            .. [[{q} }" --delimiter : --preview ']]
            .. preview_cmd
            .. [[' --preview-window 'up,60%' --nth '3..']],
    }
    local rga_args = {
        default = [[fzf --ansi --disabled --layout=reverse --sort --header-first --header '---- Search inside files ----' --bind "start:reload:]]
            .. rga_prefix
            .. [[{q}" --bind "change:reload:sleep 0.1; ]]
            .. rga_prefix
            .. [[{q} || true" --delimiter : --preview 'rga --smart-case --pretty --context 5 {q} {}' --preview-window 'up,60%' --nth '3..']],

        nu = [[fzf --ansi --disabled --layout=reverse --sort --header-first --header '---- Search inside files ----' --bind "start:reload:]]
            .. rga_prefix
            .. [[{q}" --bind "change:reload:sleep 100ms; try { ]]
            .. rga_prefix
            .. [[{q} }" --delimiter : --preview 'rga --smart-case --pretty --context 5 {q} {}' --preview-window 'up,60%' --nth '3..']],
    }
    local fg_args = 'rg --color=always --line-number --no-heading --smart-case \'\' | fzf --ansi --preview="' .. preview_cmd .. '" --delimiter=\':\' --preview-window=\'up:60%\' --nth=\'3..\''

    local function split_and_get_first(input, sep)
        if sep == nil then
            sep = "%s"
        end
        local start, _ = string.find(input, sep)
        if start then
            return string.sub(input, 1, start - 1)
        end
        return input
    end

    local state = ya.sync(function() return cx.active.current.cwd end)

    local function fail(s, ...) ya.notify { title = "fg", content = string.format(s, ...), timeout = 5, level = "error" } end

    local function entry(_, job)
        local _permit = ya.hide()
        local cwd = tostring(state())
        local cmd_args = ""

        if job.args[1] == "fzf" then
            cmd_args = fzf_args
        elseif job.args[1] == "rg" then
            cmd_args = rg_args[shell] or rg_args.default
        elseif job.args[1] == "rga" then
            cmd_args = rga_args[shell] or rga_args.default
        else
            cmd_args = fg_args
        end

        local child, err = Command(shell)
            :args({ "-c", cmd_args })
            :cwd(cwd)
            :stdin(Command.INHERIT)
            :stdout(Command.PIPED)
            :stderr(Command.INHERIT)
            :spawn()

        if not child then
            return fail("Spawn command failed with error code %s.", err)
        end

        local output, err = child:wait_with_output()
        if not output then
            return fail("Cannot read `fzf` output, error code %s", err)
        elseif not output.status.success and output.status.code ~= 130 then
            return fail("`fzf` exited with error code %s", output.status.code)
        end

        local target = output.stdout:gsub("\n$", "")

        local file_url = split_and_get_first(target, ":")

        if file_url ~= "" then
            ya.manager_emit(file_url:match("[/\\]$") and "cd" or "reveal", { file_url })
        end
    end

    return { entry = entry }
    '';

  home.file.".config/yazi/plugins/smart-filter.yazi/init.lua".text = ''
    local hovered = ya.sync(function()
        local h = cx.active.current.hovered
        if not h then
            return {}
        end

        return {
            url = h.url,
            is_dir = h.cha.is_dir,
            unique = #cx.active.current.files == 1,
        }
    end)

    local function prompt()
        return ya.input {
            title = "Smart filter:",
            position = { "center", w = 50 },
            realtime = true,
            debounce = 0.1,
        }
    end

    local function entry()
        local input = prompt()

        while true do
            local value, event = input:recv()
            if event ~= 1 and event ~= 3 then
                ya.manager_emit("escape", { filter = true })
                break
            end

            ya.manager_emit("filter_do", { value, smart = true })

            local h = hovered()
            if h.unique and h.is_dir then
                ya.manager_emit("escape", { filter = true })
                ya.manager_emit("enter", {})
                input = prompt()
            elseif event == 1 then
                ya.manager_emit("escape", { filter = true })
                ya.manager_emit(h.is_dir and "enter" or "open", { h.url })
            end
        end
    end

    return { entry = entry }
    '';
} 