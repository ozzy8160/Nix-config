{ config, pkgs, inputs, ... }:
  let
    nvimConfigTarget = "${config.ussers.users.$USER.home}/.config/nvim-config";
    nvimConfigSource = inputs.nvim-config;
  in
{
 
  system.activationScripts.linkNvimConfig = lib.mkForce {
    deps = [ "users" ];
    text = ''
      echo "checking for nvim config..."
      if [ -d "/home/"$USER"/.config/nvim-config" ]; then
        echo "Unlinking nvim-config" && unlink "/home/"$USER"/.config/nvim-config"
      else
        echo "Updating Neovim config symlink from ${nvimConfigSource} to ${nvimConfigTarget}" && ln -sf "${nvimConfigSource}" "${nvimConfigTarget}"
      '';
  };
  #set env variables 
  environment.sessionVariables = {
    XDG_CONFIG_HOME = "${config.users.users.$USER.home}/.config";
    NVIM_APPNAME = "nvim-config";
  };
}
