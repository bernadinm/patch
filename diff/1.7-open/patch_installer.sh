#!/bin/bash
# Adminrouter Patch for DC/OS 1.7-open
#

sha=8573334f21b0bfd08ae664239c1ca10dfbc0a284
options_flag=""
execute() {
	if (( $(echo $PWD | grep -c $sha) ));
	then
		docker run -it -v $PWD/:/nginx_patch busybox sh -c "cd /nginx_patch && patch $options_flag -i mesosphere-adminrouter.patch"
	else
		echo "Patch can only be appied to a specifc version of DC/OS"
	exit 1
	fi
}

case "$1" in
	enable)
            execute
            ;;
        disable)
	    options_flag="-R"
            execute
            ;;
        *)
            echo $"Usage: $0 {enable|disable}"
            exit 1
esac
