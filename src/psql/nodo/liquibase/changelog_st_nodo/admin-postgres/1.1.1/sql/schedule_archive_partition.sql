SELECT cron.schedule_in_database('job_modify_partition', '30 22 * * *', $$call partition.modify_partition(7, 0);$$,'nodo');

SELECT cron.schedule_in_database('job_add_archive_partition', '30 23 * * *', $$call partition.add_archive_partition();$$,'nodo');
