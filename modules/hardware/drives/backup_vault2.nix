{ ... }:
  {
  fileSystems."/mnt/backup_vault2" = {
    device = "/dev/disk/by-uuid/b4349dd9-a12c-487a-9f61-bf35fee23655";
    fsType = "btrfs";
    options = [ "subvolid=5" "compress=zstd:15" "noatime" ];
  };
}
