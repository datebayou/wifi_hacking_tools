echo 1 > /proc/sys/net/ipv4/ip_forward

iptables --flush
iptables -A FORWARD -i eth0 -o at0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i at0 -o eth0 -j ACCEPT
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -t nat -A PREROUTING -i at0 -p tcp -m tcp --dport 80 -j REDIRECT --to-ports 8080
iptables -t nat -A PREROUTING -i at0 -p tcp -m tcp --dport 443 -j REDIRECT --to-ports 8080
