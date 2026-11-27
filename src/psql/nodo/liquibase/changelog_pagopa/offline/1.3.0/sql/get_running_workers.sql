CREATE OR REPLACE FUNCTION offline.get_running_workers()
RETURNS TABLE (
    job_name text,
    extra_key text,
    "start" timestamp,
    running_for_seconds bigint
)
LANGUAGE sql
STABLE
AS $$

    WITH clock AS (
         SELECT timezone('Europe/Rome', now()) AS current_local
    )
    SELECT j.job_name,
           j.extra_key,
           j."start",
           floor(extract(epoch FROM (c.current_local - j."start")))::BIGINT AS running_for_seconds
      FROM offline.scheduler_fire_check j
     CROSS JOIN clock c
     WHERE j.status = 'RUNNING' and j."start" < current_timestamp - interval '1 days'
     ORDER BY j."start";

$$;
