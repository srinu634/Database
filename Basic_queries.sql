/* Srinivas Suri. -- My Hands on Database */


-- Basic
SELECT * FROM TEST_DATABASE.DBO.TESTTABLE; -- The Basic Query

SELECT  NAME,ID FROM TEST_DATABASE.DBO.TESTTABLE ;				-- ALL ROWS ALONG WITH THEIR NAME, ID		11

SELECT  DISTINCT ID FROM TEST_DATABASE.DBO.TESTTABLE ;			-- ALL DISTINCT ID'S TAKEN FROM ALL ROWS	8

SELECT  DISTINCT NAME,ID FROM TEST_DATABASE.DBO.TESTTABLE ;		-- ALL DISTINCT (NAME,ID) TUPLES FROM ALL THE ROWS ?? NEED TO CLARIFY THIS

-- AND OR WHERE [BETWEEN] ARE QUITE INTUITIVE 

SELECT NAME,ID FROM TEST_DATABASE.DBO.TESTTABLE WHERE ( ID BETWEEN 1666678 AND 1666678 ) AND ( ID > 1) ; -- BOOLEAN QUERIES ALONG WITH RANGE QUERIES

-- IN OPERATOR : Multiple values in a WHERE CLAUSE

SELECT * FROM TEST_DATABASE.DBO.TESTTABLE WHERE DEPARTMENT in ( 'CFIT' , 'CSIT' ); -- SELECTS From both CFIT,CSIT

SELECT * FROM TEST_DATABASE.DBO.TESTTABLE WHERE DEPARTMENT /*NOT*/ LIKE '[abc]%T%' ;  -- [abc || ABC] is same and is not case sensitive

-- ORDER BY

SELECT * FROM Test_DataBase.dbo.TestTable ORDER BY NAME,AGE ASC ; --sorts w.r.t each field given in the same order and display the result


-- Limiting the Results

--  SELECT * FROM TEST_DATABASE.DBO.TESTTABLE LIMIT 4;       -- THIS DOES NOT WORK IN MSSQL

SELECT TOP 50 PERCENT * FROM TEST_DATABASE.DBO.TESTTABLE; --Self Explanatory

SELECT TOP 2 * FROM TEST_DATABASE.DBO.TESTTABLE; -- GET ONLY THE TOP 2 ROWS


-- Aliasing
SELECT NAME as TEMPNAME,ID as EMPID FROM TEST_DATABASE.DBO.TESTTABLE AS TEMPTABLE WHERE TEMPTABLE.AGE > 1; -- As to ALIAS - To Give an alias name to a given Column,Table etc etc


 /*	Query Optimisations:

	EX1: To get all the rows from a DBMS , Most of the people use : SELECT COUNT(*) FROM TEST_DATABASE.DBO.TESTTABLE ;
		 We could have just used SELECT count(1) FROM TEST_DATABASE.DBO.TESTTABLE;

		 In the first Query, Every column in every row is returned along with the count operation
		 In the second Query, A Table with 1 in each row is returned, which is infact efficient than returning all columns in the rows 
	
*/

SELECT 1 FROM TEST_DATABASE.DBO.TESTTABLE ;

SELECT COUNT(*) FROM TEST_DATABASE.DBO.TESTTABLE ;

SELECT count(1) FROM TEST_DATABASE.DBO.TESTTABLE;



/* 
	Indexing :
				Create an index on a field for logn Searching
				By Default, SQL Server itself builts a Index w.r.t a  Primary Key
				Insertion, Deletion will be a pain for the SQL Server when indexes are there, but , anyways we don't care about what happens internally
				Also, don't build too many indexes for the above reason and to save disk space

	SQL Query to build an Index on an attribute:
*/
