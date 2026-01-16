WITH records AS(
  SELECT records.arrayvalue as sig
  FROM [audit-logs-input]
  CROSS APPLY GetArrayElements(records) AS records
)

SELECT sig.LogEntry
INTO [audit-logs-output]
FROM records
WHERE udf.parseJson(sig.LogEntry).audit='true'