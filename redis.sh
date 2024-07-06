
PRINT Disbale redis default
dnf module disable redis -y
STAT $?

PRINT Enable redis 7
dnf module enable redis:7 -y
STAT $?

PRINT Install Redis 7
dnf install redis -y
STAT $?

PRINT Update Redis Config
sed -i -e '/^bind/ s/127.0.0.1/0.0.0.0/' -e '/protected-mode/ c protected-mode no' /etc/redis/redis.conf
STAT $?

PRINT Start Redis Service
systemctl enable redis
systemctl restart redis
STAT $?
