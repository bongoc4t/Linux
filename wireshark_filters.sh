#- DNS WIRESHARK
#Secondary servers should request all records (type 252) when they are first set up.
#After that, the primary should send a Notify (op code 4) after any changes.Then the secondaries send an incremental records (type 251) request to get the new records.
dns.qry.type in {251 252} or dns.flags.opcode eq 4

#DNS errors filter
dns.flags.rcode != 0 #Number of Unsuccessful queries
dns.flags.rcode == 0 #Number of Successful queries


#https://www.iana.org/assignments/dns-parameters/dns-parameters.xml#dns-parameters-6
dns.resp.type == X 
    251 = IXFR
    S52 = AXFR
    6 = SOA
    5 = CNAME

