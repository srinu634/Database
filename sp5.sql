CREATE PROCEDURE Set_no_count_off
AS
SET NOCOUNT OFF
SELECT * FROM Test_DataBase.dbo.TestTable
PRINT @@ROWCOUNT
GO