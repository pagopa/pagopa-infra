-------------------------------------------------------------------
GRANT ALL ON TABLE ${schema}.carrello_rpt TO ${schema};
GRANT ALL ON TABLE ${schema}.redirect_my_bank TO ${schema};
GRANT ALL ON TABLE ${schema}.rpt TO ${schema};
-------------------------------------------------------------------
ALTER TABLE IF EXISTS ${schema}.carrello_rpt OWNER to ${schema};
ALTER TABLE IF EXISTS ${schema}.redirect_my_bank OWNER to ${schema};
ALTER TABLE IF EXISTS ${schema}.rpt OWNER to ${schema};
-------------------------------------------------------------------
