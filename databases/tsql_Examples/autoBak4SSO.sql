use [SolarWindsOrion];
GO
use [master];
GO
BACKUP DATABASE [SolarWindsOrion] TO  DISK = N'A:\SolarWindsOrion_backup_2020_12_01_144952_6129542.bak' WITH  RETAINDAYS = 2, NOFORMAT, NOINIT,  NAME = N'SolarWindsOrion_backup_2020_12_01_144952_6129542', SKIP, REWIND, NOUNLOAD,  STATS = 10
GO
use [SolarWindsOrionLog];
GO
use [master];
GO
BACKUP DATABASE [SolarWindsOrionLog] TO  DISK = N'A:\SolarWindsOrionLog_backup_2020_12_01_144952_6285868.bak' WITH  RETAINDAYS = 2, NOFORMAT, NOINIT,  NAME = N'SolarWindsOrionLog_backup_2020_12_01_144952_6285868', SKIP, REWIND, NOUNLOAD,  STATS = 10