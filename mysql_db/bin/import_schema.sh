#!/usr/bin/env bash
#
# import-mysql.sh
# Imports a backup created by backup-mysql.sh into the mybackend-db container.
#
# Usage:
#   ./import-mysql.sh <backup_file> [db_name]
#   ./import-mysql.sh --latest [db_name]     # import the most recent backup file
#
# Examples:
#   ./import-mysql.sh ../backups/dev_mysql_full_20260922_101500.sql
#   ./import-mysql.sh ../backups/dev_mysql_schema_20260922_101500.sql
#   ./import-mysql.sh --latest
#   ./import-mysql.sh --latest newdb

set -euo pipefail

CONTAINER_NAME="mybackend-db"
DB_USER="root"
DB_PASSWORD="Root@1234"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="${SCRIPT_DIR}/../backups"

if [ $# -lt 1 ]; then
  echo "Usage: $0 <backup_file> [db_name]"
  echo "       $0 --latest [db_name]"
  exit 1
fi

# --- Resolve which file to import ---
if [ "$1" == "--latest" ]; then
  BACKUP_FILE="$(ls -t "${BACKUP_DIR}"/*_mysql_full_*.sql "${BACKUP_DIR}"/*_mysql_schema_*.sql 2>/dev/null | head -n 1 || true)"
  if [ -z "$BACKUP_FILE" ]; then
    echo "Error: no MySQL backup files found in ${BACKUP_DIR}" >&2
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
docker exec "$CONTAINER_NAME" mysql -u"$DB_USER" -p"$DB_PASSWORD" \
  -e "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`"

# --- Import (mysqldump output is plain SQL, same command for full or schema-only) ---
echo "Importing into '${DB_NAME}'..."
docker exec -i "$CONTAINER_NAME" mysql -u"$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" < "$BACKUP_FILE"

echo "Import complete: ${DB_NAME} <- ${BACKUP_FILE}"