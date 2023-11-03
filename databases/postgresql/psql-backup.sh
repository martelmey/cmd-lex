#!/bin/bash
# Remove old backup
if [ -f /export/pkgs/cmdb-postgres-backups/backup_cmdb.tar ]; then
    /usr/bin/rm -f /export/pkgs/cmdb-postgres-backups/backup_cmdb.tar
    /usr/bin/echo "Old backup removed." > /home/postgres/psql-backup.log
fi
# Start new backup
/usr/bin/pg_dump -U cmdb -F t cmdb > /export/pkgs/cmdb-postgres-backups/backup_cmdb.tar
if [ -f /export/pkgs/cmdb-postgres-backups/backup_cmdb.tar ]; then
    /usr/bin/echo "Success: New CMDB backup created." >> /home/postgres/psql-backup.log
else
    /usr/bin/echo "Backup creation failed." >> /home/postgres/psql-backup.log
fi

# 0 0 * * * /home/postgres/psql-backup.sh