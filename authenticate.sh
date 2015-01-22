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
    #TODO: Check for credentials
  else
    msg "Logged in"
  fi
  sleep 10
  login
}

echo -n "Username: "
read username
echo -n "Password: "
read -s password
echo
login
