FROM alpine:3.18.5

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
		python3-dev=3.11.6-r0 \
		py3-cffi \
		py3-cryptography=41.0.3-r0 \
		py3-setuptools=67.7.2-r0 \
		sshpass \
		tar \
		&& \
	apk add --no-cache --virtual build-dependencies \
		gcc \
		make \
		&& \
	python3 -m ensurepip --upgrade \
		&& \
	pip3 install \
		ansible==9.1.0 \
		botocore==1.31.44 \
		boto3==1.28.44 \
		awscli==1.29.44 \
		pywinrm[kerberos]==0.4.2 \
		&& \
	apk del build-dependencies \
		&& \
	rm -rf /root/.cache

VOLUME ["/tmp/playbook"]

WORKDIR /tmp/playbook

ENTRYPOINT ["ansible-playbook"]

CMD ["--version"]
