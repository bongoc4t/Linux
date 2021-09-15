#- DNS WIRESHARK
#Secondary servers should request all records (type 252) when they are first set up.
#After that, the primary should send a Notify (op code 4) after any changes.Then the secondaries send an incremental records (type 251) request to get the new records.
dns.qry.type in {251 252} or dns.flags.opcode eq 4

#DNS errors filter
dns.flags.rcode != 0 #Number of Unsuccessful queries
dns.flags.rcode == 0 #Number of Successful queries


#https://www.iana.org/assignments/dns-parameters/dns-parameters.xml#dns-parameters-6
dns.qry.type == X 
    251 = IXFR
    252 = AXFR
    6 = SOA
    5 = CNAME

# DNS OpCodes
dns.flags.opcode == X
    4 = Notify
    5 = update

# Sets a filter for any packet with 10.0.0.1, as either the source or dest
ip.addr == 18.209.182.68

# sets a conversation filter between the two defined IP addresses
ip.addr==10.0.0.1  && ip.addr==10.0.0.2 

# sets a filter for any TCP packet with 4000 as a source or dest port  
tcp.port==4000 

ip.addr == 18.209.182.68 && tcp.port==53
ip.addr == 3.93.134.165 && tcp.port==53
ip.addr == 	3.94.223.31 && tcp.port==53