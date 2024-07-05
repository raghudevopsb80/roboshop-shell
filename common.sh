NODEJS() {
  dnf module disable nodejs -y
  dnf module enable nodejs:20 -y
  dnf install nodejs -y
}

