#!/bin/sh
###############################################################################
#
#VARS INIT
#
###############################################################################


###############################################################################
#
#Confirm Env
#
###############################################################################
date
echo "## Install Preconfirm"
echo "## Uname"
uname -r
echo
echo "## OS bit"
getconf LONG_BIT
echo

###############################################################################
#
#INSTALL yum-utils
#
###############################################################################
date
echo "## Install begins : yum-utils"
yum install -y yum-utils >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Install failed..."
  exit 1
fi
echo "## Install ends   : yum-utils"
echo

###############################################################################
#
#Setting yum-config-manager
#
###############################################################################
echo "## Setting begins : yum-config-manager"
yum-config-manager \
   --add-repo \
   https://download.docker.com/linux/centos/docker-ce.repo >/dev/null 2>&1

if [ $? -ne 0 ]; then
  echo "Install failed..."
  exit 1
fi
echo "## Setting ends   : yum-config-manager"
echo

###############################################################################
#
#Setting rpm package
#
###############################################################################
echo "## Setting begins : upgrade php repos"
rpm \
    -Uvh \ 
    https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
if [ $? -ne 0 ]; then
  echo "Install failed..."
  exit 1
fi
echo "## Setting ends   : upgrade php repos"
echo

###############################################################################
#
#Update Package Cache
#
###############################################################################
echo "## Setting begins : Update package cache"
yum makecache fast >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Install failed..."
  exit 1
fi
echo "## Setting ends   : Update package cache"
echo

###############################################################################
#
#INSTALL php
#
###############################################################################
date
echo "## Install begins : php"
yum -y install php72w \
    php72w-cli php72w-common php72w-devel \
    php72w-embedded php72w-fpm php72w-gd \
    php72w-mbstring php72w-mysqlnd php72w-opcache \
    php72w-pdo php72w-xml
if [ $? -ne 0 ]; then
  echo "Install failed..."
  exit 1
fi
echo "## Install ends   : php"
date
echo

###############################################################################
#
#Stop Firewalld
#
###############################################################################
echo "## Setting begins : stop firewall"
systemctl stop firewalld
if [ $? -ne 0 ]; then
  echo "Install failed..."
  exit 1
fi
systemctl disable firewalld
if [ $? -ne 0 ]; then
  echo "Install failed..."
  exit 1
fi
echo "## Setting ends   : stop firewall"
echo

###############################################################################
#
#Clear Iptable rules
#
###############################################################################
echo "## Setting begins : clear iptable rules"
iptables -F
if [ $? -ne 0 ]; then
  echo "Install failed..."
  exit 1
fi
echo "## Setting ends   : clear iptable rules"
echo

