-- PROCEDURE: online.modify_partition()

-- DROP PROCEDURE IF EXISTS online.modify_partition();


CREATE OR REPLACE PROCEDURE ${schema}.modify_partition(
	)
LANGUAGE 'plpgsql'
AS $BODY$

DECLARE

l_partname0 TEXT;
l_partname1 TEXT;
l_partname2 TEXT;
l_partname3 TEXT;
l_partname4 TEXT;
l_partname5 TEXT;
l_partname6 TEXT;
l_partname7 TEXT;
l_part_list0 date;
l_part_list1 date;
l_part_list2 date;
l_part_list3 date;
l_part_list4 date;
l_part_list5 date;
l_part_list6 date;
l_part_list7 date;
l_part_listb0 date;
l_part_listb1 date;
l_part_listb2 date;
l_part_listb3 date;
l_part_listb4 date;
l_part_listb5 date;
l_part_listb6 date;
l_part_listb7 date;
l_partab TEXT;
l_sql0 text;
l_sql1 text;
l_sql2 text;
l_sql3 text;
l_sql4 text;
l_sql5 text;
l_sql6 text;
l_sql7 text;
l_exist text;
l_var_exist integer;

    tab_cursor CURSOR FOR
        SELECT lower(tabella) as tabella, lower(schema) as schema
        FROM ${schema}.TAB_PART;
    tab_record TEXT;
    tab_schema TEXT;

BEGIN

 OPEN tab_cursor;



      LOOP
        FETCH NEXT FROM tab_cursor INTO tab_record, tab_schema;
        EXIT WHEN NOT FOUND;



------------------------------------------------------------------------------------------------------

  		l_part_list0 = date_trunc('day', CURRENT_DATE-1500)::date;
		l_part_listb0 = date_trunc('day', CURRENT_DATE+1)::date;
  		l_partname0 := tab_record||'_PMINVALUE';


    IF NOT EXISTS
	  (SELECT *
		 FROM   information_schema.tables
		   WHERE  table_name=l_partname0 and table_schema=tab_schema)
	   THEN

		  l_sql0 := format('CREATE TABLE  %I.%I PARTITION OF %I.%I FOR VALUES FROM (%L) TO (%L)', tab_schema, l_partname0,  tab_schema, tab_record, l_part_list0, l_part_listb0);
		  execute l_sql0;
  	 END IF;


------------------------------------------------------------------------------------------------------

  		l_part_list1 = date_trunc('day', CURRENT_DATE+1)::date;
		l_part_listb1 = date_trunc('day', CURRENT_DATE+2)::date;
  		l_partname1 := tab_record||'_P'||to_char(CURRENT_DATE+1, 'yyyymmdd');


   IF NOT EXISTS
	  (SELECT *
		 FROM   information_schema.tables
		   WHERE  table_name=l_partname1 and table_schema=tab_schema)
	   THEN

		  l_sql1 := format('CREATE TABLE  %I.%I PARTITION OF %I.%I FOR VALUES FROM (%L) TO (%L)',  tab_schema, l_partname1,  tab_schema, tab_record, l_part_list1, l_part_listb1);
		  execute l_sql1;
  	 END IF;
------------------------------------------------------------------------------------------------------

  		l_part_list2 = date_trunc('day', CURRENT_DATE+2)::date;
		l_part_listb2 = date_trunc('day', CURRENT_DATE+3)::date;
  		l_partname2 := tab_record||'_P'||to_char(CURRENT_DATE+2, 'yyyymmdd');


   IF NOT EXISTS
	  (SELECT *
		 FROM   information_schema.tables
		   WHERE  table_name=l_partname2 and table_schema=tab_schema)
	   THEN

		  l_sql2 := format('CREATE TABLE  %I.%I PARTITION OF %I.%I FOR VALUES FROM (%L) TO (%L)',  tab_schema, l_partname2,  tab_schema, tab_record, l_part_list2, l_part_listb2);
		  execute l_sql2;
  	 END IF;

