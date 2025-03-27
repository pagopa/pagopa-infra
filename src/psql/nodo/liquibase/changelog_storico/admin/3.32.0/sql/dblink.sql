CREATE EXTENSION IF NOT EXISTS dblink;
CREATE SERVER connSVInodo FOREIGN DATA WRAPPER dblink_fdw OPTIONS (host '${nodo-db-host}', port '${nodo-db-port}', dbname 'nodo', sslmode 'require');
CREATE USER MAPPING FOR partition SERVER connSVInodo OPTIONS (user 'partition',password '${partition-password}');
CREATE USER MAPPING FOR azureuser SERVER connSVInodo OPTIONS (user 'azureuser',password '${admin-password}');
GRANT USAGE ON FOREIGN SERVER connSVInodo TO partition;
GRANT USAGE ON FOREIGN SERVER connSVInodo TO azureuser;

