
-- Scheduling cfg.cache purge at 04:00AM
SELECT cron.schedule_in_database('job_cfg_cache_purge', '00 04 * * *', $$call cfg.cfg_cache_purge();$$, 'nodo');
