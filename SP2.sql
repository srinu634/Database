CREATE PROCEDURE Display_TestTable_ID_With_Default_Paramater_Value @ID int = 0
AS
Select * from Test_DataBase.dbo.TestTable WHERE @ID=ID
GO