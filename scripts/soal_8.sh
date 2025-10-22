# Trion
zone "3.225.192.in-addr.arpa" {
    type master;
    file "/etc/bind/zones/db.192.225.3";
    allow-transfer { 192.225.4.2; };
    also-notify { 192.225.4.2; };
};