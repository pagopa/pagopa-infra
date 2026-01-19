.create external table ['AuditLogs'] (["LogEntry"]:dynamic)
    kind = blob
partition by (['IngestionDatetime']:datetime )
pathformat = (datetime_pattern("yyyy/MM/dd/HH/mm", ['IngestionDatetime']))
    dataformat = multijson
    (
        h@'https://${storage_account_name}.blob.core.windows.net/${storage_account_container_name}/audit-logs;impersonate'
    )
    with (FileExtension=json)
