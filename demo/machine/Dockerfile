# https://github.com/jmal98/ansiblecm
#
# Machine to demonstrate provisioning 
# Not for production use
FROM centos:7.4.1708

RUN yum -y install \
		openssh-server \
		passwd \
		sudo \
	&& \
	yum -y clean all \
	&& \
	adduser centos -M \
	&& \
	mkdir /home/centos \
	&& \
	chown centos:centos /home/centos \
	&& \
	echo -e "centos\ncentos" | (passwd --stdin centos) \
	&& \
	echo 'centos 	ALL=(ALL)	NOPASSWD: ALL' >> /etc/sudoers
	
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' 
	#&& sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
   # && sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config

ENTRYPOINT ["/usr/sbin/sshd", "-D", "-e"]