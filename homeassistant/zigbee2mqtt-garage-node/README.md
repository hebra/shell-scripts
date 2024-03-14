# Zugbee

The purpose of this quick tutorial is to allow extending a ZigBee network into blocked or far-away areas (like a tin shed or garage) and integrate it with HomeAssistant to run automations and to monitor conditions.

## Precondition
- a fully configured HomeAssistant instance

## Hardware
- Raspberry Pi Zero W (or better of course)
- Dresden Elektronik ZigBee gateway [ConBee II] or other Linux-compatible ZigBee gateways

## Software (Zero W)
- RaspberryPi OS Legacy (Bullseye), upgraded to Bookworm
- SSH server enabled
- WiFi connected

## Set up MQTT on the HomeAssistant main node
- Go to Settings -> Add-ons -> click Add-on Store button in the bottom right
- Search for 'Mosquitto' and install *Mosquitto Broker*
- In the Add-on details enable Watchdog and Auto Update
- Still in the details select the Settings tab
- In the *Logins* section add a new entry for the user to be created and used for the remote MQTT client (the zigbee2mqtt server)

```yaml
- username: mqtt
  password: mqttpassword
```
- Note down the *Normal MQTT Port* (default is 1883)
- Back on the Info tab Start the service

## Free up some more memory (Zero W)
As we don't need Bluetooth or ALSA (Sound) features, let's disable the services to free up some more memory.

```sh
sudo systemctl disable alsa-restore.service
sudo  systemctl disable bluetooth.service
sudo systemctl disable bthelper@hci0.service

```

## Install Node
Unfortunately Zigbee2MQTT is written in Typescript and runs on Node - quite a heavy requirement for a tiny Zero.

```sh
# Install Node and NPM (and like 460 additional packages)
sudo apt install nodejs npm git
```
## Install zigbee2mqtt
Create a new user for the zigbee2mqtt service:
```sh
sudo useradd -d /opt/zigbee2mqtt -G dialout -m -r -s /bin/bash -U zigbee2mqtt
```

Switch context to the newly created user and clone the Zigbee2MQTT GIT repository:
```sh
sudo su - zigbee2mqtt
git clone https://github.com/Koenkk/zigbee2mqtt.git
cd zigbee2mqtt
git checkout 1.35.3 # latest release at time of writing
npm ci # This will take a few minutes on that 1-core CPU ...
npm run build # Again, this will take a while
```


Next create and edit the configuration file using the sample config.
```
cp data/configuration.example.yaml data/configuration.yaml
# Then edit the file e.g. via nano or vi
nano data/configuration.yaml
```

Make the following changes:
- set `homeassistant` to `true`
- set `frontend` to `true`
- point `mqtt.server` to the HomeAssistant server (the one with Mosquitto running)
- uncomment `user` and `password` and set the values to the once configured earlier in Mosquitto
- set `serial.port` to the correct file in `/dev`
- Save (F2 in nano) and exit (Ctrl+X in nano)


Next start the service:
```
# This again will take a while. After minute or two the app should start printing log messages onto the console
npm start
```

During the start-up a couple of message should be logged containing `MQTT publish: topic 'homeassistant...` - once this happened return to the HomeAssistant web interface
and go to Settings -> Devices. A new `MQTT` device should have been discovered. Proceed to configure it.

Open the zigbee2mqtt frontend in a web brower. The default HTTP port is 8080.

### Create a SystemD service

- Create a new service file and edit it:
```sh
 sudo nano /etc/systemd/system/zigbee2mqtt.service
```

- add the following content, adjust if required:
```sh
[Unit]
Description=zigbee2mqtt
After=network.target

[Service]
Environment=NODE_ENV=production
Type=simple
ExecStart=/usr/bin/npm start
WorkingDirectory=/opt/zigbee2mqtt/zigbee2mqtt
StandardOutput=inherit
StandardError=inherit
Restart=always
RestartSec=10s
User=zigbee2mqtt
TimeoutStartSec=180

[Install]
WantedBy=multi-user.target
```

- After saving the file reload the SystemD configurations, then start the service.<br/>
  Note: If SystemD exists with a startup timeout error, increae the value for `TimeoutStartSec` in the configuration file, then reload SystemD.
```sh
sudo systemctl daemon-reload
# This might take a while
sudo service zigbee2mqtt start
sudo systemctl enable zigbee2mqtt.service
```

- Once the service has finished starting up the Zigbee2MQTT web UI can be accessed on port 8080.
- The last step is to also add it as a service to Home Assistant via Settings -> Devices & Services. It should have been auto-detected as a new device/service a few seconds after the Zigbee2MQTT service completed start-up.
- In HomeAssistant Devices & Services click on the MQTT service, then on *Devices* in the service's menu. In the list of devices find the *Zigbee2MQTT Bridge* and select it. Via the *Permit join* control new discovered Zigbee devices can be added.