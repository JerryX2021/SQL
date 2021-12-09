DECLARE @StartDate DATE = '20200125'
  , @EndDate DATE = '20211127';

WITH new_table AS
( 
SELECT  DATEADD(DAY, nbr - 1, @StartDate) AS 'diagnosis_date'
FROM    ( SELECT    ROW_NUMBER() OVER ( ORDER BY c.object_id ) AS nbr
          FROM      sys.columns c
        ) nbrs
WHERE   nbr - 1 <= DATEDIFF(DAY, @StartDate, @EndDate)
),

at_OS AS
(
SELECT diagnosis_date, COUNT(*) AS 'Count_OS'
FROM CovidCasesBySource
WHERE acquired = 'Travel overseas'
GROUP BY diagnosis_date
),

in_AU AS
(
SELECT diagnosis_date, COUNT(*) AS 'Count_AU'
FROM CovidCasesBySource
WHERE acquired = 'Acquired in Australia, unknown source'
GROUP BY diagnosis_date
),

UI AS
(
SELECT diagnosis_date, COUNT(*) AS 'Count_UI'
FROM CovidCasesBySource
WHERE acquired = 'Under investigation'
GROUP BY diagnosis_date
),

CC AS
(
SELECT diagnosis_date, COUNT(*) AS 'Count_CC'
FROM CovidCasesBySource
WHERE acquired = 'Contact with a confirmed case'
GROUP BY diagnosis_date
)

SELECT new_table.diagnosis_date, ISNULL(at_OS.Count_OS,0) AS 'Travel overseas', 
       ISNULL(in_AU.Count_AU,0) AS 'In AU unknown source',
       ISNULL(UI.Count_UI,0) AS 'Under investigation', ISNULL(CC.Count_CC,0) AS 'Contact with a confirmed case'
FROM new_table
LEFT JOIN at_OS
  ON new_table.diagnosis_date = at_OS.diagnosis_date
LEFT JOIN in_AU
  ON new_table.diagnosis_date = in_AU.diagnosis_date
LEFT JOIN UI
  ON new_table.diagnosis_date = UI.diagnosis_date
LEFT JOIN CC
  ON new_table.diagnosis_date = CC.diagnosis_date;

