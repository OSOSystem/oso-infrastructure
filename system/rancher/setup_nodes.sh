#!/bin/bash
USERNAME=docker

ssh -l ${USERNAME} rancher1.ososystem.de "
wget -O - https://raw.githubusercontent.com/rancher/install-docker/master/19.03.2.sh | sh;
exit;
"
ssh -l ${USERNAME} rancher2.ososystem.de "
wget -O - https://raw.githubusercontent.com/rancher/install-docker/master/19.03.2.sh | sh;
exit;
"
ssh -l ${USERNAME} rancher3.ososystem.de "
wget -O - https://raw.githubusercontent.com/rancher/install-docker/master/19.03.2.sh | sh;
exit;
"
