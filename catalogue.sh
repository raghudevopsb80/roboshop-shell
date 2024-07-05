source common.sh
component=catalogue
NODEJS

echo Install MongoDB Client
dnf install mongodb-mongosh -y &>$LOG_FILE

echo Load Master Data
mongosh --host mongo.dev.rdevopsb80.online </app/db/master-data.js &>$LOG_FILE
