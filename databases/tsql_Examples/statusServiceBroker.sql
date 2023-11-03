EXEC xp_servicecontrol N'querystate',N'SQLServerAGENT'

USE master
go

SELECT database_id AS 'Database ID', 
       NAME        AS 'Database Name', 
       CASE 
         WHEN is_broker_enabled = 0 THEN 'Service Broker is disabled.' 
         WHEN is_broker_enabled = 1 THEN 'Service Broker is Enabled.' 
       END         AS 'Service Broker Status' 
FROM   sys.databases 
WHERE  NAME = 'msdb'