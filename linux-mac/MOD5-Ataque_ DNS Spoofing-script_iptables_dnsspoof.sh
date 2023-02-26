IP=$1

echo 1 > /proc/sys/net/ipv4/ip_forward

iptables --flush

iptables -t nat -A PREROUTING -i eth0 -p udp --dport 53 -j DNAT --to $IP:53

iptables -t nat -A PREROUTING -p udp --dport 53 -j DNAT --to-destination $IP:53
