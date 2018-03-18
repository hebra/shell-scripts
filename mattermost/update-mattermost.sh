#!/bin/bash
#
# A simple shell script to automate the update to a new Mattermost version
# (C) 2018 Hendrik Brandt
# Release under the terms and conditions of the
# 2-clause BSD license aka "Simplified BSD License"
#

mkdir -p /opt/mattermost

[ -z ${1+x} ] && echo -e "Please provide the Mattermost version to update to as first parameter\nExample: ${0} 4.8.0" && exit$

ARCHIVE="mattermost-${1}-linux-amd64.tar.gz"

DL_URL="https://releases.mattermost.com/${1}/${ARCHIVE}"

if [ ! -f /opt/mattermost/${ARCHIVE} ]; then
        if curl --output /dev/null --silent --head --fail "$DL_URL"; then
                echo "Download version ${1} of Mattermost"
                curl -o /opt/mattermost/${ARCHIVE} ${DL_URL}
        else
                echo "Download not found for version ${1}"
                exit 1
        fi
fi

# Untar and rename the new mattermost folder to
# include the version number
tar xf /opt/mattermost/$ARCHIVE -C /opt/mattermost
mv /opt/mattermost/mattermost /opt/mattermost/mattermost-${1}

# Remove the default logs folder
[ -d /opt/mattermost/mattermost-${1}/logs ] && rm -rf /opt/mattermost/mattermost-${1}/logs

# Rename the original config.json file for reference
mv /opt/mattermost/mattermost-${1}/config/config.json /opt/mattermost/mattermost-${1}/config/config-${1}.json

# Stop the running mattermost instance
service mattermost stop

# Unlink the current link and relink to the new version
rm /opt/mattermost/current
ln -s /opt/mattermost/mattermost-${1} /opt/mattermost/current

# Link config and persitent folders
ln -s /opt/mattermost/storage/config.json /opt/mattermost/current/config/config.json

ln -s /opt/mattermost/storage/data /opt/mattermost/current/data
ln -s /opt/mattermost/storage/logs /opt/mattermost/current/logs
ln -s /opt/mattermost/storage/plugins /opt/mattermost/current/plugins

# Fix all permissions
chown -R mattermost:mattermost /opt/mattermost

# Start Mattermost
service mattermost start
