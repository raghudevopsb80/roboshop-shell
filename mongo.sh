cp mongo.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-org -y
# Update config file
systemctl enable mongod
systemctl restart mongod
