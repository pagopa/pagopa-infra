CREATE EXTENSION IF NOT EXISTS pg_cron;

SELECT cron.schedule_in_database('job_modify_partition', '30 22 * * *', $$call partition.modify_partition(7,0);$$,'nodo');

SELECT cron.schedule_in_database('job_archive_partition', '30 00 * * *', $$call partition.archive_partition();$$,'nodo');
