source common.sh
component=frontend
app_path=/usr/share/nginx/html


PRINT Disable Nginx default Version
dnf module disable nginx -y  &>>$LOG_FILE
STAT $?

PRINT Enable Nginx 24 Version
dnf module enable nginx:1.24 -y  &>>$LOG_FILE
STAT $?

PRINT Install Nginx
dnf install nginx -y  &>>$LOG_FILE
STAT $?

PRINT Copy nginx config file
cp nginx.conf /etc/nginx/nginx.conf  &>>$LOG_FILE
STAT $?

APP_PREREQ

PRINT Start Nginx Service
systemctl enable nginx  &>>$LOG_FILE
systemctl restart nginx  &>>$LOG_FILE
STAT $?
