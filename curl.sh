#---> CURL
curl WEBSITE #GET request
    -I WEBSITE #returning only the HTTP headers of a URL
    -o FILE_NAME WEBSITE #saving the result of a curl command
    -H "HTTP-HEADER : VALUE" WEBSITE #adding an additional HTTP request header
    -H "HTTP-HEADER : VALUE" WEBSITE -v #generating additional information
    -I --http2 WEBSITE #check HTTP/2 support
    --request GET/POST/DELETE/PUT WEBSITE #curl examples to simulate HTTP methods
    --proxy yourproxy:port https://yoururl.com #Very handy if you are working on the DMZ server where you need to connect to the external world using a proxy.
    --head http://yoururl.com # want to check the response header
    --insecure https://yoururl.com # Connect HTTPS/SSL URL and ignore any SSL certificate error

#Displaying a remote SSL certificate details 
curl --insecure -vvI https://www.google.com 2>&1 | awk 'BEGIN { cert=0 } /^\* SSL connection/ { cert=1 } /^\*/ { if (cert) print }'
curl -vvI https://www.google.com
