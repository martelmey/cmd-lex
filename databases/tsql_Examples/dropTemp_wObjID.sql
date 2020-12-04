IF OBJECT_ID(N'tempdb..#TempTableName') IS NOT NULL
BEGIN
DROP TABLE #TempTableName
END
GO
 
CREATE TABLE #TempTableName
(
Col1 VARCHAR(100)
)