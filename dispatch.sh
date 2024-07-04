cp dispatch.service /etc/systemd/system/dispatch.service
dnf install golang -y
useradd roboshop
rm -rf /app
mkdir /app
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip
cd /app
unzip /tmp/dispatch.zip
cd /app
go mod init dispatch
go get
go build
systemctl daemon-reload
systemctl enable dispatch
systemctl start dispatch
