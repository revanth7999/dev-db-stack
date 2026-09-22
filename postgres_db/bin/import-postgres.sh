#!/usr/bin/env bash
#
# import-postgres.sh
# Imports a backup created by backup-postgres.sh into the
# dinemaster-postgres-db container.
#
# Usage:
#   ./import-postgres.sh <backup_file> [db_name]
#   ./import-postgres.sh --latest [db_name]     # restore the most recent backup file
#
# Examples:
#   ./import-postgres.sh ../backups/dev_full_20260922_101500.dump
#   ./import-postgres.sh ../backups/dev_schema_20260922_101500.sql
#   ./import-postgres.sh --latest
#   ./import-postgres.sh --latest newdb

set -euo pipefail

CONTAINER_NAME="dinemaster-postgres-db"
DB_USER="root"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="${SCRIPT_DIR}/../backups"

if [ $# -lt 1 ]; then
  echo "Usage: $0 <backup_file> [db_name]"
  echo "       $0 --latest [db_name]"
  exit 1
fi

# --- Resolve which file to restore ---
if [ "$1" == "--latest" ]; then
  BACKUP_FILE="$(ls -t "${BACKUP_DIR}"/*_full_*.dump "${BACKUP_DIR}"/*_schema_*.sql 2>/dev/null | head -n 1 || true)"
  if [ -z "$BACKUP_FILE" ]; then
    echo "Error: no backup files found in ${BACKUP_DIR}" >&2
    exit 1
  fi
  DB_NAME="${2:-dev}"
else
  BACKUP_FILE="$1"
  DB_NAME="${2:-dev}"
fi

if [ ! -f "$BACKUP_FILE" ]; then
  echo "Error: backup file not found: ${BACKUP_FILE}" >&2
  exit 1
fi

if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  echo "Error: container '${CONTAINER_NAME}' is not running." >&2
  exit 1
fi

echo "About to import into database '${DB_NAME}' from:"
echo "  ${BACKUP_FILE}"
read -rp "This may overwrite existing objects. Continue? [y/N] " CONFIRM
if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
  echo "Aborted."
  exit 0
fi

# --- Ensure the target database exists ---
DB_EXISTS=$(docker exec "$CONTAINER_NAME" psql -U "$DB_USER" -tAc \
  "SELECT 1 FROM pg_database WHERE datname='${DB_NAME}'")
if [ "$DB_EXISTS" != "1" ]; then
  echo "Database '${DB_NAME}' does not exist. Creating it..."
  docker exec "$CONTAINER_NAME" psql -U "$DB_USER" -c "CREATE DATABASE ${DB_NAME}"
fi

# --- Restore based on file type ---
case "$BACKUP_FILE" in
  *.dump)
    echo "Importing full backup (custom format) into '${DB_NAME}'..."
    docker exec -i "$CONTAINER_NAME" pg_restore -U "$DB_USER" -d "$DB_NAME" --clean --if-exists < "$BACKUP_FILE"
    ;;
  *.sql)
    echo "Importing plain SQL / schema backup into '${DB_NAME}'..."
    docker exec -i "$CONTAINER_NAME" psql -U "$DB_USER" -d "$DB_NAME" < "$BACKUP_FILE"
    ;;
  *)
    echo "Error: unrecognized backup file extension (expected .dump or .sql)" >&2
    exit 1
    ;;
esac

echo "Import complete: ${DB_NAME} <- ${BACKUP_FILE}"