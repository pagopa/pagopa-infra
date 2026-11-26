CREATE OR REPLACE FUNCTION offline.get_cron_monitoring()
RETURNS TABLE (
    job text,
    last_run text,
    observed_interval_seconds bigint,
    last_run_interval_seconds bigint,
    monitoring_result text
)
LANGUAGE sql
STABLE
AS $$

    WITH clock AS (
         SELECT timezone('Europe/Rome', now()) AS current_local
    ),
    sorted_runs AS (
        SELECT t.job_name,
               t.status,
               t.message,
               t."start" AS run_at,
               row_number() OVER (
                 PARTITION BY t.job_name
                 ORDER BY t."start" DESC
               ) AS run_number
          FROM offline.scheduler_trace t
    ),
    last_two_runs AS (
        SELECT job_name,
               MAX(run_at) FILTER (WHERE run_number = 1) AS last_run,
               MAX(run_at) FILTER (WHERE run_number = 2) AS previous_run,
               MAX(status) FILTER (WHERE run_number = 1) AS last_status,
               MAX(message) FILTER (WHERE run_number = 1) AS last_message
          FROM sorted_runs
         WHERE run_number <= 2
         GROUP BY job_name
    ),
    metrics AS (
        SELECT l.*,
               floor(extract(epoch FROM (c.current_local - l.last_run)))::BIGINT AS last_run_interval_seconds,
               floor(extract(epoch FROM (l.last_run - l.previous_run)))::BIGINT AS observed_interval_seconds
          FROM last_two_runs l
    CROSS JOIN clock c
    )
    SELECT job_name AS job,
           to_char(last_run, 'YYYY-MM-DD HH24:MI:SS') AS last_run,
           observed_interval_seconds,
           last_run_interval_seconds,
           CASE
             WHEN previous_run IS NULL THEN 'NO RUN AVAILABLE'
             WHEN observed_interval_seconds <= 0 THEN 'LOG ANOMALY'
             WHEN last_run_interval_seconds > observed_interval_seconds * 1.5 THEN 'LATE'
             WHEN last_status = 'WARN' THEN concat('WARN - ', coalesce(last_message, 'NO DETAILS'))
             ELSE 'EXECUTED'
           END AS monitoring_result
      FROM metrics
     ORDER BY
           CASE
             WHEN previous_run IS NULL OR observed_interval_seconds <= 0 OR last_run_interval_seconds > observed_interval_seconds * 1.5 THEN 0
             ELSE 1
           END,
           job_name;

$$;
