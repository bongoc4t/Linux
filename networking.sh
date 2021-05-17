#-NETWORKING COMMANDS-#
/etc/sysconfig/network-scripts #is the location where all config files are located
ifconfig #this command is use to initialize an interface, assign IP Address to interface and enable or disable interface on demand. 
iwconfig #same that ifconfig but with wireless
ip addr #The ip command allows Linux users to quickly leverage the IP utility for manipulating the routing, devices, policy routing, and tunnels.
nslookup #obtain domain name or IP address mapping by querying the Domain Name System
         #"name server lookup", finds information about a named domain. We can also perform the above operation in reverse by providing the IP address rather than the domain name.
         #-type=ns/a/aaaa/mx/cname
wget #tool that allow to downloading contents from web servers.
dig #for query the DNS for network tshooting
whois #tool for obtaining both domain and IP related information about a network.
ping
traceroute
netstat
    -a #list all ports
    -at #list all TCP ports
    -au #list all UDP ports
    -l #list only listening ports
    -lt #list only TCP listening ports
    -lu #list only UDP listening ports
    -s #show statistics for all ports

#---> NETWORK MANAGER
nmcli con show #display lisy of connections
    --active #display only active connections
nmcli dev status #display the device status
nmcli con add con-name “nameofthecon” type Ethernet ifname eth0 #add a connection
    -- ifname is the name of the Ethernet device; can find them by doing ls /sys/class/net
nmcli con reload #after modifying a network connection you should reload the config.
nmcli dev disconnect "device" #turn off the network device
nmcli dev connect "device" #turn on the network device
systemctl start NetworkManager
systemctl enable NetworkManager
systemctl restart network