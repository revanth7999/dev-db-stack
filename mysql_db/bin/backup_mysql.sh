#!/usr/bin/env bash
#
# backup-mysql.sh
# Backs up the mybackend-db container's database.
# Timestamped dumps, with automatic pruning of old backups.
#
# Usage:
#   ./backup-mysql.sh                 # full backup (schema + data), default db "dev"
#   ./backup-mysql.sh --schema-only    # schema-only backup
#   ./backup-mysql.sh mydb             # backup a specific database
#   ./backup-mysql.sh mydb --schema-only

set -euo pipefail

CONTAINER_NAME="mybackend-db"
DB_USER="root"
DB_PASSWORD="Root@1234"
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
  FILENAME="${BACKUP_DIR}/${DB_NAME}_mysql_schema_${TIMESTAMP}.sql"
  echo "Backing up schema only: ${DB_NAME} -> ${FILENAME}"
  docker exec "$CONTAINER_NAME" mysqldump -u"$DB_USER" -p"$DB_PASSWORD" --no-data "$DB_NAME" > "$FILENAME"
else
  FILENAME="${BACKUP_DIR}/${DB_NAME}_mysql_full_${TIMESTAMP}.sql"
  echo "Backing up full database (schema + data): ${DB_NAME} -> ${FILENAME}"
  # --single-transaction: consistent snapshot without locking InnoDB tables
  # --routines --triggers --events: capture stored procedures/functions/triggers/events too
  docker exec "$CONTAINER_NAME" mysqldump -u"$DB_USER" -p"$DB_PASSWORD" \
    --single-transaction --routines --triggers --events "$DB_NAME" > "$FILENAME"
fi

echo "Backup complete: ${FILENAME} ($(du -h "$FILENAME" | cut -f1))"

# --- Prune backups older than RETENTION_DAYS ---
DELETED=$(find "$BACKUP_DIR" -name "${DB_NAME}_mysql_*" -type f -mtime "+${RETENTION_DAYS}" -print -delete)
if [ -n "$DELETED" ]; then
  echo "Pruned backups older than ${RETENTION_DAYS} days:"
  echo "$DELETED"
fi