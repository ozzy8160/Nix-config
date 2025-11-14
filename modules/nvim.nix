{ config, pkgs, inputs, lib, ... }:
  let
    nvimConfigTarget = "${config.users.users."$USER".home}/.config/nvim-config";
    nvimConfigSource = inputs.nvim-config;
    HOME = "${config.users.users.ryan.home}";
  in
{
  system.activationScripts.linkNvimConfig = lib.mkForce {
    deps = [ "users" ];
    text = ''
      echo "Checking for existing nvim-config..."
      if [ -d "${HOME}"/.config/nvim-config ]; then
        echo "Unlinking existing nvim-config"
        unlink  "${HOME}"/.config/nvim-config
        echo "Updating Neovim config symlink from ${nvimConfigSource} to ${nvimConfigTarget}"
        ln -sf "${nvimConfigSource}" "${nvimConfigTarget}"
      else
        echo "creating Neovim config symlink from ${nvimConfigSource} to ${nvimConfigTarget}"
        ln -sf "${nvimConfigSource}" "${nvimConfigTarget}"
      fi
      '';
  };
  #set env variables 
  environment.sessionVariables = {
    XDG_CONFIG_HOME = "${config.users.users."$USER".home}/.config";
    NVIM_APPNAME = "nvim-config";
  };
}
