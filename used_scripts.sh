for i in `cat FILE.txt`; do echo $i; dig @NAMESERVER ns $i |grep status; echo ""; done # To check if there is any error from the NS side
