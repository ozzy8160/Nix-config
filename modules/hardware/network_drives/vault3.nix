{...}:
{
  fileSystems."/mnt/vault3" = {
    device = "ryan@192.168.1.114:/mnt/vault3";
    fsType = "fuse.sshfs";
    options = [
      "nodev"
      "noatime"
      "allow_other"
      "_netdev"
      "x-systemd.automount"
      "nofail"
      # Essential: Ensure the root user can read this file
      "IdentityFile=/home/ryan/.ssh/id_ed25519"
      # Optional but recommended for stable mounts
      "reconnect"
      "ServerAliveInterval=15"
      "idmap=user"
    ];
  };
  # Ensure the fuse module and sshfs are available
  boot.supportedFilesystems = [ "fuse.sshfs" ];
}
