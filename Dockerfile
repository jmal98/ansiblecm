FROM centos:7.3.1611

RUN yum -y install \
		bzip2-1.0.6 \
		file-5.11 \
		gcc-4.8.5 \
		gzip-1.5.9 \
		libffi-3.0.13 \
		libffi-devel-3.0.13 \
		make-3.82 \
		openssl-devel-1.0.2k \
		python-devel-2.7.5 \
		python-setuptools-0.9.8 \
		python2-cryptography-1.7.2 \
		PyYAML-3.10 \
		tar-1.26 && \
	easy_install \
		ansible==2.3.2.0 \
		botocore==1.7.10 \
		boto==2.48.0 \
		boto3==1.4.7 && \
	yum -y remove \
		gcc \
		make && \
	yum -y clean all

VOLUME ["/tmp/playbook"]

WORKDIR /tmp/playbook

ENTRYPOINT ["ansible-playbook"]

CMD ["--version"]
