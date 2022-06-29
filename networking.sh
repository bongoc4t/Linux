#-NETWORKING COMMANDS-#
#ip addr del just removes the one IP address from the interface, i.e. tells the system to not communicate using that address. 
#You could still have another address in use on the interface, either an IPv4 or an IPv6 one (or multiple). As far as the physical 
#Ethernet link is concerned, thats no difference whatsoever, it only affects the network layer.

#ip link set <iface> down on the other hand would shut down the whole interface on the physical layer, which would usually make it 
#appear to the connected device as if the cable was unplugged. You could still have the IP address configured, and the system could 
#still use it to communicate internally, or accept packets addressed to that IP address coming from other interfaces. 
#(Unless you have settings to stop that.)

#DIRECTORIES
/etc/hosts #location of the local DNS file
/etc/nsswitch.conf #here you can change the order of the DNS (check first host file then Nameservers)

/etc/sysconfig/network-scripts #is the location where all config files are located
ifconfig #this command is use to initialize an interface, assign IP Address to interface and enable or disable interface on demand. 
iwconfig #same that ifconfig but with wireless
ip addr #The ip command allows Linux users to quickly leverage the IP utility for manipulating the routing, devices, policy routing, and tunnels.
nslookup #obtain domain name or IP address mapping by querying the Domain Name System
         #"name server lookup", finds information about a named domain. We can also perform the above operation in reverse by providing the IP address rather than the domain name.
         #-type=ns/a/aaaa/mx/cname
wget #tool that allow to downloading contents from web servers.
dig #for query the DNS for network tshooting
    dig NS WEBSITE +short > to check nameservers
    dig WEBSITE +trace > to see the delegation path
    dig SOA WEBSITE @NAMESERVER > Look if a zone exists on a particular NS
    dig WEBSITE @X.X.X.X > Check what a particular resolver has in its cache.
    dig MX WEBSITE +short > to check the mail servers accepting emails
    dig -x X.X.X.X > to perform a reverse DNS check
    dig WEBSITE +nssearch > to check if your DNS zone is sync over all auth NS.
    dig +dnssec WEBSITE @NAMESERVER > to check RRSIG
    dig DNSKEY WEBSITE @NAMESERVER > to check ZSK key
    dig +short SOA WEBSITE @NAMESERVER > to check the zone

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

#- NETWORK NAMESPACES WITH BRCTL (LINUX BRIDGE)-#
# add the namespaces. you find to entries in the directory /var/run/netns/
ip netns add ns1
ip netns add ns2
# create the switch
BRIDGE=br-test
brctl addbr $BRIDGE
brctl stp   $BRIDGE off
ip link set dev $BRIDGE up
#
#### PORT 1
# create a port pair
ip link add tap1 type veth peer name br-tap1
# attach one side to linuxbridge
brctl addif br-test br-tap1 
# attach the other side to namespace
ip link set tap1 netns ns1
# set the ports to up
ip netns exec ns1 ip link set dev tap1 up
ip link set dev br-tap1 up
#
#### PORT 2
# create a port pair
ip link add tap2 type veth peer name br-tap2
# attach one side to linuxbridge
brctl addif br-test br-tap2
# attach the other side to namespace
ip link set tap2 netns ns2
# set the ports to up
ip netns exec ns2 ip link set dev tap2 up
ip link set dev br-tap2 up

#- NETWORK NAMESPACES WITH OPEN VSWITCH-#
# add the namespaces. you find to entries in the directory /var/run/netns/
ip netns add ns1-red
ip netns add ns2-green
# create the switch
ovs-vsctl add-br OVS1
# check namespaces
ip netns
# launch commands in the dhcp-r namespace
ip netns exec dhcp-r bash
#
#### PORT 1
# create a port pair
ip link add eth0-r type veth peer name veth-r
# attach one side to ovs
ovs-vsctl add-port OVS1 veth0-r 
# attach the other side to namespace
ip link set eth0-r netns ns1-red
# set the ports to up
ip netns exec ns1-red ip link set dev eth0-r up
ip netns exec ns1-red ip link set dev lo up
ip link set dev veth-r up
# assign an IP address to ns1-red interface
ip netns exec ns1-red ip address add 10.0.0.1/24 dev eth0-r

#- CREATE DNS SERVER AND CLIENT -#
# delete old ip addresses from ns to prepare the DHCP clients
ip netns exec ns1-red ip address del 10.0.0.1/24 dev eth0-r
# create a ns for DHCP service
ip netns add dhcp-r
# create a new port for the DHCP connection
ovs-vsctl add-port OVS1 tap-r
# makes port internal
ovs-vsctl set interface tap-r type=internal
# set a vlan 100 to the ns1-red interface and to the dhcp-r interface
ovs-vsctl set port tap1 tag=100
ovs-vsctl set port eth0-r tag=100
# set the port tap-r to DHCP ns
ip link set tap-r netns dhcp-r
# set the LO interface up
ip netns exec dhcp-r ip link set dev lo up
# set the link tap-r up
ip netns exec dhcp-r ip link set dev tap-r up
# set IP address to DHCP link
ip netns exec dhcp-r ip address add 10.50.50.2/24 dev tap-r
# set up the DHCP service with the IP ranges
ip netns exec dhcp-r dnsmasq --interface=tap-r --dhcp-range=10.50.50.10,10.50.50.100,255.255.255.0
# now set up the ns1-red port as DHCP client
ip netns exec ns1-red dhclient eth0-r

#-- OPEN VSWITH CHEAT SHEET--#
ovs-vsctl : Used for configuring the ovs-vswitchd configuration database (known as ovs-db)
ovs-ofctl : A command line tool for monitoring and administering OpenFlow switches
ovs-dpctl : Used to administer Open vSwitch datapaths
ovs−appctl : Used for querying and controlling Open vSwitch daemons

# INSTALL OPEN VSWITCH
sudo apt install openvswitch-switch

# START OVS DAEMON
sudo ovs-vswitchd

# Prints the current version of openvswitch. 
ovs-vsctl –V 

# Prints a brief overview of the switch database configuration.
ovs-vsctl show 

# Prints a list of configured bridges 
ovs-vsctl list-br 

# Prints a list of ports on a specific bridge. 
ovs-vsctl list-ports <bridge>

# Prints a list of interfaces.
ovs-vsctl list interface

# Creates a bridge in the switch database.
ovs-vsctl add-br <bridge>

# Binds an interface (physical or virtual) to a bridge. 
ovs-vsctl add-port <bridge> <interface> 

# Converts port to an access port on specified VLAN (by default all OVS ports are VLAN trunks). 
ovs-vsctl add-port <bridge> <interface> tag=<VLAN number> 

# Used to create patch ports to connect two or more bridges together.
ovs-vsctl set interface <interface> type=patch options:peer=<interface>
