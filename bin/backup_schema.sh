#!/bin/bash

# Create a backup of the 'dev' database from the running MySQL container
BACKUP_DIR="$(dirname "$(pwd)")/backup_foodler"
mkdir -p "$BACKUP_DIR"
BACKUP_FILE="$BACKUP_DIR/dev_backup_$(date +%Y%m%d_%H%M%S).sql"

docker exec mybackend-db mysqldump -u root -pRoot@1234 dev > "$BACKUP_FILE"

echo "Backup saved to $BACKUP_FILE"