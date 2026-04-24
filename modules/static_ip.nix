  {
    networking = {
      # Disable DHCP for all interfaces or specifically (highly recommended)
      useDHCP = false;
      interfaces.wlo1.useDHCP = false; # Replace 'enp2s1'

      # Configure static IP
      interfaces.enp2s1.ipv4.addresses = [{
        address = "192.168.1.114";
        prefixLength = 24; # Subnet mask (24 = 255.255.255.0)
      }];

      # Configure gateway
      defaultGateway = "192.168.1.1";

      # Configure DNS servers
      nameservers = [ "192.168.1.1" "1.1.1.1" "8.8.8.8" ];
    };
  }
