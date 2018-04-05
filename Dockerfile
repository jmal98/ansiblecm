FROM alpine:3.7

RUN apk add --no-cache \
		bzip2=1.0.6-r6 \
		file=5.32-r0 \
		gzip=1.8-r0 \
		libffi=3.2.1-r4 \
		libffi-dev=3.2.1-r4 \
		musl-dev=1.1.18-r3 \
		openssl-dev=1.0.2o-r0 \
		python-dev=2.7.14-r2 \
		py-cffi=1.10.0-r0 \
		py-cryptography=2.0.3-r1 \
		py-pip=9.0.1-r1 \
		py-setuptools=33.1.1-r1 \
		py-yaml=3.12-r1 \
		tar=1.29-r1 \
		&& \
    apk add --no-cache --virtual build-dependencies \		
		gcc=6.4.0-r5 \		
		make=4.2.1-r0 \
	    && \
	pip install --upgrade pip==9.0.3 && \
	pip install \
		ansible==2.5.0 \
		botocore==1.10.0 \
		boto==2.48.0 \
		boto3==1.7.0 \
		pywinrm==0.3.0 \
		&& \
	apk del build-dependencies

VOLUME ["/tmp/playbook"]

WORKDIR /tmp/playbook

ENTRYPOINT ["ansible-playbook"]

CMD ["--version"]
