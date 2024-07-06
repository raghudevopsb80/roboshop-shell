source common.sh
component=redis

PRINT Disbale redis default
dnf module disable redis -y &>>$LOG_FILE
STAT $?

PRINT Enable redis 7
dnf module enable redis:7 -y &>>$LOG_FILE
STAT $?

PRINT Install Redis 7
dnf install redis -y &>>$LOG_FILE
STAT $?

PRINT Update Redis Config
sed -i -e '/^bind/ s/127.0.0.1/0.0.0.0/' -e '/protected-mode/ c protected-mode no' /etc/redis/redis.conf &>>$LOG_FILE
STAT $?

PRINT Start Redis Service
systemctl enable redis &>>$LOG_FILE
systemctl restart redis &>>$LOG_FILE
STAT $?
