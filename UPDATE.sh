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

if [ "$1" == "help" ];then
        echo "UPDATE.sh Copyright (C) 2020  Jacob Still"
        echo "This program comes with ABSOLUTELY NO WARRANTY"
        echo "This is free software, and you are welcome to redistribute it"
        echo "under certain conditions"
fi

DISTRO="$(cat /etc/*-release | grep ID_LIKE | cut -c9- | sed 's/\"//g' | awk '{ print $1}')"
if [ -z "$DISTRO" ];then
        DISTRO="$(uname)"
fi
echo Update script for $DISTRO based machines:
if [ "$DISTRO" == "debian" ];then
        echo Using apt...
        sudo apt update -y
        sudo apt upgrade -y
        sudo apt autoremove -y
elif [ "$DISTRO" == "ubuntu" ];then
        echo Using apt...
        sudo apt update -y
        sudo apt upgrade -y
        sudo apt autoremove -y
elif [ "$DISTRO" == "rhel" ];then
        echo Using yum...
        yum update
        yum -y install epel-release
        yum -y install curl jq
elif [ "$DISTRO" == "FreeBSD" ];then
#       freebsd-update fetch
#       freebsd-update install
        pfSense-upgrade -udy
fi