------------------------------------------------------------------------------------------------------

  		l_part_list3 = date_trunc('day', CURRENT_DATE+3)::date;
		l_part_listb3 = date_trunc('day', CURRENT_DATE+4)::date;
  		l_partname3 := tab_record||'_P'||to_char(CURRENT_DATE+3, 'yyyymmdd');

  IF NOT EXISTS
	  (SELECT *
		 FROM   information_schema.tables
		   WHERE  table_name=l_partname3 and table_schema=tab_schema)
	   THEN

		  l_sql3 := format('CREATE TABLE  %I.%I PARTITION OF %I.%I FOR VALUES FROM (%L) TO (%L)',   tab_schema, l_partname3,  tab_schema, tab_record, l_part_list3, l_part_listb3);
		  execute l_sql3;
  	 END IF;

------------------------------------------------------------------------------------------------------

  		l_part_list4 = date_trunc('day', CURRENT_DATE+4)::date;
		l_part_listb4 = date_trunc('day', CURRENT_DATE+5)::date;
  		l_partname4 := tab_record||'_P'||to_char(CURRENT_DATE+4, 'yyyymmdd');

  IF NOT EXISTS
	  (SELECT *
		 FROM   information_schema.tables
		   WHERE  table_name=l_partname4 and table_schema=tab_schema)
	   THEN

		  l_sql4 := format('CREATE TABLE  %I.%I PARTITION OF %I.%I FOR VALUES FROM (%L) TO (%L)',   tab_schema, l_partname4,  tab_schema, tab_record, l_part_list4, l_part_listb4);
		  execute l_sql4;
  	 END IF;

------------------------------------------------------------------------------------------------------

  		l_part_list5 = date_trunc('day', CURRENT_DATE+5)::date;
		l_part_listb5 = date_trunc('day', CURRENT_DATE+6)::date;
  		l_partname5 := tab_record||'_P'||to_char(CURRENT_DATE+5, 'yyyymmdd');

  IF NOT EXISTS
	  (SELECT *
		 FROM   information_schema.tables
		   WHERE  table_name=l_partname5 and table_schema=tab_schema)
	   THEN

		  l_sql5 := format('CREATE TABLE  %I.%I PARTITION OF %I.%I FOR VALUES FROM (%L) TO (%L)',   tab_schema, l_partname5, tab_schema, tab_record, l_part_list5, l_part_listb5);
		  execute l_sql5;
  	 END IF;

------------------------------------------------------------------------------------------------------

  		l_part_list6 = date_trunc('day', CURRENT_DATE+6)::date;
		l_part_listb6 = date_trunc('day', CURRENT_DATE+7)::date;
  		l_partname6 := tab_record||'_P'||to_char(CURRENT_DATE+6, 'yyyymmdd');

  IF NOT EXISTS
	  (SELECT *
		 FROM   information_schema.tables
		   WHERE  table_name=l_partname6 and table_schema=tab_schema)
	   THEN

		  l_sql6 := format('CREATE TABLE  %I.%I PARTITION OF %I.%I FOR VALUES FROM (%L) TO (%L)',  tab_schema, l_partname6, tab_schema, tab_record, l_part_list6, l_part_listb6);
		  execute l_sql6;
  	 END IF;

------------------------------------------------------------------------------------------------------

  		l_part_list7 = date_trunc('day', CURRENT_DATE+7)::date;
		l_part_listb7 = date_trunc('day', CURRENT_DATE+8)::date;
  		l_partname7 := tab_record||'_P'||to_char(CURRENT_DATE+7, 'yyyymmdd');

  IF NOT EXISTS
	  (SELECT *
		 FROM   information_schema.tables
		   WHERE  table_name=l_partname7 and table_schema=tab_schema)
	   THEN

		  l_sql7 := format('CREATE TABLE  %I.%I PARTITION OF %I.%I FOR VALUES FROM (%L) TO (%L)',   tab_schema, l_partname7,  tab_schema, tab_record, l_part_list7, l_part_listb7);
		  execute l_sql7;
  	 END IF;

---------------------------------------------------------------------------------------------------------------------



    END LOOP;

    CLOSE tab_cursor;

END;
$BODY$;

ALTER PROCEDURE ${schema}.modify_partition()
    OWNER TO ${schema};
