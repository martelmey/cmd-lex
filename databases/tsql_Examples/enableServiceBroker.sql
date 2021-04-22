Use master
go
alter database [MSDB] set single_user with rollback immediate
GO
alter database [MSDB] set Enable_Broker
GO
alter database [MSDB] set multi_user with rollback immediate
GO