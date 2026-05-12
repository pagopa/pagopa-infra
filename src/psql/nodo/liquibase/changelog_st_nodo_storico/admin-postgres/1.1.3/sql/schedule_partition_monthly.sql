CREATE EXTENSION IF NOT EXISTS pg_cron;

SELECT cron.schedule_in_database('job_modify_partition_monthly', '00 22 * * *', $$call partition.modify_partition_monthly(2,0);$$,'nodo');

SELECT cron.schedule_in_database('job_archive_partition_monthly', '00 02 * * *', $$call partition.archive_partition_monthly();$$,'nodo');
