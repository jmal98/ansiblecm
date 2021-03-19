FROM alpine:3.13.2

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
		python3-dev=3.8.8-r0 \
		py3-cffi \
		py3-cryptography=3.3.2-r0 \
		py3-setuptools=51.3.3-r0 \
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
		ansible==2.10.3 \
		botocore==1.20.32 \
		boto==2.49.0 \
		PyYAML==5.4.1 \
		boto3==1.17.32 \
		awscli==1.19.32 \
		pywinrm[kerberos]==0.4.1 \
		&& \
	apk del build-dependencies \
		&& \
	rm -rf /root/.cache

VOLUME ["/tmp/playbook"]

WORKDIR /tmp/playbook

ENTRYPOINT ["ansible-playbook"]

CMD ["--version"]
