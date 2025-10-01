#!/bin/bash

# Usage: bash import_schema.sh "filename.sql"
BACKUP_FILE="$1"

if [ -f "$BACKUP_FILE" ]; then
    docker exec -i mybackend-db mysql -u root -pRoot@1234 dev < "$BACKUP_FILE"
    echo "Imported backup from $BACKUP_FILE"
else
    echo "Backup file $BACKUP_FILE not found."
fi