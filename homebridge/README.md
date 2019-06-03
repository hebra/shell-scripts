# Setting up Homebridge on Ubuntu

A how-to on setting up homebridge.io on Ubuntu with a dedicated user/group and SystemD service.

## Install Node and NPM 

As Ubuntu usually not has the latest stable Node and NPM versions shipped out of the box, first add the 
official Node DEB repository via

```
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
```

Next install NodeJS and NPM

```
apt install nodejs
```

Check if the right versions are installed via

```
node --version
v12.3.1

npm --version
6.9.0
```

## Create a homebridge user and group

As we don't want the homebridge process to run as root we need to create a user and group for homebridge for the process to be owned by.

```
# Create a user and group homebridge with the home folder /opt/homebridge
useradd -d /opt/homebridge -m -s /bin/bash -U homebridge
```

## Configure NPM for user homebridge

As it is not recommended to install NPM packages system-wide each user should have their own user-global storage folder.

```
# Switch to user homebridge
sudo su homebridge

# Create a global packages folder
mkdir ~/.npm-global
 
# Configure npm to use the new directory path:
npm config set prefix '~/.npm-global'
 
# Add the global bin folder to your PATH to allow running of binaries
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc
 
# Reload the environment (or close and open a terminal)
source ~/.bashrc
```

## Add homebridge

```
# Switch to user homebridge
sudo su homebridge

# Install homebridge
npm install -g homebridge
```


## Create a SystemD service

Copy the homebridge.service to ```/etc/systemd/system/```, then start the service.
Logging messages will be available in ```/var/log/homebridge.log```.

```
# Reload the SystemD daemon after the service file was added or changed
systemctl daemon-reload

# Enable Homebridge to be started during boot time
systemctl enable homebridge

# Start the service
systemctl start homebridge
```