#!/bin/bash

# Drops all tables from the 'dev' database in the running MySQL container

docker exec mybackend-db mysql -u root -pRoot@1234 dev -e "SET FOREIGN_KEY_CHECKS = 0; \
    SET GROUP_CONCAT_MAX_LEN=32768; \
    SET @tables = (SELECT GROUP_CONCAT(table_name) FROM information_schema.tables WHERE table_schema = 'dev'); \
    SET @stmt = CONCAT('DROP TABLE IF EXISTS ', @tables); \
    PREPARE stmt FROM @stmt; \
    EXECUTE stmt; \
    DEALLOCATE PREPARE stmt; \
    SET FOREIGN_KEY_CHECKS = 1;"

echo "All tables in 'dev' database have been dropped."