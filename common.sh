NODEJS() {
  dnf module disable nodejs -y
  dnf module enable nodejs:20 -y
  dnf install nodejs -y
  cp ${component}.service /etc/systemd/system/${component}.service
  cp mongo.repo /etc/yum.repos.d/mongo.repo

  useradd roboshop
  rm -rf /app
  mkdir /app
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}-v3.zip
  cd /app
  unzip /tmp/${component}.zip

  npm install
  systemctl daemon-reload
  systemctl enable ${component}
  systemctl restart ${component}

}

