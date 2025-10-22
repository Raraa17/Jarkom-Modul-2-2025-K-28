#Tirion
rndc notify K28.com

#Valmar
killall named # kalau belum bisa, apt install psmisc -y
/usr/sbin/named -u bind

dig @192.225.3.4 K28.com SOA

