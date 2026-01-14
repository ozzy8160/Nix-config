{ ... }:
  {
  fileSystems."/mnt/vault3" = {
    device = "/dev/disk/by-uuid/dc7a1bed-2d94-47af-8b92-7b3d184025e1";
    fsType = "btrfs";
    options = [ "subvolid=257" "compress=zstd:5" "noatime" ];
  };
}
