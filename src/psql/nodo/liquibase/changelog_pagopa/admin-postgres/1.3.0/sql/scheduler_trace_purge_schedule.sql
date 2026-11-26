
-- Scheduling cfg.scheduler_fire_check_purge at 03:15AM
SELECT cron.schedule_in_database('job_scheduler_trace_purge', '15 03 * * *', $$DELETE FROM offline.scheduler_trace WHERE "start" < Now()::DATE - (interval '30 day');$$, 'nodo');
