use CovidCasesBySource
SELECT diagnosis_date, COUNT(*) AS 'NumberofCases'
FROM CovidCasesBySource
WHERE acquired = 'Contact with a confirmed case'
GROUP BY diagnosis_date
ORDER BY diagnosis_date ASC;



