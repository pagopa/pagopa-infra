delete from payment_paypal;
delete from pp_onboarding_back;
delete from user_paypal;
delete from pp_paypal_management;

ALTER TABLE pp_onboarding_back ADD client_id integer NOT NULL;
ALTER TABLE pp_onboarding_back ADD CONSTRAINT fk_pob_client FOREIGN KEY(client_id) REFERENCES client(id);

ALTER TABLE user_paypal ADD client_id integer NOT NULL;
ALTER TABLE user_paypal ADD CONSTRAINT fk_up_client FOREIGN KEY(client_id) REFERENCES client(id);

ALTER TABLE pp_paypal_management ADD client_id integer NOT NULL;
ALTER TABLE pp_paypal_management ADD CONSTRAINT fk_ppm_client FOREIGN KEY(client_id) REFERENCES client(id);

DROP INDEX user_paypal_id_appio_contract_number_idx;
DROP INDEX user_paypal_id_appio_idx;
DROP INDEX pp_onboarding_back_id_appio_idx;

CREATE UNIQUE INDEX ON user_paypal(id_appio, client_id) WHERE NOT DELETED;
CREATE UNIQUE INDEX ON user_paypal(id_appio, client_id, contract_number) WHERE NOT DELETED;
CREATE UNIQUE INDEX ON pp_onboarding_back(id_appio, client_id) WHERE NOT used;

ALTER TABLE client ADD base_url varchar(256);
ALTER TABLE client ADD CONSTRAINT client_un UNIQUE (client_name);

UPDATE client SET base_url='http://localhost:8080' WHERE client_name='local';
INSERT INTO config ( property_key, property_value) VALUES('PAYPAL_PSP_FALLBACK_PATH', '/pp-restapi-CD/v3/webview/paypal/fallback');
