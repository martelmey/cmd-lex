use master
go
exec sp_configure 'Show advanced options',1
Go
reconfigure with override
go


use master
go
exec sp_configure 'Agent XPs',1
Go
reconfigure with override
go

use master
go
select * from sys.configurations where name in ('Agent XPs','Show advanced options')

use master
go
exec sp_configure 'Show advanced options',0
Go
reconfigure with override
go