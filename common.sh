LOG_FILE=/tmp/roboshop.log
rm -f $LOG_FILE

PRINT() {
  echo &>>$LOG_FILE
  echo &>>$LOG_FILE
  echo " ####################################### $* ########################################" &>>$LOG_FILE
  echo $*
}

STAT() {
  if [ $1 -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE\e[0m"
    echo
    echo "Refer the log file for more information : File Path : ${LOG_FILE}"
    exit $1
  fi
}

NODEJS() {
  PRINT Disable NodeJS Default Version
  dnf module disable nodejs -y &>>$LOG_FILE
  STAT $?

  PRINT Enable NodejS 20 Module
  dnf module enable nodejs:20 -y &>>$LOG_FILE
  STAT $?

  PRINT Install Nodejs
  dnf install nodejs -y &>>$LOG_FILE
  STAT $?

  PRINT Copy Service file
  cp ${component}.service /etc/systemd/system/${component}.service &>>$LOG_FILE
  STAT $?

  PRINT COpy MongoDB repo file
  cp mongo.repo /etc/yum.repos.d/mongo.repo &>>$LOG_FILE
  STAT $?

  PRINT Adding Application User
  id roboshop &>>$LOG_FILE
  if [ $? -ne 0 ]; then
    useradd roboshop &>>$LOG_FILE
  fi
  STAT $?

  PRINT Cleaning Old Content
  rm -rf /app &>>$LOG_FILE
  STAT $?

  PRINT Create App directory
  mkdir /app &>>$LOG_FILE
  STAT $?

  PRINT Download App Content
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}-v3.zip &>>$LOG_FILE
  STAT $?

  cd /app
  PRINT Extract App Content
  unzip /tmp/${component}.zip &>>$LOG_FILE
  STAT $?

  PRINT Download NodeJS Dependencies
  npm install &>>$LOG_FILE
  STAT $?

  PRINT Start Service
  systemctl daemon-reload &>>$LOG_FILE
  systemctl enable ${component} &>>$LOG_FILE
  systemctl restart ${component} &>>$LOG_FILE
  STAT $?

}

