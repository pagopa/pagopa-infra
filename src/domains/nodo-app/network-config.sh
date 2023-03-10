sudo sysctl net.ipv4.ip_forward=1
sudo firewall-cmd --permanent --direct --passthrough ipv4 -t nat -I POSTROUTING -o eth0 -j MASQUERADE
sudo firewall-cmd --permanent --direct --passthrough ipv4 -I FORWARD -i eth1 -j ACCEPT
sudo firewall-cmd --permanent --direct --passthrough ipv4 -A FORWARD -i eth0 -o eth1 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo firewall-cmd --permanent --direct --passthrough ipv4 -t nat -I POSTROUTING -o eth1 -j MASQUERADE
sudo firewall-cmd --permanent --direct --passthrough ipv4 -I FORWARD -i eth0 -j ACCEPT
sudo firewall-cmd --permanent --direct --passthrough ipv4 -A FORWARD -i eth1 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo firewall-cmd --reload