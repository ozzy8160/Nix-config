{ ... }:
  {
  #drive mounts
  fileSystems."/mnt/vault3" = {
    device = "/dev/disk/by-uuid/dc7a1bed-2d94-47af-8b92-7b3d184025e1";
    fsType = "btrfs";
    options = [ "subvolid=257" "compress=zstd:5" "noatime" ];
  };
  
  fileSystems."/mnt/backup_vault" = {
    device = "/dev/disk/by-uuid/75524f49-56e1-44b9-85ac-d9adec0d0d9e";
    fsType = "btrfs";
    options = [ "subvolid=256" "compress=zstd:15" "noatime" ];
  };
  
  fileSystems."/mnt/backup_vault2" = {
    device = "/dev/disk/by-uuid/b4349dd9-a12c-487a-9f61-bf35fee23655";
    fsType = "btrfs";
    options = [ "subvolid=5" "compress=zstd:15" "noatime" ];
  };
}
