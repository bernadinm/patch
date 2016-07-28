# DC/OS 1.7 Adminrouter Patch
This patch fixes the /service and /services endpoint that enforces port 80. This patch enables passthough any ports and host that a proxy leverages. See https://github.com/dcos/adminrouter/pull/14 for more details.

## Instructions
Log into all master nodes one by one and run this script.

```bash
cd /opt/mesosphere/packages/adminrouter--91cfc73424d311a8cadbd2bed62362ec216717b7/nginx/conf
```

This script must be run in the same directory as the nginx.conf. The patch file must be downloaded to this directory as well.

```bash
curl -O https://raw.githubusercontent.com/bernadinm/patch/master/diff/patch_installer.sh 
curl -O https://raw.githubusercontent.com/bernadinm/patch/master/diff/mesosphere-adminrouter.patch
chmod +x patch_installer.sh
```

Run this command to apply the change

```bash
bash patch_installer.sh enable
sudo systemctl restart dcos-adminrouter
```

You can also disable the patch by performing 

```bash
bash patch_installer.sh disable
sudo systemctl restart dcos-adminrouter
```


