--https://1avergne.azurewebsites.net/post/2020/06/11/t-sql-creer-une-table-calendrier
CREATE PROCEDURE [dbo].[LoadCalendar]
	@StartDate date,
	@NumberOfYears INT = 5
AS

DECLARE @CutoffDate DATE = DATEADD(YEAR, @NumberOfYears, @StartDate);
 
--SELECT @StartDate = isnull(DATEFROMPARTS(YEAR([start_date]), 1, 1), @StartDate)
--    ,@CutoffDate = isnull(DATEFROMPARTS(YEAR([end_date]) + 1, 1, 1), @CutoffDate)
--FROM (
--    SELECT min([fact_date]) AS [start_date]
--        ,max([fact_date]) AS [end_date]
--    FROM [dwh].[fact_sales]
--    ) t
 
PRINT 'generate calendar from ' + format(@StartDate, 'yyyy-MM-dd') + ' to ' + format(@CutoffDate, 'yyyy-MM-dd')
 
-- prevent set or regional settings from interfering with 
-- interpretation of dates / literals
-- https://www.mssqltips.com/sqlservertip/4054/creating-a-date-dimension-or-calendar-table-in-sql-server/
SET DATEFIRST 7;
SET DATEFORMAT ydm;
 
INSERT [dbo].[Calendar] ([date])
SELECT d
FROM (
    SELECT d = DATEADD(DAY, rn - 1, @StartDate)
    FROM (
        SELECT TOP (DATEDIFF(DAY, @StartDate, @CutoffDate)) rn = ROW_NUMBER() OVER (
                ORDER BY s1.[object_id]
                )
        FROM sys.all_objects AS s1
        CROSS JOIN sys.all_objects AS s2
        ORDER BY s1.[object_id]
        ) AS x
    ) AS y;
RETURN 0
