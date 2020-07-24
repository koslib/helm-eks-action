FROM alpine:3.12

ARG KUBECTL_VERSION="1.17.7"

RUN apk add py-pip curl
RUN pip install awscli
RUN curl -L -o /usr/bin/kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.7/2020-07-08/bin/linux/amd64/kubectl
RUN chmod +x /usr/bin/kubectl

RUN curl -o /usr/bin/aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.7/2020-07-08/bin/linux/amd64/aws-iam-authenticator
RUN chmod +x /usr/bin/aws-iam-authenticator

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]