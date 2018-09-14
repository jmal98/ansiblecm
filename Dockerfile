FROM alpine:3.8

RUN apk add --no-cache \
		bzip2=1.0.6-r6 \
		file=5.32-r0 \
		gzip=1.9-r0 \
		libffi=3.2.1-r4 \
		libffi-dev=3.2.1-r4 \
        krb5=1.15.3-r0 \
        krb5-dev=1.15.3-r0 \
        krb5-libs=1.15.3-r0 \
		musl-dev=1.1.19-r10 \
		openssh \
		openssl-dev \
		python2-dev=2.7.15-r1 \
		py-cffi=1.10.0-r0 \
		py-cryptography=2.1.4-r1 \
		py2-pip=10.0.1-r0 \
		py-setuptools=39.1.0-r0 \
		py2-yaml=3.12-r1 \
		sshpass=1.06-r0 \
		tar=1.30-r0 \
		&& \
    apk add --no-cache --virtual build-dependencies \		
		gcc=6.4.0-r8 \		
		make=4.2.1-r2 \
	    && \
	pip install --upgrade pip==18.0 && \
	pip install \
		ansible==2.6.4 \
		botocore==1.10.77 \
		boto==2.49.0 \
		boto3==1.7.77 \
		pywinrm[kerberos]==0.3.0 \
		&& \
	apk del build-dependencies

VOLUME ["/tmp/playbook"]

WORKDIR /tmp/playbook

ENTRYPOINT ["ansible-playbook"]

CMD ["--version"]
