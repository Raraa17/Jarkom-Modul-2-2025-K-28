apt update && apt install -y bind9 bind9utils

cp /etc/bind/named.conf.local /etc/bind/named.conf.local.bak
cp /etc/bind/named.conf.options /etc/bind/named.conf.options.bak

cat << EOF > /etc/bind/named.conf.options
options {
    directory "/var/cache/bind";
    forwarders { 192.168.122.1; };
    dnssec-validation auto;
    listen-on-v6 { none; };
    allow-query { any; };  // Allow query dari anywhere, adjust kalau mau restrict
};
EOF

cat << EOF >> /etc/bind/named.conf.local
zone "K28.com" {
    type master;
    file "/etc/bind/zones/db.K28.com";
    allow-transfer { 192.225.4.2; };  // Allow ke Valmar
    also-notify { 192.225.4.2; };     // Notify ke Valmar
};
EOF

mkdir -p /etc/bind/zones
cat << EOF > /etc/bind/zones/db.K28.com
\$TTL 86400
@       IN      SOA     ns1.K28.com. admin.K28.com. (
                        2025101301      ; Serial (YYYYMMDDHH)
                        3600            ; Refresh
                        1800            ; Retry
                        604800          ; Expire
                        86400 )         ; Minimum TTL

@       IN      NS      ns1.K28.com.
@       IN      NS      ns2.K28.com.

ns1     IN      A       192.225.4.1
ns2     IN      A       192.225.4.2
@       IN      A       192.225.4.3  ; Apex ke Sirion
EOF

named-checkconf
named-checkzone K28.com /etc/bind/zones/db.K28.com
systemctl restart bind9
systemctl enable bind9

#Valmer
apt update && apt install -y bind9 bind9utils

cp /etc/bind/named.conf.local /etc/bind/named.conf.local.bak
cp /etc/bind/named.conf.options /etc/bind/named.conf.options.bak

# Edit named.conf.options: Sama kayak Tirion, tapi tanpa forwarders spesifik kalau mau, tapi biar konsisten
cat << EOF > /etc/bind/named.conf.options
options {
    directory "/var/cache/bind";
    forwarders { 192.168.122.1; };
    dnssec-validation auto;
    listen-on-v6 { none; };
    allow-query { any; };
};
EOF

cat << EOF >> /etc/bind/named.conf.local
zone "K28.com" {
    type slave;
    file "/var/cache/bind/db.K28.com";
    masters { 192.225.4.2; };  // Master adalah Tirion
};
EOF

systemctl restart bind9
systemctl enable bind9

# cek log: journalctl -u bind9
