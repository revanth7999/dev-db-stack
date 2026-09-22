#!/usr/bin/env bash
#
# backup-postgres.sh
# Backs up the dinemaster-postgres-db container's database.
# Mirrors typical prod conventions: timestamped dumps, custom format
# (for selective/parallel restore), and automatic pruning of old backups.
#
# Usage:
#   ./backup-postgres.sh                 # full backup (schema + data), default db "dev"
#   ./backup-postgres.sh --schema-only    # schema-only backup
#   ./backup-postgres.sh mydb             # backup a specific database
#   ./backup-postgres.sh mydb --schema-only

set -euo pipefail

CONTAINER_NAME="dinemaster-postgres-db"
DB_USER="root"
RETENTION_DAYS=14

# --- Parse args (db name and/or --schema-only, in either order) ---
DB_NAME="dev"
SCHEMA_ONLY=false
for arg in "$@"; do
  if [[ "$arg" == "--schema-only" ]]; then
    SCHEMA_ONLY=true
  else
    DB_NAME="$arg"
  fi
done

# --- Resolve script's own directory, backups live alongside it ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="${SCRIPT_DIR}/../backups"
mkdir -p "$BACKUP_DIR"

TIMESTAMP="$(date +%Y%m%d_%H%M%S)"

if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  echo "Error: container '${CONTAINER_NAME}' is not running." >&2
  exit 1
fi

if [ "$SCHEMA_ONLY" = true ]; then
  FILENAME="${BACKUP_DIR}/${DB_NAME}_schema_${TIMESTAMP}.sql"
  echo "Backing up schema only: ${DB_NAME} -> ${FILENAME}"
  docker exec "$CONTAINER_NAME" pg_dump -U "$DB_USER" -d "$DB_NAME" --schema-only > "$FILENAME"
else
  FILENAME="${BACKUP_DIR}/${DB_NAME}_full_${TIMESTAMP}.dump"
  echo "Backing up full database (schema + data): ${DB_NAME} -> ${FILENAME}"
  # Custom format (-Fc): compressed, supports selective/parallel restore via pg_restore
  docker exec "$CONTAINER_NAME" pg_dump -U "$DB_USER" -d "$DB_NAME" -Fc > "$FILENAME"
fi

echo "Backup complete: ${FILENAME} ($(du -h "$FILENAME" | cut -f1))"

# --- Prune backups older than RETENTION_DAYS ---
DELETED=$(find "$BACKUP_DIR" -name "${DB_NAME}_*" -type f -mtime "+${RETENTION_DAYS}" -print -delete)
if [ -n "$DELETED" ]; then
  echo "Pruned backups older than ${RETENTION_DAYS} days:"
  echo "$DELETED"
fi