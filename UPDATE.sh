# Package updater fo most linux distros
# Copyright (C) 2020  Jacob Still
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

#!/bin/bash

if [ "$1" == "--copyright" ];then
        echo "UPDATE.sh Copyright (C) 2020  Jacob Still"
        echo "This program comes with ABSOLUTELY NO WARRANTY"
        echo "This is free software, and you are welcome to redistribute it"
        echo "under certain conditions"
	exit
fi

if [ "$1" == "--help" ];then
        echo " "
        echo " "
        echo " "
        echo " "
        exit
fi

DISTRO="$(cat /etc/*-release | grep ID_LIKE | cut -c9- | sed 's/\"//g' | awk '{ print $1}')"
if [ -z "$DISTRO" ];then
	DISTRO="$(cat /etc/*-release | grep ID | grep -v _ID | grep -v ID_ | cut -c4- | sed 's/\"//g' | awk '{ print $1}')"
fi
if [ -z "$DISTRO" ];then
        DISTRO="$(uname)"
fi

echo $DISTRO based machine...
#exit
if [ "$DISTRO" == "debian" ] || [ "$DISTRO" == "ubuntu" ];then
	echo using apt-get...
	apt-get update -y
	apt-get upgrade -y
#	apt-get autoremove -y
elif [ "$DISTRO" == "rhel" ];then
	echo using yum...
	yum update
#	yum -y install epel-release
#	yum -y install curl jq
elif [ "$DISTRO" == "arch" ];then
	echo using pacman...
	pacman -Syu
elif [ "$DISTRO" == "gentoo" ];then
	emerge --sync
	emerge --update --deep --with-bdeps=y @world
elif [ "$DISTRO" == "suse" ];then
	echo using zypper...
	zypper refresh
	zypper update
elif [ "$DISTRO" == "FreeBSD" ];then
	echo using freebsd-update...
	freebsd-update fetch
	freebsd-update install
#	pfSense-upgrade -udy
else
	echo "UPDATE.sh detected your system is: $DISTRO"
	echo "#DISTRO is not yet supported. Please create an issue at:"
	echo "https://github.com/jcstill/linuxupdater/issues"
	echo "thanks"
fi
