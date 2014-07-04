USE [CHEF_DEDB];

--Create Necessary Tables.


IF OBJECT_ID('tempdb..#E2ETA') IS NOT NULL -- End to End Traceability
	DROP TABLE #E2ETA

IF OBJECT_ID('tempdb..#E2ETA1') IS NOT NULL -- End to End Traceability
	DROP TABLE #E2ETA1

IF OBJECT_ID('tempdb..#TestCaseTA') IS NOT NULL -- Test Case Traceability
	DROP TABLE #TestCaseTA

IF OBJECT_ID('tempdb..#NCDTA') IS NOT NULL		-- NonCodeDefect Traceability
	DROP TABLE #NCDTA

IF OBJECT_ID('tempdb..#CDTA') IS NOT NULL		-- CodeDefect Traceability
	DROP TABLE #CDTA
	 
IF OBJECT_ID('tempdb..#TaskTA') IS NOT NULL		-- Task Traceability
	DROP TABLE #TaskTA


--Populate the Tables

select distinct R1.[vstf id] as vstfID,R1.unit,  R1.PortFolio,R1.[Created By]
      ,R1.[Resolved By]
      ,R1.[Area]
      ,R1.[CreateDate],  R1.FiscalYear, R1.Month, R1.Application, R2.TraceID, R1.link,R1.State,
      R1.ID,R1.[Title],R1.[Release],'TestCase Traceability' AS TYPE into #TestCaseTA from RequirementtoTestCaseres R1 
	  inner join RequirementtoTestCase R2 on 
			R1.[vstf id] = R2.[vstf ID] and R1.application = R2.application and R1.state = R2.state and R1.link = R2.link


	 

select distinct R1.[vstf id] as vstfID,R1.unit,  R1.PortFolio,R1.[Created By]
      ,R1.[Resolved By]
      ,R1.[Area]
      ,R1.[CreateDate],  R1.FiscalYear, R1.Month, R1.Application, R2.TraceID, R1.link,R1.State,
      R1.ID,R1.[Title],R1.[Release],'NonCodeDefect Traceability' AS TYPE into #NCDTA from NonCodeDefectTraceabilityRes R1 
	  inner join NonCodeDefectTraceability R2 on 
			R1.[vstf id] = R2.[vstf ID] and R1.application = R2.application and R1.state = R2.state and R1.link = R2.link

		


select distinct R1.[vstf id] as vstfID,R1.unit,  R1.PortFolio,R1.[Created By]
      ,R1.[Resolved By]
      ,R1.[Area]
      ,R1.[CreateDate],  R1.FiscalYear, R1.Month, R1.Application, R2.TraceID, R1.link,R1.State,
      R1.ID,R1.[Title],R1.[Release],'CodeDefect Traceability' AS TYPE into #CDTA from TestCaseToBugRes R1 
	  inner join TestCaseToBug R2 on 
			R1.[vstf id] = R2.[vstf ID] and R1.application = R2.application and R1.state = R2.state and R1.link = R2.link

		
select distinct R1.[vstf id] as vstfID,R1.unit,  R1.PortFolio,R1.[Created By]
      ,R1.[Resolved By]
      ,R1.[Area]
      ,R1.[CreateDate],  R1.FiscalYear, R1.Month, R1.Application, R2.TraceID, R1.link,R1.State,
      R1.ID,R1.[Title],R1.[Release],'Task Traceability' AS TYPE into  #TaskTA from TaskTraceabilityRes R1 
	  inner join TaskTraceability R2 on 
			R1.[vstf id] = R2.[vstf ID] and R1.application = R2.application and R1.state = R2.state and R1.link = R2.link

		
--Debug Statements
--select * from #TestCaseTA
--select * from #NCDTA
--select * from #CDTA
--select * from #TaskTA
--select count(1) from #TestCaseTA 
--select count(1) from #NCDTA 
--select count(1) from #CDTA 
--select count(1) from #TaskTA 

 select * into #E2ETA from 
(
select * from #TestCaseTA
	union all
select * from #NCDTA
	union all
select * from #CDTA
	union all
select * from #TaskTA
) A --populate E2E Table

--select count(1) from #E2ETA


		-- Drop the tables we don't need anymore
IF OBJECT_ID('tempdb..#TestCaseTA') IS NOT NULL -- Test Case Traceability
	DROP TABLE #TestCaseTA

IF OBJECT_ID('tempdb..#NCDTA') IS NOT NULL		-- NonCodeDefect Traceability
	DROP TABLE #NCDTA

IF OBJECT_ID('tempdb..#CDTA') IS NOT NULL		-- CodeDefect Traceability
	DROP TABLE #CDTA
	 
