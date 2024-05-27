GRANT ALL ON TABLE ${schema}.rendicontazione_sftp_receive_queue TO ${schema};
GRANT ALL ON TABLE ${schema}.rendicontazione_sftp_send_queue TO ${schema};
-------------------------------------------------------------------
ALTER TABLE IF EXISTS ${schema}.rendicontazione_sftp_receive_queue OWNER to ${schema};
ALTER TABLE IF EXISTS ${schema}.rendicontazione_sftp_send_queue OWNER to ${schema};
-------------------------------------------------------------------
