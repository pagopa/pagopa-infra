CREATE EXTENSION dblink_fdw;
CREATE SERVER connSVInodo FOREIGN DATA WRAPPER dblink_fdw OPTIONS (host '${nodo-db-host}', port '${nodo-db-port}', dbname 'nodo', sslmode 'require');
CREATE USER MAPPING FOR partition SERVER connSVInodo OPTIONS (user 'partition',password '${partition-password}');
GRANT USAGE ON FOREIGN SERVER connSVInodo TO partition;

