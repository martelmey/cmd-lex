# rman $HOME/scripts/rman_restore_lnxmaster.sql
connect target /
shutdown immediate;
startup mount;
run {
	allocate channel ch1 type sbt;
	send 'NB_ORA_SERV=lnxmaster.vrtsedu.lab';
	restore database;
	recover database;
}
alter database open;
quit;