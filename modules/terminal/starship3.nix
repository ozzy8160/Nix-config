{ pkgs, ... }:

{
  # 1. Enable the starship binary and shell integration
  programs.starship.enable = true;

  # 2. Write the config to the standard XDG location
  environment.etc."xdg/starship.toml".text = ''
    add_newline = false
    format = """
    [╭─](white)$character$hostname$username$git_branch$git_status$directory$package$python$battery$memory_usage$cmd_duration
    [╰────⎯](white) """

    scan_timeout = 20

    [username]
    show_always = true
    style_root = "bold red"
    style_user = "bold yellow"
    format = "[$user]($style) "
    disabled = false

    [hostname]
    ssh_only = false
    format =  "[$hostname](bold red)"
    trim_at = ".companyname.com"
    disabled = false

    [directory]
    read_only = "🔒"
    style = "bold cyan"
    read_only_style = "red"
    truncation_length = 0
    truncation_symbol = "../"
    format = "[$read_only]($read_only_style)[$path]($style) "
    disabled = false

    [package]
    format = "via [🎁 $version](208 bold) "

    [java]
    symbol = "☕ "
    style = "red dimmed"
    format = "via [\${symbol}\${version}]($style) "

    [python]
    symbol = '   '
    python_binary = ['./venv/bin/python', 'python', 'python3', 'python2']
    format = '[//](black bold) [\${symbol} \${pyenv_prefix}(\${version} )(\(\$virtualenv\) )]($style) '

    [memory_usage]
    disabled = false
    threshold = 70
    symbol = "🧠 "
    style = "bold blue"
    format = "$symbol[$ram_pct]($style) "

    [git_branch]
    symbol = " "
    truncation_length = 4
    truncation_symbol = ""

    [git_status]
    format = '[$all_status$ahead_behind]($style)'
    style = 'bold green'
    conflicted = '🏳'
    up_to_date = ''
    untracked = ' ''${count} '
    ahead = '⇡''${count} '
    diverged = '⇕⇡''${ahead_count}⇣''${behind_count} '
    behind = '⇣''${count} '
    stashed = '''${count} '
    modified = ' ''${count} '
    staged = '[++\(''${count}\)](green)'
    renamed = '襁 '
    deleted = ' '

    [battery]
    disabled = false
    full_symbol = "🔋"
    charging_symbol = "⚡"
    discharging_symbol = "🔌"
    unknown_symbol = "❓"
    empty_symbol = "🪫"
    format = "$symbol$percentage"

    [[battery.display]]
    threshold = 50
    style = "bold red"

    [cmd_duration]
    show_milliseconds = true
    style = "bold yellow"
    format = "took [$duration]($style)"

    [character]
    format = "$symbol"
    success_symbol = "[ ](bold green)"
    error_symbol = "[ ](bold red) "
    vicmd_symbol = "[❮](bold green)"
    disabled = false
  '';
}
