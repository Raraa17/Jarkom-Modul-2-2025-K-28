# Trio
# tambah di /etc/bind/named.conf.local
zone "3.225.192.in-addr.arpa" {
    type master;
    file "/etc/bind/zones/db.192.225.3";
    allow-transfer { 192.225.3.4; };
    also-notify { 192.225.3.4; };
};

#nano /etc/bind/zones/db.192.225.3 dan isi:
$TTL 86400
@       IN      SOA     ns1.K28.com. admin.K28.com. (
                        2025102201  ; Serial
                        3600
                        1800
                        604800
                        86400 )
@       IN      NS      ns1.K28.com.
@       IN      NS      ns2.K28.com.
2       IN      PTR     sirion.K28.com.
5       IN      PTR     lindon.K28.com.
6       IN      PTR     vingilot.K28.com.

mkdir -p /etc/bind/zones && chmod 755 /etc/bind/zones

#valmar

zone "3.225.192.in-addr.arpa" {
    type slave;
    file "/var/cache/bind/db.192.225.3";
    masters { 192.225.3.3; };  // Tirion
};

#Tirion
/usr/sbin/named -u bind dan rndc notify 3.225.192.in-addr.arpa

#Valmar
killall named && /usr/sbin/named -u bind

#Uji pada Tirion
dig @192.225.3.3 -x 192.225.3.2 #(tinggal ganti angka IP terakhir: 2,5,6)

#Uji pada Valmar
dig @192.225.3.4 -x 192.225.3.2

#Uji node lain
host sirion #tes untuk lindon dan vingilot juga
