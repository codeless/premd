#! /bin/sh

# Several probably useful functions for shell scripts
#
# Created on: 2011-05-07

# The show-message function outputs a passed string
show_message() {
	# Output message
	echo $1

	# Exit execution?
	if [ $# -ge 2 ]
	then
		echo "Script will now exit"
		exit
	fi
}
