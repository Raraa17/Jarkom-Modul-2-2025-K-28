#Eonwe
#pertama: nano /root/.bashrc
apt update 
apt install -y iptables-persistent
apt install -y procps
echo 1 > /proc/sys/net/ipv4/ip_forward
echo "net.ipv4.ip_forward=1" > /etc/sysctl.conf
sysctl -p
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE 


#Other nodes
#nano /root/.bashrc
echo "nameserver 192.168.122.1" > /etc/resolv.conf

#Tes localhost
ping 8.8.8.8

#Tes internet
ping google.com

#Tes IP melalui node lain, misal IP Earendil melalui Erlond
ping 192.225.1.2
