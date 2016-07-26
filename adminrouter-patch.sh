#!/bin/bash

# Locate Adminrouter nginx config in mesosphere path
NGINX_PATH=$(sudo find /opt/mesosphere/packages/adminrouter* -name nginx.conf)
changed=false

enable() {
	if (( $(grep -ce "rewrite ^/service/(.\*)\\$ /service/\\$.\/ permanent;" $NGINX_PATH) )) && \
           (( $(grep -ce "proxy_redirect .servicescheme://.host/service/.serviceid/ /service/.serviceid/;" $NGINX_PATH) )) && \
           (( $(grep -ce "proxy_redirect .servicescheme://.host/ /service/.serviceid/;" $NGINX_PATH) )) ;
	then
    		sed -i.bak "s/rewrite ^\/service\/(.*)\$ \/service\/\$1\/ permanent;/rewrite ^\/service\/(.*)\$ \$scheme:\/\/\$http_host\/service\/\$1\/ permanent;/g"  $NGINX_PATH
		sed -i.bak "s/proxy_redirect \$servicescheme:\/\/\$host\/service\/\$serviceid\/ \/service\/\$serviceid\/;/proxy_redirect \$servicescheme:\/\/\$host\/service\/\$serviceid\/ \$scheme:\/\/\$http_host\/service\/\$serviceid\/;/g" $NGINX_PATH
		sed -i.bak "s/proxy_redirect \$servicescheme:\/\/\$host\/ \/service\/\$serviceid\/;/proxy_redirect \$servicescheme:\/\/\$host\/ \$scheme:\/\/\$http_host\/service\/\$serviceid\/;/g" $NGINX_PATH
		changed=true
	fi

	if [ "$changed" = true ] ; then
       		sudo systemctl restart dcos-adminrouter
        	echo "[DC/OS Adminrouter Patch] Patch Applied! Issued Restart to Adminrouter."
	else
		echo "[DC/OS Adminrouter Patch] No changes has been made!"
	fi
}

disable() {
	if (( $(grep -ce "rewrite ^\/service\/(.\*). .scheme://.http_host\/service\/.1\/ permanent;" $NGINX_PATH) )) && \
	   (( $(grep -ce "proxy_redirect .servicescheme:\/\/.host\/service\/.serviceid\/ .scheme://.http_host\/service\/.serviceid\/;" $NGINX_PATH) )) && \
	   (( $(grep -ce "proxy_redirect .servicescheme:\/\/.host\/ .scheme:\/\/.http_host\/service\/.serviceid\/;" $NGINX_PATH) )) ;
	then
                sed -i.bak "s/rewrite ^\/service\/(.*)\$ \$scheme:\/\/\$http_host\/service\/\$1\/ permanent;/rewrite ^\/service\/(.*)\$ \/service\/\$1\/ permanent;/g"  $NGINX_PATH
                sed -i.bak "s/proxy_redirect \$servicescheme:\/\/\$host\/service\/\$serviceid\/ \$scheme:\/\/\$http_host\/service\/\$serviceid\/;/proxy_redirect \$servicescheme:\/\/\$host\/service\/\$serviceid\/ \/service\/\$serviceid\/;/g" $NGINX_PATH
                sed -i.bak "s/proxy_redirect \$servicescheme:\/\/\$host\/ \$scheme:\/\/\$http_host\/service\/\$serviceid\/;/proxy_redirect \$servicescheme:\/\/\$host\/ \/service\/\$serviceid\/;/g" $NGINX_PATH
		changed=true
	fi

        if [ "$changed" = true ] ; then
                sudo systemctl restart dcos-adminrouter
                echo "[DC/OS Adminrouter Patch] Patch Removed! Issued Restart to Adminrouter."
        else
                echo "[DC/OS Adminrouter Patch] No changes has been made!"
        fi
}

status() {
	if (( $(grep -ce "rewrite ^\/service\/(.\*). .scheme://.http_host\/service\/.1\/ permanent;" $NGINX_PATH) ));
	then
		echo "[DC/OS Adminrouter Patch] Already Patched"
	else
		echo "[DC/OS Adminrouter Patch] Not Patched"
	fi
}

case "$1" in
        enable)
            enable
            ;;

        disable)
            disable
            ;;
	status)
	    status
	    ;;
        *)
            echo $"Usage: $0 {enable|disable|status}"
            exit 1

esac
