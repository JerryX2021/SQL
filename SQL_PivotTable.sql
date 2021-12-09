use CovidCasesBySource
SELECT 'Count' AS Cases_sorted_by_acquired,
  [Travel overseas],[Acquired in Australia, unknown source],[Under investigation],[Contact with a confirmed case]
FROM
(
 SELECT acquired, diagnosis_date
 FROM CovidCasesBySource
) AS SourceTable
PIVOT
(
  COUNT(diagnosis_date)
  FOR acquired IN ([Travel overseas],[Acquired in Australia, unknown source],[Under investigation],[Contact with a confirmed case])
) AS PivotTable;
