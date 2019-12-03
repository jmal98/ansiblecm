FROM alpine:3.10

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
		python3-dev=3.7.5-r1 \
		py3-cffi \
		py3-cryptography=2.6.1-r1 \
		py3-setuptools=40.8.0-r1 \
		sshpass \
		tar \
		&& \
	apk add --no-cache --virtual build-dependencies \
		gcc \
		make \
		&& \
	pip3 install --upgrade pip==19.1.1 && \
	pip install \
		ansible==2.9.1 \
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
