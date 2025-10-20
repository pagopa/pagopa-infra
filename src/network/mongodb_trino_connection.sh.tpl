
cat <<'EOF' > define_mongodb.sh
#!/bin/bash
mkdir -p trino-server-477/etc/catalog

IFS="," read -ra  all_mongodb_item <<< "${mongodb_map}"
for mongodb_item in "$${all_mongodb_item[@]}"
do
    IFS="|" read -ra mongodb <<< "$mongodb_item"
    echo "connector.name=mongodb" >> trino-server-477/etc/catalog/$${mongodb[0]}.properties
    echo "mongodb.connection-url=$${mongodb[1]}" >> trino-server-477/etc/catalog/$${mongodb[0]}.properties
done
EOF
chmod +x define_mongodb.sh
./define_mongodb.sh
