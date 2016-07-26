# DC/OS 1.7 Adminrouter Patch

## Instructions
Log into all master nodes one by one and run this script.

**Note:** This will restart the `dcos-adminrouter` daemon

```bash
curl -O https://github.com/bernadinm/patch/blob/master/adminrouter-patch.sh
chmod +x adminrouter-patch.sh
sudo bash adminrouter-patch.sh enable
```

You can also see that status of the patch by performing 

```bash
sudo bash adminrouter-patch.sh status
```

When you want to disable it for any reason run

```bash
sudo bash adminrouter-patch.sh disable
```
