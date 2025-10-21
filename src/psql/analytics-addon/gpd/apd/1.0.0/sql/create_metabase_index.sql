CREATE INDEX IF NOT EXISTS idx_mb_org_fiscal_code_service_type_status_inserted_publish
    ON apd.payment_position USING btree
    (organization_fiscal_code COLLATE pg_catalog."default" ASC NULLS LAST,
    status COLLATE pg_catalog."default" ASC NULLS LAST,
    inserted_date ASC NULLS LAST,
    publish_date ASC NULLS LAST,
    service_type COLLATE pg_catalog."default" ASC NULLS LAST)
    WITH (fillfactor=100, deduplicate_items=True)
    TABLESPACE pg_default;
