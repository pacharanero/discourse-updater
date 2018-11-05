#!/bin/bash
# usage: ssh <node> 'bash -s' < /home/marcus/marcusbaw@gmail.com/notes/discourse/discourse-on-remote-update-script.sh
#
#
# === EXECUTED ON REMOTE MACHINE === #
# TODO: if anything in here errors, needs to close ssh connection

export DEBIAN_FRONTEND="noninteractive"

echo -e "\e[34m sudo su \e[39m"
sleep 2
sudo su

echo -e "\e[34m apt-get update \e[39m"
sleep 2
apt-get update -qq

echo -e "\e[34m apt-get dist-upgrade \e[39m"
sleep 2
DEBIAN_FRONTEND="noninteractive" apt-get dist-upgrade -y

echo -e "\e[34m apt autoremove and apt-get autoclean \e[39m"
sleep 2
apt-get autoremove -y
apt-get autoclean -y

echo -e "\e[34m cd /var/discourse \e[39m"
sleep 2
cd /var/discourse

echo -e "\e[34m upgrading discourse \e[39m"
echo -e "\e[34m git pull \e[39m"
sleep 2
git pull

echo -e "\e[34m /launcher rebuild app \e[39m"
sleep 2
./launcher rebuild app

echo -e "\e[34m /launcher cleanup \e[39m"
sleep 2
./launcher cleanup

echo -e "\e[34m reboot now \e[39m"
sleep 2
sudo reboot now

# === END OF REMOTE MACHINE EXECUTED COMMANDS === #


# === EXECUTED ON LOCAL MACHINE === #
# TODO: log everything in a text file
# TODO: email the log to sysadmin?
# TODO: post success report to the Changelog
# TODO: check for HTTP 200(OK) response
=======

# * log everything in a text file
# * or email the log to sysadmin?
# * and post success report to the Changelog
# * check for 200(OK)# *
