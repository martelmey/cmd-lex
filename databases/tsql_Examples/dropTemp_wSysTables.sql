IF EXISTS(SELECT [name] FROM tempdb.sys.tables WHERE [name] like '#TempTableName%') 
BEGIN
   DROP TABLE #TempTableName;
END;
 
CREATE TABLE #TempTableName
(
Col1 VARCHAR(100)
)