ALTER TABLE ${schema}.rendicontazione_sftp_receive_queue rename TO rendicontazione_sftp_receive_queue_old;
ALTER TABLE ${schema}.rendicontazione_sftp_receive_queue_parted rename TO rendicontazione_sftp_receive_queue;
ALTER TABLE ${schema}.rendicontazione_sftp_send_queue rename TO rendicontazione_sftp_send_queue_old;
ALTER TABLE ${schema}.rendicontazione_sftp_send_queue_parted rename TO rendicontazione_sftp_send_queue;
