CREATE OR REPLACE FUNCTION online.get_retry_queues()
RETURNS TABLE (
    queue TEXT,
    partition_key TEXT,
    state TEXT,
    items BIGINT,
    oldest_item TIMESTAMP,
    oldest_age_seconds BIGINT,
    max_retry NUMERIC
)
LANGUAGE sql
STABLE
AS $$

    SELECT 'PaInviaRT retry' AS queue,
           id_stazione::TEXT AS partition_key,
           stato::TEXT AS state,
           count(*) AS items,
           min(inserted_timestamp) AS oldest_item,
           floor(extract(epoch FROM (
               timezone('Europe/Rome', now()) - min(inserted_timestamp)
           )))::BIGINT AS oldest_age_seconds,
           max(retry) AS max_retry
      FROM online.retry_pa_invia_rt
     GROUP BY id_stazione, stato
     UNION ALL
    SELECT 'PaSendRT retry' AS queue,
           pa_fiscal_code::TEXT AS partition_key,
           'RETRY_PENDING'::TEXT AS state,
           count(*) AS items,
           min(inserted_timestamp) AS oldest_item,
           floor(extract(epoch FROM (
               timezone('Europe/Rome', now()) - min(inserted_timestamp)
           )))::BIGINT AS oldest_age_seconds,
           max(retry) AS max_retry
      FROM online.position_retry_pa_send_rt
     GROUP BY pa_fiscal_code
     UNION ALL
    SELECT 'SendPaymentResult retry' AS queue,
           psp_id::TEXT AS partition_key,
           'RETRY_PENDING'::TEXT AS state,
           count(*) AS items,
           min(inserted_timestamp) AS oldest_item,
           floor(extract(epoch FROM (
               timezone('Europe/Rome', now()) - min(inserted_timestamp)
           )))::BIGINT AS oldest_age_seconds,
           max(retry) AS max_retry
      FROM online.position_retry_sendpaymentresult
     GROUP BY psp_id
     ORDER BY queue, partition_key, state;

$$
