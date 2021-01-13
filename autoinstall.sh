#!/bin/bash
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
CYAN=$(tput setaf 6)
RESET=$(tput sgr0)

#Update Apt
sudo apt update -y
sudo apt upgrade -y

echo "[ ${CYAN}INFO${RESET} ] - Update and upgrade done."

#Install MQTT
echo "[ ${CYAN}INFO${RESET} ] - Installing mosquitto."
sudo apt install mosquitto mosquitto-clients -y

echo "[ ${CYAN}INFO${RESET} ] - Enable mosquito daemon service."
sudo systemctl enable mosquitto

#Install Zigbee
echo "[ ${CYAN}INFO${RESET} ] - ."
sudo curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -

echo "[ ${CYAN}INFO${RESET} ] - Install packages."
sudo apt install nodejs npm git make g++ gcc python3-dev -y

NODE_VERSION=$(node -v)
NPM_VERSION=$(npm -v)

if echo "${NODE_VERSION}" | grep "^v[0-9][0-9]\." && echo "${NPM_VERSION}" | grep "^[0-9]";
then
	echo "[ ${GREEN}OK${RESET} ] - Node installed."
	echo "[ ${GREEN}OK${RESET} ] - Npm installed."
else
	echo "[ ${RED}ERROR${RESET} ] - Node or npm not installed."
fi

#Clone zigbee2mqtt repository
echo "[ ${CYAN}INFO${RESET} ] - Clone zigbee2mqtt repository."
sudo git clone https://github.com/Koenkk/zigbee2mqtt.git /opt/zigbee2mqtt

echo "[ ${CYAN}INFO${RESET} ] - Change /opt/zigbee2mqtt ownership"
sudo chown -R pi:pi /opt/zigbee2mqtt

#Install dependencies (as user "pi")
cd /opt/zigbee2mqtt
npm ci --production

echo "[ ${CYAN}INFO${RESET} ] - Check if configuration.yaml contains network_key."
if ! echo "$(cat /opt/zigbee2mqtt/data/configuration.yaml)" | grep "network_key:";
then
	echo "\n\nadvanced:\n  ntwork_key: GENERATE" >> /opt/zigbee2mqtt/data/configuration.yaml
	if echo "$(cat /opt/zigbee2mqtt/data/configuration.yaml)" | grep "network_key:";
	then
		echo "[ ${GREEN}OK${RESET} ] - Successfully added network_key to configuration.yaml."
	else
		echo "[ ${RED}ERROR${RESET} ] - Unable to write configuration file."
	fi
else
	echo "[ ${CYAN}INFO${RESET} ] - Configuration file contains network_key."
fi






