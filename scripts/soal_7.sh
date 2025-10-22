#Tirion di /etc/bind/zones/db.K28.com
www        IN      CNAME   sirion.K01.com.
static     IN      CNAME   lindon.K01.com.
app        IN      CNAME   vingilot.K01.com.

dig @192.225.3.3 www.K28.com

#Valmar
killall named
/usr/sbin/named -u bind
dig @192.225.3.4 www.K28.com
dig @192.225.3.4 static.K28.com
dig @192.225.3.4 app.K28.com

#uji dig serupa pada node lain
