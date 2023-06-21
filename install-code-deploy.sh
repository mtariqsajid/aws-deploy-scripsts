#!/bin/bash

# Installs CodeDeploy agent and its prerequisites on Ubuntu 22.04 given AWS CodeDeploy team doesn't exist
# https://docs.aws.amazon.com/codedeploy/latest/userguide/codedeploy-agent.html#codedeploy-agent-version-history
CODEDEPLOY_VERSION=1.5.0

sudo apt update
sudo apt install ruby-full ruby-webrick wget -y

cd /tmp
wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/releases/codedeploy-agent_"$CODEDEPLOY_VERSION"_all.deb
mkdir codedeploy-agent_"$CODEDEPLOY_VERSION"_ubuntu22
dpkg-deb -R codedeploy-agent_"$CODEDEPLOY_VERSION"_all.deb codedeploy-agent_"$CODEDEPLOY_VERSION"_ubuntu22
sed 's/Depends:.*/Depends:ruby3.0/' -i ./codedeploy-agent_"$CODEDEPLOY_VERSION"_ubuntu22/DEBIAN/control
dpkg-deb -b codedeploy-agent_"$CODEDEPLOY_VERSION"_ubuntu22/
sudo dpkg -i codedeploy-agent_"$CODEDEPLOY_VERSION"_ubuntu22.deb

systemctl list-units --type=service | grep codedeploy
sudo systemctl status codedeploy-agent
