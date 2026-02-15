{ ... }:
  {
    environment.pathsToLink = [ "/share/bash-completion" ];
    programs = {
      command-not-found.enable = false;
      nix-index.enable = true;
      bash = {
        completion.enable = true;
        shellAliases = {
          zl = '';
            if [ -n "1" ]; then
              z "$@" && ll
            else
              z ~ && ll
            fi
          '';
          mkdirg = ''
            mkdir -p "$1"
            cd "$1"
          '';
          cd = ''
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
          sn = "kitty +kitten ssh ryan@192.168.1.114";
          revault = "sshfs -o allow_other,default_permissions ryan@192.168.1.114:/mnt/vault3 /mnt/vault3";
        };
      };
    };
}
