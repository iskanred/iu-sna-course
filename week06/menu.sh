
#!/bin/bash

readonly SELECT_STR='Please, select of one the options above:'
readonly EXIT_STR='Terminating...'

# Common options
readonly EXIT_OPT='Exit'
readonly CANCEL_OPT='Cancel'
readonly INVALID_OPT='Invalid option! Please, try again...'

# Main menu options
readonly SYSINFO_OPT='System information'
readonly OS_COMP_OPT='OS components'

# System infromation submenu options
readonly KERNEL_OPT='OS kernel name and kernel version'
readonly SYSARCH_OPT='System architecture'
readonly USERS_OPT='List of currently logged in users'

# OS components submeny options
readonly EFI_OPT='Verify that EFI is enabled'
readonly BLOCK_DEVICES_OPT='List of all connected block devices'
readonly BOOT_DEVICE_OPT='The first boot device on the system'

function main_menu() {
	echo $SELECT_STR
	select OPTION in "$SYSINFO_OPT" "$OS_COMP_OPT" "$EXIT_OPT";
	do
		case $OPTION in
			"$SYSINFO_OPT")
				sysinfo_submenu
				break
				;;
			"$OS_COMP_OPT")
				os_comp_submenu
				break
				;;
			"$EXIT_OPT")
				echo $EXIT_STR
				exit 0
				break
				;;
			*)
				echo $INVALID_OPT
				;;
		esac
	done
	main_menu
}

function sysinfo_submenu() {
	echo $SELECT_STR
	select OPTION in "$KERNEL_OPT" "$SYSARCH_OPT" "$USERS_OPT" "$CANCEL_OPT" "$EXIT_OPT";
	do
		case $OPTION in
			"$KERNEL_OPT")
				printf "OS kernel name: $(uname -s)"
				printf "Kernel version: $(uname -v)\n"
				;;
			"$SYSARCH_OPT")
				printf "System architecture: $(uname -m)\n"
				;;
			"$USERS_OPT")
				printf "Currenly logged in users:"
				printf "$(who -uH)\n"
				;;
			"$CANCEL_OPT")
				break
				;;
			"$EXIT_OPT")
				echo $EXIT_STR
				exit 0
				break
				;;
			*)
				echo $INVALID_OPT
				;;
		esac
	done
}

function os_comp_submenu() {
	echo $SELECT_STR
	select OPTION in "$EFI_OPT" "$BLOCK_DEVICES_OPT" "$BOOT_DEVICE_OPT" "$CANCEL_OPT" "$EXIT_OPT";
	do 
		case $OPTION in
			"$EFI_OPT")
				print_efi_enabled
				;;
			"$BLOCK_DEVICES_OPT")
				echo 'Connected block devices:'
				echo "$(lsblk)"
				printf "\n"
				;;
			"$BOOT_DEVICE_OPT")
				echo 'The first boot device on the system is:'
				printf "$(awk '$1 ~ /^\/dev\// && $2 == "/" { print $1 }' /proc/self/mounts)\n\n"
				;;
			"$CANCEL_OPT")
				break
				;;
			"$EXIT_OPT")
				echo $EXIT_STR
				exit 0
				break
				;;
			*)
				echo $INVALID_OPT
				;;
		esac
	done

} 

function print_efi_enabled() {
	if [ -d "/sys/firmware/efi" ]; then
		echo "EFI is enabled"
	else
		echo "EFI is disabled"
	fi
}

echo 'This script helps to check information about system and its components'
echo '----------------------------------------------------------------------'
main_menu






