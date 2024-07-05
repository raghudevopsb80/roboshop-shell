source common.sh

cp user.service /etc/systemd/system/user.service

NODEJS

useradd roboshop
rm -rf /app
mkdir /app
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user-v3.zip
cd /app
unzip /tmp/user.zip
cd /app
npm install
systemctl daemon-reload
systemctl enable user
systemctl restart user
