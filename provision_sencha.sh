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

curl https://raw.githubusercontent.com/DataDog/dd-agent/master/packaging/datadog-agent/source/install_agent.sh -o install_agent.sh
sudo chmod +x install_agent.sh
sudo DD_API_KEY=${DD_API_KEY} ./install_agent.sh

sudo mv spark.yaml /etc/dd-agent/conf.d/.

sudo service dd-agent restart
