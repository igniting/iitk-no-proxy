#!/bin/bash

CONNSTATUS_URL="https://authenticate.iitk.ac.in/netaccess/connstatus.html"
LOGIN_URL="https://authenticate.iitk.ac.in/netaccess/loginuser.html"
OPTS="-k -s"

msg() {
  echo "-- $(date +%T) -- $1"
}

login() {
  status_str=$(curl ${OPTS} ${CONNSTATUS_URL})
  if [[ $status_str == *"Log In Now"* ]]
  then
    msg "Trying to log in"
    status_str=$(curl ${OPTS} ${LOGIN_URL} --data "username=${username}&password=${password}")
    if [[ $status_str == *"Credentials Rejected"* ]]
    then
      msg "Invalid credentials"
      exit 1
    elif [[ $status_str == *"Session Expired"* ]]
    then
      msg "Session Expired, creating new session."
      sess_str=$(curl ${OPTS} ${CONNSTATUS_URL} --data "login=Log+In+Now")
    fi
  else
    msg "Logged in"
  fi
  sleep 10
}

echo -n "Username: "
read username
echo -n "Password: "
read -s password
echo

while [[ true ]]; do
  login
done
