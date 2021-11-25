CREATE TABLE payment_paypal(
  id                   SERIAL PRIMARY KEY,
  user_paypal_id       integer,
  fee                  numeric not null,
  importo              numeric not null,
  id_trs_appio         varchar(128) not null unique,
  id_trs_paypal        varchar(128) unique,
  esito                varchar(5) not null,
  err_cod              varchar(128),
  CONSTRAINT fk_user_paypal FOREIGN KEY(user_paypal_id) REFERENCES user_paypal(id)
);
CREATE INDEX payment_paypal_user_paypal_id_idx ON payment_paypal (user_paypal_id);

