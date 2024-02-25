server {
    listen 80;
    server_name api.ardeco.app;

    return 301 https://$host$request_uri;
}

server {
    listen              443 ssl;
    server_name         api.ardeco.app;

    ssl_certificate     /etc/letsencrypt/live/api.ardeco.app/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/api.ardeco.app/privkey.pem;
    ssl_protocols       TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers         HIGH:!aNULL:!MD5;

    location / {
        if ($request_method = OPTIONS) {
            add_header 'Access-Control-Allow-Origin' $http_origin;
            add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS, DELETE, PUT, PATCH';
            add_header 'Access-Control-Allow-Headers' 'Content-Type, Authorization';
            add_header 'Access-Control-Allow-Credentials' 'true';
            return 204;
        }

        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

        proxy_pass http://localhost:8000;
    }
}
