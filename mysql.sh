source common.sh
component=mysql

PRINT Install MySQL Server
dnf install mysql-server -y &>>$LOG_FILE
STAT $?

PRINT Start MySQL Service
systemctl enable mysqld &>>$LOG_FILE
systemctl restart mysqld &>>$LOG_FILE
STAT $?

PRINT Setup MySQL Root Password
mysql_secure_installation --set-root-pass RoboShop@1 &>>$LOG_FILE
STAT $?


