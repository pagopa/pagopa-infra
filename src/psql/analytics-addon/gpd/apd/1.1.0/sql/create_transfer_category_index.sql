CREATE INDEX IF NOT EXISTS idx_mb_cateogry
    ON apd.transfer USING btree
    (category COLLATE pg_catalog."default" ASC NULLS LAST)
    WITH (fillfactor=100, deduplicate_items=True)
    TABLESPACE pg_default;
