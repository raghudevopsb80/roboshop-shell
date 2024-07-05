LOG_FILE=/tmp/roboshop.log
rm -f $LOG_FILE

PRINT() {
  echo &>>$LOG_FILE
  echo &>>$LOG_FILE
  echo " ####################################### $* ########################################" &>>$LOG_FILE
  echo $*
}

NODEJS() {
  PRINT Disable NodeJS Default Version
  dnf module disable nodejs -y &>>$LOG_FILE

  PRINT Enable NodejS 20 Module
  dnf module enable nodejs:20 -y &>>$LOG_FILE

  PRINT Install Nodejs
  dnf install nodejs -y &>>$LOG_FILE

  PRINT Copy Service file
  cp ${component}.service /etc/systemd/system/${component}.service &>>$LOG_FILE

  PRINT COpy MongoDB repo file
  cp mongo.repo /etc/yum.repos.d/mongo.repo &>>$LOG_FILE

  PRINT Adding Application User
  useradd roboshop &>>$LOG_FILE

  PRINT Cleaning Old Content
  rm -rf /app &>>$LOG_FILE

  PRINT Create App directory
  mkdir /app &>>$LOG_FILE

  PRINT Download App Content
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}-v3.zip &>>$LOG_FILE

  cd /app
  PRINT Extract App Content
  unzip /tmp/${component}.zip &>>$LOG_FILE

  PRINT Download NodeJS Dependencies
  npm install &>>$LOG_FILE

  PRINT Start Service
  systemctl daemon-reload &>>$LOG_FILE
  systemctl enable ${component} &>>$LOG_FILE
  systemctl restart ${component} &>>$LOG_FILE

}

