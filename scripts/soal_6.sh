#Tirion
dig @localhost SOA K28.com  
journalctl -u bind9 | grep notify  

#Valmar
dig @localhost SOA K28.com  
journalctl -u bind9 | grep transfer  
ls /var/cache/bind/db.K28.com  

