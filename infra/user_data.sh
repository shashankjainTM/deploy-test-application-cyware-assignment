#!/bin/bash
sudo systemctl start docker
sudo service docker start

cat > docker-compose.yml <<- "EOF"
version: "3.9"
services:
  web:
    image: shashankjaintm/test-application-cyware-assignment:v0.0.1
    ports:
      - "80:8080"
EOF

docker-compose up
    
