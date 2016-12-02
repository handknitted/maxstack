#!/usr/bin/env bash
echo Id - `id`

echo Configuring git via https
git config --global url."https://".insteadOf git://

if [ -d devstack ]
then
    echo devstack directory already cloned
else
    git clone https://git.openstack.org/openstack-dev/devstack
fi

export DD_API_KEY=dfec0ce905031315208b2236dbd911ff 
curl https://raw.githubusercontent.com/DataDog/dd-agent/master/packaging/datadog-agent/source/install_agent.sh -o install_agent.sh
sudo chmod +x install_agent.sh
sudo ./install_agent.sh

