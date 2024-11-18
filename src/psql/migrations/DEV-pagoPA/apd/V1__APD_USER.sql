-- DROP OWNED BY ${db_user};
-- DROP ROLE ${db_user};
CREATE ROLE ${db_user};
-- https://learn.microsoft.com/en-us/answers/questions/170590/azure-postgressql-want-to-create-nosuperuser-role
-- ALTER ROLE ${db_user} WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
ALTER ROLE ${db_user} WITH INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION;

ALTER USER ${db_user} WITH PASSWORD '${db_user_password}';

GRANT USAGE, CREATE ON SCHEMA ${db_schema} TO ${db_user};

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA ${db_schema} TO ${db_user};

GRANT SELECT, UPDATE, USAGE ON ALL SEQUENCES IN SCHEMA ${db_schema} TO ${db_user};
