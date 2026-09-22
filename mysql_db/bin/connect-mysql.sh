#!/usr/bin/env bash
#
# connect-mysql.sh
# Connects to the mybackend-db container as root via the mysql client.
#
# Usage:
#   ./connect-mysql.sh            # connects to the default "dev" database
#   ./connect-mysql.sh mydb       # connects to a specific database

set -euo pipefail

CONTAINER_NAME="mybackend-db"
DB_USER="root"
DB_PASSWORD="Root@1234"
DB_NAME="${1:-dev}"

if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  echo "Error: container '${CONTAINER_NAME}' is not running." >&2
  echo "Start it with: docker compose up -d (from the mysql_db folder)" >&2
  exit 1
fi

echo "Connecting to database '${DB_NAME}' as '${DB_USER}' in container '${CONTAINER_NAME}'..."
docker exec -it "${CONTAINER_NAME}" mysql -u"${DB_USER}" -p"${DB_PASSWORD}" "${DB_NAME}"