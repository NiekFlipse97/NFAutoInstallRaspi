# Repo description
Automatic install script to install Mosquitto MQTT, Zigbee and Domoticz on Raspberry PI 3.

Commands used in script come from:
- https://www.zigbee2mqtt.io/getting_started/running_zigbee2mqtt.html
- https://appcodelabs.com/introduction-to-iot-build-an-mqtt-server-using-raspberry-pi
- https://eye-vision.homeip.net/zigbee2mqtt/

# Installation

1. Clone repository in user home directory.
   `git clone https://github.com/NiekFlipse97/NFAutoInstallRaspi.git`
   - If git is not installed run : `sudo apt install git -y`
2. Run: `chmod +x autoinstall.sh`
3. Run: `bash autoinstall.sh`

# Post install
When raspberry crashes on cold start.
1. Create cronjob: `crontab -e`
2. write in crontab: `@reboot sleep 480 && sudo service domoticz.sh restart`
3. Enable cron service: `sudo systemctl enable cron.service`
4. Start cronjob: `sudo systemctl start cron.service`
