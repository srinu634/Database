USE Test_DataBase ;

select * from student;
select * from hosteldata;


SELECT * FROM student AS S INNER JOIN HOSTELDATA AS H on S.ID = H.ID;

SELECT * FROM student AS S FULL JOIN HOSTELDATA AS H on S.ID = H.ID; 

SELECT * FROM student AS S LEFT JOIN HOSTELDATA AS H on S.ID = H.ID; 

SELECT * FROM student AS S RIGHT JOIN HOSTELDATA AS H on S.ID = H.ID; 

SELECT * FROM student AS S CROSS JOIN HOSTELDATA AS H ; 



/*
 JOINS :
	Inner Join :  Intersection of the two tables     ( Explore it on conditioning two fields )
	
	Outer Join :
				 -> Left Outer Join A + { Fields in B given in Query}
				 -> Right Outer Join B + { Fields in A given in Query}
				 -> Full Outer Join    A U B 
	Cross Join :
				Cartesian Product A X B

	Self Join :
				 -> When Join operation ( any of the above ) is used on the table itself.
				    EX: Exmployee and his manager information are in the same table.
	
	Equi Join :
				Has only '=' operator. Can be Inner, Left Outer and Right Outer.

	Theta Join :
				Can Have < > <= >= along with = 

	Natural Join :
				The Query will have only one column for repeated columns. It is an Equijoin ( What if more than one attribute has equal field names? all are displayed only once? )

 */


 /*
 -- Having a knowledge about Joins is good , but when the database size blows up, We need to optimise our queries
	and to optimise them , we need to know how exactly our Joins | infact any query works.
*/