IF OBJECT_ID('tempdb..#TaskTA') IS NOT NULL		-- Task Traceability
	DROP TABLE #TaskTA


	---- Create a Hierarchial structure using Joins to find if a workitem is linked to requirement.

	--This is Similar to Employee Manager Example.
	--What we are doing here is : We are extending the logic to find Manager's Manager, Manager's Manager's Manger and so on till 5 levels.

	--That is,
	--	We are finding all the traceid's , traceid's traceid ,  traceid's traceid's traceid......till 5 levels....

	

	select DISTINCT E1.[vstfID],E1.[unit],E1.[PortFolio],E1.[Created By],E1.[Resolved By],E1.[Area],E1.[CreateDate],E1.[FiscalYear],E1.[Month],E1.[Application],E1.[link],E1.[State],E1.[ID],R.[Title],E1.[Type],
	E1.[vstfID] AS E1_vstfID, E2.[vstfID] AS E2_vstfID,E3.[vstfID] AS E3_vstfID,E4.[vstfID] AS E4_vstfID,E5.[vstfID] AS E5_vstfID,E6.[vstfID] AS E6_vstfID,coalesce(E6.[vstfID],E5.[vstfID],E4.[vstfID],E3.[vstfID],E2.[vstfID] ) as E2EID,R.[vstf ID] as ReqID,		--Hierarchial
	E2E_STATUS =  CASE 
		WHEN R.[vstf ID] IS NOT NULL 
			THEN 'linked'
		else
			'not linked'
	end ,
	R.[Release]
	into #E2ETA1
	from #E2ETA AS E1 
	LEFT JOIN #E2ETA AS E2 on E1.TraceID = E2.[vstfId]	
	LEFT JOIN  #E2ETA AS E3 on E2.TraceID = E3.[vstfId]
	LEFT JOIN  #E2ETA AS E4 on E3.TraceID = E4.[vstfId]
	LEFT JOIN  #E2ETA AS E5 on E4.TraceID = E5.[vstfId]
	LEFT JOIN  #E2ETA AS E6 on E5.TraceID = E6.[vstfId]
	LEFT JOIN [CHEF_DEDB].[dbo].[Requirements_E2E] R 
	on coalesce(E6.[vstfID],E5.[vstfID],E4.[vstfID],E3.[vstfID],E2.[vstfID] ) = R.[vstf ID]
	ORDER BY E1.[vstfID],E2.[vstfID],E3.[vstfID],E4.[vstfID],E5.[vstfID],E6.[vstfID] 

	
	--select * from #E2ETA1
	--select count(*),e2e_status from #E2ETA1 group by E2E_STATUS

	IF OBJECT_ID('tempdb..#E2ETA') IS NOT NULL		--Drop the table as we don't need it anymore
		DROP TABLE #E2ETA
	
	IF OBJECT_ID('tempdb..#E2ETA2') IS NOT NULL 
		DROP TABLE #E2ETA2

	  select * into #E2ETA2 from 
	  (
         select * from #E2ETA1
          Union 
          (
		   Select distinct R.[vstf ID],P.BU as UNIT,P.subBU as Portfolio,'','','','','','',R.Application,'','','',R.Title,'',0,0,0,0,0,0,0,0,'',R.Release AS RELEASE
		   FROM Requirements_E2E R
		   INNER JOIN  ProjectList P on R.application = P.application 
		   Left Join #E2ETA1 E on E.ReqID = R.[VSTF ID] and E.Application  = R.Application
		   where E.[vstfID] is NULL
		  ) 
		  ) B;



	 truncate table [CHEF_DEDB].[dbo].[E2ETraceability];
	 insert  into [CHEF_DEDB].[dbo].[E2ETraceability] select * from #E2ETA2;

	

	select unit,portfolio,fiscalyear,month,application,release,title,sum(case when e2e_status = 'linked' then 1 else 0 end) as total_linked,
	   sum(case when e2e_status = 'not linked' then 1 else 0 end) as total_not_linked
		from #E2ETA2
		group by unit,portfolio,fiscalyear,month,application,release,title


		-- Drop the tables
		 IF OBJECT_ID('tempdb..#E2ETA1') IS NOT NULL 
		DROP TABLE #E2ETA1

		IF OBJECT_ID('tempdb..#E2ETA2') IS NOT NULL
		DROP TABLE #E2ETA2



	 
------------------------------------------------------DEBUG Statements -------------------------------------------------------------------


	--select * from #E2ETA where vstfID = 116601 or vstfID = 124362 or vstfID = 126325 or vstfID = 128106 or vstfID = 110606 or vstfID = 60267 order by vstfID
	--select count(*) , E2E_STATUS from #E2ETA1 GROUP BY E2E_STATUS
	--select * from tempdb.sys.columns where object_id = object_id('tempdb..#E2ETA2');
