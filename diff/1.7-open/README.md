# DC/OS 1.7-open Adminrouter Patch
This patch fixes the /service and /services endpoint that enforces port 80. This patch enables passthough any ports and host that a proxy leverages. See https://github.com/dcos/adminrouter/pull/14 for more details.

## Instructions
Log into all master nodes one by one and run this script.

```bash
cd /opt/mesosphere/packages/adminrouter--8573334f21b0bfd08ae664239c1ca10dfbc0a284/nginx/conf
```

This script must be run in the same directory as the nginx.conf. The patch file must be downloaded to this directory as well.

```bash
sudo curl -O https://raw.githubusercontent.com/bernadinm/patch/master/diff/1.7-open/patch_installer.sh 
sudo curl -O https://raw.githubusercontent.com/bernadinm/patch/master/diff/1.7-open/mesosphere-adminrouter.patch
sudo chmod +x patch_installer.sh
```

Run this command to apply the change

```bash
sudo bash patch_installer.sh enable
sudo systemctl restart dcos-adminrouter
```

You can also disable the patch by performing 

```bash
sudo bash patch_installer.sh disable
sudo systemctl restart dcos-adminrouter
```


