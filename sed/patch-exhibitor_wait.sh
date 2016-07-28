if grep -e '^ExecStartPre=\/opt\/mesosphere\/bin\/exhibitor_wait.py' /etc/systemd/system/dcos-mesos-master.service;
then
    sed -i.bak -E "s/^ExecStartPre=\/opt\/mesosphere\/bin\/exhibitor_wait.py/#ExecStartPre=\/opt\/mesosphere\/bin\/exhibitor_wait.py/g" /etc/systemd/system/dcos-mesos-master.service
    sudo systemctl daemon-reload
    sudo systemctl restart dcos-mesos-master
    echo "Changes done!"
else
    echo "You have already made this change. Not restarting master."
fi


