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