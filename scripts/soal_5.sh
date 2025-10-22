#Earendil
hostnamectl set-hostname earendil
echo "earendil" > /etc/hostname
cat << EOF > /etc/hosts
127.0.0.1 localhost
127.0.1.1 earendil
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
EOF
reboot  

#Tirion
eonwe       IN      A       192.225.1.1  
earendil    IN      A       192.225.1.2
elwing      IN      A       192.225.1.3
cirdan      IN      A       192.225.2.2
elrond      IN      A       192.225.2.3
maglor      IN      A       192.225.2.4
sirion      IN      A       192.225.3.2
lindon      IN      A       192.225.3.4
vingilot    IN      A       192.225.3.5

rndc reload