FROM alpine:latest
MAINTAINER techmovers@salemove.com

run apk add --update \
        bash \
        curl \
        git \
        openssl \
        py-pip \
        python

RUN cd / \
 && git clone https://github.com/lukas2511/dehydrated.git \
 && (cd dehydrated && git checkout tags/v0.6.2) \
 # need to install boto3 explicitly. For some reason dns-lexicon[route53] doesn't seem to do it
 && pip install dns-lexicon==2.1.24 dns-lexicon[route53]==2.1.24 boto3

ADD https://raw.githubusercontent.com/AnalogJ/lexicon/5deaca503010e1cc0dfca10e31f3ffd17e7fc749/examples/dehydrated.default.sh /dehydrated/
RUN chmod +x /dehydrated/dehydrated.default.sh
ADD dns-certbot.sh /dns-certbot.sh
RUN chmod +x /dns-certbot.sh

CMD  [ "/dns-certbot.sh" ]
