{ pkgs, ... }:
  {
    security.wrappers.btop = {
      owner = "root";
      group = "root";
      capabilities = "cap_perfmon=ep";
      source = "${pkgs.btop}/bin/btop";
    };
    environment.pathsToLink = [ "/share/bash-completion" ];
    #so zoxide will shutup 
    environment.variables._ZO_DOCTOR = "0";

    environment.variables = {
      HISTSIZE = "999999";
      HISTFILESIZE = "999999";
      # Optional: Don't store duplicate lines or lines starting with a space
      HISTCONTROL = "ignoreboth";
      HISTTIMEFORMAT="%F %T";
    };
    programs = {
      command-not-found.enable = false;
      nix-index.enable = true;
    #nix-index-database.comma.enable = true; # Adds 'comma' to run programs without installing
      bash = {
        completion.enable = true;
        loginShellInit = ''
          if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
            start-hyprland
          fi
        '';
        interactiveShellInit = ''
          if [ -f ~/.cache/wal/sequences ]; then
            (cat ~/.cache/wal/sequences &)
          fi
          eval "$(pay-respects bash --alias)"
          eval "$(zoxide init bash)"
          eval "$(fzf --bash)"
          fastfetch
          #check if shell is interactive
          if [[ $- == *i* ]]; then
            #bind CTRL+f to insert 'zi' followed by a newline
            bind '"\C-f":"zi\n"'
          fi      
        '';
        shellAliases = {
          zl = ''
            if [ -n "1" ]; then
              zoxide "$@" && ll
            else
              zoxide ~ && ll
            fi
          '';
          mkdirg = ''
            mkdir -p "$1"
            cd "$1"
          '';
          cdls = ''
            if [ -n "1" ]; then
              builtin cd "$@" && ll
            else
             builtin cd ~ && ll
            fi
          '';
          grep = "rg";
          b = "cd ..";
        #	ls = "lsd";
          # Search command line history
          h = "history | rp ";
          v = "nvim";
          sv = "sudo nvim";
        #	rebuild = "sudo nixos-rebuild switch --flake $(readlink -f /home/ryan/.dotfiles/flakes)";
          updt = "sudo nix flake update && sudo nixos-rebuild switch --flake .#{$HOSTNAME}";
          ebrc = "v ~/.bashrc";
          cp = "cp -i";
          mv = "mv -i";
          tree = "tree -s -h --du";
          dh = "df -h";
          ll = "lsd -alh";
          rm = "rm -rfv";
          rebootsafe = "sudo shutdown -r now";
          rebootforce = "sudo shutdown -r -n now";
          sj = "ssh ryan@192.168.1.58";
          sg = "ssh ryan@192.168.1.39";
          sn = "kitty +kitten ssh ryan@192.168.1.113";
          revault = "sshfs -o allow_other,default_permissions ryan@192.168.1.114:/mnt/vault3 /mnt/vault3";
        };
      };
    };
}
