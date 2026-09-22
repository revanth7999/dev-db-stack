# dev-db-stack

Local database infrastructure for development, running via Docker Compose on WSL (Ubuntu-20.04). Contains two independent database services — MySQL and PostgreSQL — each with its own compose file and helper scripts.

## Structure

```
dev-db-stack/
├── mysql_db/
│   ├── bin/
│   │   ├── backup_mysql.sh      # Backup the MySQL database
│   │   ├── connect-mysql.sh     # Connect to MySQL as root
│   │   └── import_schema.sh     # Import a backup into MySQL
│   └── docker-compose.yml
├── postgres_db/
│   ├── backups/                 # Postgres backup dumps (git-ignored)
│   ├── bin/
│   │   ├── backup-postgres.sh   # Backup the Postgres database
│   │   ├── connect-postgres.sh  # Connect to Postgres as root
│   │   └── import-postgres.sh   # Import a backup into Postgres
│   └── docker-compose.yml
├── .gitignore
└── README.md
```

## Services

| Service    | Container name             | Image              | Host port | Default DB |
|------------|-----------------------------|--------------------|-----------|------------|
| MySQL      | `mybackend-db`              | mysql:8.0          | 3307      | dev        |
| PostgreSQL | `dinemaster-postgres-db`    | postgres:15-alpine | 5432      | dev        |

Both services attach to a shared external Docker network (`my_shared_network`), so app containers can reach either database by container name. Create the network once before starting either service, if it doesn't already exist:

```bash
docker network create my_shared_network
```

## Getting started

Start a service from its own folder:

```bash
# MySQL
cd mysql_db
docker compose up -d

# Postgres
cd postgres_db
docker compose up -d
```

Each service can be started and stopped independently.

## Scripts

Each `bin/` folder holds three helper scripts for its database. Run them from inside the relevant `bin/` folder.

### MySQL (`mysql_db/bin/`)

- **`connect-mysql.sh [db_name]`** — opens an interactive MySQL shell as root. Defaults to the `dev` database.
- **`backup_mysql.sh [db_name] [--schema-only]`** — dumps the database to a timestamped `.sql` file. Full backup by default; add `--schema-only` for structure only.
- **`import_schema.sh <backup_file> [db_name]`** — imports a `.sql` backup into MySQL, creating the target database if it doesn't exist.

### PostgreSQL (`postgres_db/bin/`)

- **`connect-postgres.sh [db_name]`** — opens an interactive `psql` shell as root. Defaults to the `dev` database.
- **`backup-postgres.sh [db_name] [--schema-only]`** — dumps the database to a timestamped file in `postgres_db/backups/`. Full backups use `pg_dump`'s custom format (`.dump`); `--schema-only` produces plain `.sql`. Backups older than 14 days are pruned automatically.
- **`import-postgres.sh <backup_file> [db_name]`** — imports a `.dump` or `.sql` backup into Postgres, creating the target database if it doesn't exist. Prompts for confirmation before overwriting.
  - `import-postgres.sh --latest [db_name]` restores the most recent backup automatically.

## Backups

Postgres backups are stored under `postgres_db/backups/` and excluded from version control via `.gitignore`. Back up regularly and keep a copy off the local machine (e.g. synced to cloud storage) — a backup that only exists on the same disk as the database doesn't protect against disk failure.

## Notes

- Credentials are currently set directly in each `docker-compose.yml`. Consider moving them to a `.env` file (excluded from git) before sharing this setup or using it beyond local dev.
- `pg_dump`/`pg_restore` and `mysqldump`/`mysql` should be used with tool versions matching the database's major version to avoid compatibility issues.