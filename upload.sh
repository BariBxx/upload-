#!/bin/bash
# copyright : @hoji0x
clear

function banner0() {
	printf "\e[0;32m                __                __ \e[0m\n"
	printf "\e[0;32m   __  ______  / /___  ____ _____/ / \e[0m\n"
	printf "\e[0;32m  / / / / __ \/ / __ \/ __ '/ __  /  \e[0m\n"
	printf "\e[0;32m / /_/ / /_/ / / /_/ / /_/ / /_/ /   \e[0m\n"
	printf "\e[0;32m \__,_/ .___/_/\____/\__,_/\__,_/    \e[0m\n"
	printf "\e[0;32m     /_/  \e[0;37m payload uploader tool      \e[0m\n"
	echo
}

function enterPath() {
	printf " \e[0;32m[+]\e[0;37m Enter Your File Path: \e[0;32m"
	read path; printf "\e[0m"

	if ! [ -f "$path" ]; then
		printf " \e[0;31m[+]\e[0;37m The File \e[0;31m$path\e[0;37m Not Exist \e[0m\n"
		exit 2
	fi

	printf " \e[0;32m[+]\e[0;37m Enter Fake Domain: \e[0;32m"
	read fake; printf "\e[0m"

	upload
}

function upload() {
	url=$(curl -s https://da.gd/s/?url=$(curl -s $(curl -s -F "file=@$path" https://api.anonfiles.com/upload | jq | grep '"short"' | awk '{ print $2 }' | cut -d '"' -f2) | grep 'cdn-' | awk '{ print $1 }' | cut -d '"' -f2))
	url2=$(echo $url | awk "{gsub(\"https://\",\"https://$fake@\")}1")
	printf "\n \e[0;32m[>]\e[0;37m Your Direct Link: \e[0;32m$url2\e[0m\n"
	exit 0
}

banner0
enterPath
