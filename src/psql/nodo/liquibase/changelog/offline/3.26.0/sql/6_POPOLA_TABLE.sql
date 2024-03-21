INSERT INTO ${schema}.rendicontazione_sftp_receive_queue
SELECT *
FROM   ${schema}.rendicontazione_sftp_receive_queue_old;

INSERT INTO ${schema}.rendicontazione_sftp_send_queue
SELECT *
FROM   ${schema}.rendicontazione_sftp_send_queue_old;
