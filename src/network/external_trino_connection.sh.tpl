
cat <<'EOF' > define_external.sh
#!/bin/bash
mkdir -p trino-server-477/etc/catalog

%{ for db_key, db_value in external_map }
  echo "connector.name=${db_value.connector_name}" >> trino-server-477/etc/catalog/${db_key}.properties
  echo "connection-url=${db_value.url}" >> trino-server-477/etc/catalog/${db_key}.properties
  echo "connection-user=${db_value.user_name}" >> trino-server-477/etc/catalog/${db_key}.properties
  echo "connection-password=${db_value.password}" >> trino-server-477/etc/catalog/${db_key}.properties
  %{for param_name, param_value in db_value.params}
  echo "${param_name}=${param_value}" >> trino-server-477/etc/catalog/${db_key}.properties
  %{endfor ~}
%{endfor ~}

EOF
chmod +x define_external.sh
./define_external.sh
