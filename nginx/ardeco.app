server {
    listen 80;
    server_name ardeco.app;

    return 301 https://$host$request_uri;
}

server {
    listen              443 ssl;
    server_name         ardeco.app;

    ssl_certificate     /etc/letsencrypt/live/ardeco.app/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/ardeco.app/privkey.pem;
    ssl_protocols       TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers         HIGH:!aNULL:!MD5;

    location / {
        proxy_pass http://localhost:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	    add_header Access-Control-Allow-Origin *;
    }
}
