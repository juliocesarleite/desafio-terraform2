#!/bin/bash
sudo su
sudo amazon-linux-extras install nginx1.12 -y
sudo systemctl start nginx

echo "events{}
http {
   upstream backend {
      server 10.0.1.5:3001; 
      server 10.0.2.6:3002;
      server 10.0.3.7:3003;
   }
   server {
      listen 8080;
      listen 80;
      location / {
         proxy_pass http://backend;
      }
   }
}" > /etc/nginx/nginx.conf

sudo systemctl restart nginx
