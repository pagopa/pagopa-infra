
alter table ${schema}.carrello_rpt rename to carrello_rpt_old;
alter table ${schema}.carrello_rpt_parted rename to carrello_rpt;

alter table ${schema}.redirect_my_bank rename to redirect_my_bank_old;
alter table ${schema}.redirect_my_bank_parted rename to redirect_my_bank;

alter table ${schema}.rpt rename to rpt_old;
alter table ${schema}.rpt_parted rename to rpt;
