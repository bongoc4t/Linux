#generate keys
openssl genrsa -out ca.key 2048

#certificate signing request
openssl req -new -key ca.key -subj "/CN=KUBERNETES-CA" -out ca.csr

#sign certificates
openssl x509 -req -in ca.csr -signkey ca.key -out ca.crt

#Check an SSL connection. All the certificates (including Intermediates) should be displayed
openssl s_client -connect WEBSITE:443

#Check a Certificate Signing Request (CSR)
openssl req -text -noout -verify -in CSR.csr

#Check a private key
openssl rsa -in privateKey.key -check

#Check a certificate
openssl x509 -in certificate.crt -text -noout

#Check the Certificate Signer Auth
openssl x509 -in certfile.pem -noout -issuer -issuer_hash

#Check a PKCS#12 file (.pfx or .p12)
openssl pkcs12 -info -in keyStore.p12

#Check Certificate Expiration Date of SSL URL
openssl s_client -connect secureurl.com:443 2>/dev/null | openssl x509 -noout –enddate

#Check PEM File Certificate Expiration Date
openssl x509 -noout -in certificate.pem -dates

#Check SSL version is accepted on URL
openssl s_client -connect secureurl.com:443 -ssl2 #--> version can be 2 or 3
openssl s_client -connect secureurl.com:443 -tls1 #---> tls can be 1_1, 1_2...

#Convert PEM to DER
openssl x509 -outform der -in certificate.pem -out certificate.der

#Convert PEM to DER format
openssl x509 –outform der –in sslcert.pem –out sslcert.der

#Convert Certificate and Private Key to PKCS#12 format
openssl pkcs12 -export -out certificate.pfx -inkey privateKey.key -in certificate.crt -certfile CACert.crt

#Generate a new private key and Certificate Signing Request
openssl req -out CSR.csr -new -newkey rsa:2048 -nodes -keyout privateKey.key

#Generate a self-signed certificate
openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -keyout privateKey.key -out certificate.crt

#Get SSL server certificate from Remote Server
#We can get an interactive SSL connection to our server, using the openssl s_client command:
#This keeps the interactive session open until we type Q (quit) and press , or until EOF is encountered.
#We can use the -showcerts option to get the complete certificate chain:
openssl s_client -showcerts -connect URL:443

#That command connects to the desired website and pipes the certificate in PEM format on to another openssl command that reads and parses the details.
#(Note that "redundant" -servername parameter is necessary to make openssl do a request with SNI support.)
#This is a continuation of the last command in case the server is with SNI
echo | openssl s_client -showcerts -servername aks-workpermit-eastus2-np.shwaks.com -connect aks-workpermit-eastus2-np.shwaks.com:443 2>/dev/null | openssl x509 -inform pem -noout -text

#with -connect you can use an IP address instead of a hostname, if the hostname resolves to Volterra’s edge.
#Then, with X.X.X.X being the address of the origin server, you can use:
echo "" | openssl s_client -showcerts -servername aks-workpermit-eastus2-np.shwaks.com -connect X.X.X.X:443 | less to see the raw certificate