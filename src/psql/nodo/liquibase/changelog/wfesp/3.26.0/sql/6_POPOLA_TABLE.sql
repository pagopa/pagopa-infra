INSERT INTO ${schema}.carrello_rpt
SELECT *
FROM   ${schema}.carrello_rpt_old;

INSERT INTO ${schema}.redirect_my_bank
SELECT *
FROM   ${schema}.redirect_my_bank_old;

INSERT INTO ${schema}.rpt
SELECT *
FROM   ${schema}.rpt_old;
