#!/bin/bash
USERNAME=docker

ssh -l ${USERNAME} node1.ososystem.de "
wget -O - https://raw.githubusercontent.com/rancher/install-docker/master/19.03.2.sh | sh;
exit;
"
ssh -l ${USERNAME} node2.ososystem.de "
wget -O - https://raw.githubusercontent.com/rancher/install-docker/master/19.03.2.sh | sh;
exit;
"
ssh -l ${USERNAME} node3.ososystem.de "
wget -O - https://raw.githubusercontent.com/rancher/install-docker/master/19.03.2.sh | sh;
exit;
"
