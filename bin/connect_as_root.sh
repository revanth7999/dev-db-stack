#!/bin/bash

# Connect to the running MySQL container using the MySQL CLI as root
docker exec -it mybackend-db mysql -u root -p dev