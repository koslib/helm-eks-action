FROM alpine:3.12

ARG KUBECTL_VERSION="1.17.7"

RUN apk add py-pip curl wget git openssh
RUN pip install awscli
RUN curl -L -o /usr/bin/kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.7/2020-07-08/bin/linux/amd64/kubectl
RUN chmod +x /usr/bin/kubectl

RUN curl -o /usr/bin/aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.7/2020-07-08/bin/linux/amd64/aws-iam-authenticator
RUN chmod +x /usr/bin/aws-iam-authenticator

RUN wget https://get.helm.sh/helm-v3.2.4-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm 
RUN chmod +x /usr/local/bin/helm
RUN helm plugin install https://github.com/zendesk/helm-secrets 

COPY entrypoint.sh /entrypoint.sh
RUN chmod  +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]