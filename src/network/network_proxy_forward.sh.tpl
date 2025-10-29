# verify routing: sudo iptables -t nat -v -L PREROUTING -n --line-number
chmod +x ip_fwd.sh

cat <<'EOF' > prerouting_db.sh
#!/bin/bash

#Remove all existing DNAT rules
for line_num in $(sudo iptables --line-numbers --list PREROUTING -t nat | awk '$2=="DNAT" {print $1}')
do
  LINES="$line_num $LINES"
done

# Delete the lines, last to first.
for line in $LINES
do
  sudo iptables -t nat -D PREROUTING $line
done

unset LINES

IFS="," read -ra  all_db_item <<< "${db_map}"

for db_item in "$${all_db_item[@]}"
do
        IFS=";" read -ra db <<< "$db_item"
        sudo ./ip_fwd.sh -i eth0 -f $${db[1]} -a $${db[0]} -b $${db[2]}
done
EOF

chmod +x prerouting_db.sh
./prerouting_db.sh

