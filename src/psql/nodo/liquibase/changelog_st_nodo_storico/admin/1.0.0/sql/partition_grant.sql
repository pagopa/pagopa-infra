GRANT azure_pg_admin TO partition;
-- grant azureuser to partition;
GRANT pg_read_all_settings TO partition;
GRANT pg_read_all_stats TO partition;
GRANT pg_stat_scan_tables TO partition;
GRANT CONNECT ON DATABASE nodo TO partition;
GRANT ALL ON SCHEMA partition TO partition;
ALTER DEFAULT PRIVILEGES FOR ROLE azureuser IN SCHEMA partition
GRANT ALL ON TABLES TO partition;
ALTER DEFAULT PRIVILEGES FOR ROLE azureuser IN SCHEMA partition
GRANT ALL ON SEQUENCES TO partition;
ALTER DEFAULT PRIVILEGES FOR ROLE azureuser IN SCHEMA partition
GRANT EXECUTE ON FUNCTIONS TO partition;
ALTER DEFAULT PRIVILEGES FOR ROLE azureuser IN SCHEMA partition
GRANT USAGE ON TYPES TO partition;
GRANT ALL ON SCHEMA online TO partition;
ALTER DEFAULT PRIVILEGES FOR ROLE azureuser IN SCHEMA online
GRANT ALL ON SEQUENCES TO partition;
ALTER DEFAULT PRIVILEGES FOR ROLE azureuser IN SCHEMA online
GRANT EXECUTE ON FUNCTIONS TO partition;
ALTER DEFAULT PRIVILEGES FOR ROLE azureuser IN SCHEMA online
GRANT USAGE ON TYPES TO partition;
