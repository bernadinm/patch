# DC/OS 1.7 Adminrouter Patch
This patch fixes the /service and /services endpoint that enforces port 80. This patch enables passthough any ports and host that a proxy leverages. See https://github.com/dcos/adminrouter/pull/14 for more details.

## Instructions
Log into all master nodes one by one and run this script.

**Note:** This will restart the `dcos-adminrouter` daemon

```bash
cd $(sudo find /opt/mesosphere/ -name nginx.conf)
```

This script must be run in the same directory as the nginx.conf. The patch file must be downloaded to this directory as well.

```bash
curl -O https://raw.githubusercontent.com/bernadinm/patch/master/diff/patch_installer.sh 
curl -O https://raw.githubusercontent.com/bernadinm/patch/master/diff/mesosphere-adminrouter.patch
chmod +x patch_installer.sh
bash patch_installer.sh enable
```

You can also see that status of the patch by performing 

```bash
sudo bash adminrouter-patch.sh status
```

When you want to disable it for any reason run

```bash
sudo bash adminrouter-patch.sh disable
```
