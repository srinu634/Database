CREATE PROCEDURE With_Output @Id int  , @RowCount int OUTPUT
AS
Select COUNT(*) from Test_DataBase.dbo.TestTable
GO
