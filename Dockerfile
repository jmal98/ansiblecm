FROM alpine:3.9

RUN apk add --no-cache \
		bzip2 \
		file \
		gzip \
		libffi \
		libffi-dev \
		krb5 \
		krb5-dev \
		krb5-libs \
		musl-dev \
		openssh \
		openssl-dev \
		python2-dev=2.7.16-r1 \
		py-cffi \
		py-cryptography=2.4.2-r2 \
		py2-pip=18.1-r0 \
		py-setuptools=40.6.3-r0 \
		sshpass \
		tar \
		&& \
    apk add --no-cache --virtual build-dependencies \
		gcc \
		make \
	    && \
	pip install --upgrade pip==19.1.1 && \
	pip install \
		ansible==2.8.1 \
		botocore==1.12.110 \
		boto==2.49.0 \
		boto3==1.9.110 \
		awscli==1.16.120 \
		pywinrm[kerberos]==0.3.0 \
		&& \
	apk del build-dependencies \
		&& \
        rm -rf /root/.cache

VOLUME ["/tmp/playbook"]

WORKDIR /tmp/playbook

ENTRYPOINT ["ansible-playbook"]

CMD ["--version"]
