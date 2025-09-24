chmod +x ip_fwd.sh
sudo ./ip_fwd.sh -i eth0 -f 5432 -a crusc8-db.${env}.internal.postgresql.pagopa.it -b 5432 
sudo ./ip_fwd.sh -i eth0 -f 5433 -a gpd-db.${env}.internal.postgresql.pagopa.it -b 5432 