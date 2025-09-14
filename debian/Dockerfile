FROM debian

# openrc (init)
RUN apt-get update && apt-get install -y --no-install-recommends openrc && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /etc/conf.d
RUN rm -f /etc/init.d/cgroups /etc/init.d/hwclock.sh
RUN echo 'rc_need="!sysfs !cgroups !net !mountkernfs !localmount"' >>/etc/rc.conf

ENTRYPOINT ["/sbin/openrc-init"]

RUN apt-get update && apt-get install -y --no-install-recommends openssh-server && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y --no-install-recommends sudo && rm -rf /var/lib/apt/lists/*

EXPOSE 22

# lima
RUN apt-get update && apt-get install -y --no-install-recommends iptables && rm -rf /var/lib/apt/lists/*
RUN update-alternatives --set iptables /usr/sbin/iptables-legacy
RUN apt-get update && apt-get install -y --no-install-recommends sshfs && rm -rf /var/lib/apt/lists/*
RUN echo "user_allow_other" >>/etc/fuse.conf

RUN rm -f /usr/bin/systemctl /lib/systemd/systemd
