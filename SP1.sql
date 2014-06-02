CREATE PROCEDURE Display_TestTable_ID @ID int 
AS
Select * from Test_DataBase.dbo.TestTable WHERE @ID=ID
GO