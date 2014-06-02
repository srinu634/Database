/* Although ; is not a part of SQL Query, I tend to use it for better understanding of the code*/
EXEC Display_TestTable ;
EXEC Display_TestTable_ID @ID = 1666678 ;						
EXEC Display_TestTable_ID_With_Default_Paramater_Value;       /* Empty Result*/

DECLARE @rowCount int /*row_count*/
EXEC With_Output @Id = 166678 , @rowCount =  @RowCount OUTPUT ; /*name = value output */

SELECT /*'Here' ; SELECT is also used to print statements , how cool? */
 EXEC TryCatchTest ; /* Generate an error , this procedure is dropped */

EXEC Set_no_count_off;
