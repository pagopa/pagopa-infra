ALTER TABLE ${schema}.carrello_rpt rename TO carrello_rpt_old;
ALTER TABLE ${schema}.carrello_rpt_parted rename TO carrello_rpt;

ALTER TABLE ${schema}.redirect_my_bank rename TO redirect_my_bank_old;
ALTER TABLE ${schema}.redirect_my_bank_parted rename TO redirect_my_bank;

ALTER TABLE ${schema}.rpt rename TO rpt_old;
ALTER TABLE ${schema}.rpt_parted rename TO rpt;
