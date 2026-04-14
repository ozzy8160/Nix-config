{
  disko.devices = {
    disk.main = {
      device = "/dev/vda";
      type = "disk";
      imageSize = "24G";
      content = {
        type = "gpt";
        partitions = {
          boot = {
              size = "1M";
              type = "EF02"; # BIOS boot partition for GPT+BIOS
            };
          # Root Partition (e.g., 4GB)
          root = {
            size = "16G";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          };
          # Home Partition (e.g., 6GB)
          home = {
            size = "4G";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/home";
            };
          };
        };
      };
    };
  };
}
