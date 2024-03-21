alter table ${schema}.rendicontazione_sftp_receive_queue rename to rendicontazione_sftp_receive_queue_old;
alter table ${schema}.rendicontazione_sftp_receive_queue_parted rename to rendicontazione_sftp_receive_queue;

alter table ${schema}.rendicontazione_sftp_send_queue rename to rendicontazione_sftp_send_queue_old;
alter table ${schema}.rendicontazione_sftp_send_queue_parted rename to rendicontazione_sftp_send_queue;
