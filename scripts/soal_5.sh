#Set hostname pada semua node kecuali ns1 dan ns2, berikut contohnya pada Earendil
hostnamectl set-hostname earendil
echo "earendil" > /etc/hostname
nano /etc/hosts
127.0.0.1 localhost
127.0.1.1 earendil

hostname earendil

# /usr/sbin/named -u bind untuk reload setiap config diubah

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

/usr/sbin/named -u bind
