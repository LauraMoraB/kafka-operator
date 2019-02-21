FROM alpine:3.8

RUN mkdir /kafka-operator
COPY . /kafka-operator

RUN apk add --no-cache python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache

# Token, only provides read-access
RUN pip install django

# CONFLUENT ENV
ARG CONFLUENT_VERSION=4.1
ARG CONFLUENT_DIST=4.1.1-2.11

RUN apk update \
    && apk add \
        tar \
        openjdk8 \
        netcat-openbsd \
        gnupg \
        bash \
        wget \
        curl \
        libaio libaio-dev libgcc musl unzip ca-certificates openssl

# CONFLUENT CLIENT
RUN apk add --update alpine-sdk bash
RUN curl -O "http://packages.confluent.io/archive/${CONFLUENT_VERSION}/confluent-oss-${CONFLUENT_DIST}.tar.gz" && \
tar -zxvf confluent-oss-$CONFLUENT_DIST.tar.gz

EXPOSE 8080
WORKDIR /kafka-operator
CMD ["python", "manage.py", "runserver", "0.0.0.0:8080"]
