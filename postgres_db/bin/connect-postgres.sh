#!/usr/bin/env bash
#
# connect-postgres.sh
# Connects to the dinemaster-postgres-db container as the root user via psql.
#
# Usage:
#   ./connect-postgres.sh            # connects to the default "dev" database
#   ./connect-postgres.sh mydb       # connects to a specific database

set -euo pipefail

CONTAINER_NAME="dinemaster-postgres-db"
DB_USER="root"
DB_NAME="${1:-dev}"

if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  echo "Error: container '${CONTAINER_NAME}' is not running." >&2
  echo "Start it with: docker compose up -d (from the postgres_db folder)" >&2
  exit 1
fi

echo "Connecting to database '${DB_NAME}' as '${DB_USER}' in container '${CONTAINER_NAME}'..."
docker exec -it "${CONTAINER_NAME}" psql -U "${DB_USER}" -d "${DB_NAME}"