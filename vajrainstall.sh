#!/bin/bash

install_osquery() {
	echo -e "\e[33mInstalling Vajra EDR Client. Please wait ...\e[0m"

	sudo mkdir -p /etc/osquery/

	# Downloading required files
	echo -e "\e[33mDownloading required files\e[0m"
	sudo curl -o /etc/osquery/cert.pem https://raw.githubusercontent.com/VajraSecurity/Osquery-Hands-on/main/linux/cert.pem
	sudo curl -o /etc/osquery/enrollment_secret https://raw.githubusercontent.com/VajraSecurity/Osquery-Hands-on/main/linux/enrollment_secret
	sudo curl -o /etc/osquery/osquery.flags https://raw.githubusercontent.com/VajraSecurity/Osquery-Hands-on/main/linux/osquery.flags

	# Downloading osquery
	echo -e "\e[33mDownloading osquery\e[0m"
	sudo curl -o /usr/bin/osqueryd https://media.githubusercontent.com/media/VajraSecurity/Osquery-Hands-on/main/linux/osqueryd

	# Osquery execute permission
	echo -e "\e[33mOsquery execute permission\e[0m"
	sudo chmod +x /usr/bin/osqueryd

	# Downloading shell script to run osquery
	echo -e "\e[33mDownloading shell script to run osquery\e[0m"
	sudo curl -o /usr/bin/vajra.sh https://raw.githubusercontent.com/VajraSecurity/Osquery-Hands-on/main/linux/vajra.sh

	# Script execute permission
	echo -e "\e[33mScript execute permission\e[0m"
	sudo chmod +x /usr/bin/vajra.sh

	# Downloading service file
	echo -e "\e[33mDownloading service file\e[0m"
	sudo curl -o /lib/systemd/system/vajra.service https://raw.githubusercontent.com/VajraSecurity/Osquery-Hands-on/main/linux/vajra.service

	# Copying service file
	echo -e "\e[33mCopying service file\e[0m"
	sudo cp /lib/systemd/system/vajra.service /etc/systemd/system/vajra.service

	# Changing permission to service file
	echo -e "\e[33mChanging permission to service file\e[0m"
	sudo chmod 644 /etc/systemd/system/vajra.service

	# Starting Vajra service
	echo -e "\e[33mStarting Vajra service\e[0m"
	sudo systemctl start vajra.service

	# Enabling to start service on system boot
	echo -e "\e[33mEnabling to start service on system boot\e[0m"
	sudo systemctl enable vajra.service

	echo -e "\e[32mVajra EDR Client installation successfull\e[0m"
}

uninstall_osquery() {

	echo -e "\e[33mUninstalling Vajra EDR Client. Please wait ...\e[0m"

	# Stopping Vajra service 
	echo -e "\e[33mStopping Vajra service\e[0m"
	sudo systemctl stop vajra.service

	# Disabling Vajra service
	echo -e "\e[33mDisabling Vajra service\e[0m"
	sudo systemctl disable vajra.service

	# Removing Osquery binary
	echo -e "\e[33mRemoving Osquery binary\e[0m"
	sudo rm -rf /usr/bin/osqueryd

	# Removing Osquery script
	echo -e "\e[33mRemoving Osquery script\e[0m"
	sudo rm -rf /usr/bin/vajra.sh
	
	# Removing Osquery configurations
	echo -e "\e[33mRemoving Osquery configurations\e[0m"
	sudo rm -rf /etc/osquery/

	# Removing Osquery service
	echo -e "\e[33mRemoving Osquery service\e[0m"
	sudo rm -rf /lib/systemd/system/vajra.service
	sudo rm -rf /etc/systemd/system/vajra.service

	# Removing Osquery log files
	echo -e "\e[33mRemoving Osquery log files\e[0m"
	sudo rm -rf /var/osquery/

	echo -e "\e[32mVajra EDR Client uninstallation successfull\e[0m"
}

if [ $# -eq 0 ] || [ $# -eq 1 ]; then

	if [ "$1" = "-install" ] || [ "$1" = "" ]; then
		install_osquery
	elif [ "$1" = "-uninstall" ]; then
		uninstall_osquery
	else
		echo -e "\e[31mInvalid argument: $1\e[0m"
		echo -e "\e[31mUsage: $0 [-install | -uninstall]\e[0m"
		echo -e "\e[32mIf no option is selected, by default the script will install osquery \e[0m"
		echo -e "\e[31mVajra EDR Client installation failed\e[0m"
		exit 1
	fi
else
    echo -e "\e[32mMultiple arguments provided.\e[0m"
fi
