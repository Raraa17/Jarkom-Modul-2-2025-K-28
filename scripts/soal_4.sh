echo -e '#!/bin/sh\nexit 0' > /usr/sbin/policy-rc.d
chmod +x /usr/sbin/policy-rc.d 
apt update && apt install -y bind9 bind9utils --no-install-recommends
apt install -y systemctl
systemctl start bind9
# cek apakah status sudah running dengan systemctl status bind9

# Tirion pada /root/startup.sh
cp /etc/bind/named.conf.local /etc/bind/named.conf.local.bak
cp /etc/bind/named.conf.options /etc/bind/named.conf.options.bak

nano /etc/bind/named.conf.options
options {
    directory "/var/cache/bind";
    forwarders { 192.168.122.1; };
    dnssec-validation auto;
    listen-on-v6 { none; };
    allow-query { any; };  
};

nano /etc/bind/named.conf.local
zone "K28.com" {
    type master;
    file "/etc/bind/zones/db.K28.com";
    allow-transfer { 192.225.3.4; };  
    also-notify { 192.225.3.4; };     
};

mkdir -p /etc/bind/zones
nano /etc/bind/zones/db.K28.com
\$TTL 86400
@       IN      SOA     ns1.K28.com. admin.K28.com. (
                        2025101301      ; Serial (YYYYMMDDHH)
                        3600            ; Refresh
                        1800            ; Retry
                        604800          ; Expire
                        86400 )         ; Minimum TTL

@       IN      NS      ns1.K28.com.
@       IN      NS      ns2.K28.com.

ns1     IN      A       192.225.3.3
ns2     IN      A       192.225.3.4
@       IN      A       192.225.3.2  ; 

# Start bind9 manual
/usr/sbin/named -u bind

named-checkconf
named-checkzone K28.com /etc/bind/zones/db.K28.com
systemctl restart bind9
systemctl enable bind9

#Valmer
apt update && apt install -y bind9 bind9utils

cp /etc/bind/named.conf.local /etc/bind/named.conf.local.bak
cp /etc/bind/named.conf.options /etc/bind/named.conf.options.bak

# Edit named.conf.options: Sama kayak Tirion
nano /etc/bind/named.conf.options
options {
    directory "/var/cache/bind";
    forwarders { 192.168.122.1; };
    dnssec-validation auto;
    listen-on-v6 { none; };
    allow-query { any; };
};

nano /etc/bind/named.conf.local
zone "K28.com" {
    type slave;
    file "/var/cache/bind/db.K28.com";
    masters { 192.225.3.3; };  // Masternya Tirion
};

/usr/sbin/named -u bind

systemctl restart bind9
systemctl enable bind9

# cek log: journalctl -u bind9

#Node di /root/startup.sh
nano /etc/resolv.conf
nameserver 192.225.3.3  # ns1
nameserver 192.225.3.4  # ns2
nameserver 192.168.122.1

# misal ada proses yang tidak sesuai saat dig coba cek rndc retransfer, kalau gagal coba rndc reload atau cek /etc/bind/
# uji dig @192.225.3.3 K28.com dan @192.225.3.4 K28.com juga
