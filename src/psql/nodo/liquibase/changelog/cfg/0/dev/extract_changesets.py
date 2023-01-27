#!/usr/bin/env python3

import lxml.etree
# xmlstr is your xml in a string
root = lxml.etree.parse('db.changelog-all-data.xml')
results = root.xpath('/databaseChangeLog/changeSet')
for idx,r in enumerate(results):
  id=r.attrib['id']
  table=r.find('insert').attrib['tableName']
  f = open(f"data/{idx}-changelog-{table}.xml", "a")
  f.write('<databaseChangeLog xmlns="http://www.liquibase.org/xml/ns/dbchangelog" xmlns:ext="http://www.liquibase.org/xml/ns/dbchangelog-ext" xmlns:pro="http://www.liquibase.org/xml/ns/pro" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.liquibase.org/xml/ns/dbchangelog-ext http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-ext.xsd http://www.liquibase.org/xml/ns/pro http://www.liquibase.org/xml/ns/pro/liquibase-pro-latest.xsd http://www.liquibase.org/xml/ns/dbchangelog http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-latest.xsd">')
  f.write(lxml.etree.tostring(r).decode("utf-8") )
  f.write('</databaseChangeLog>')
  f.close()
