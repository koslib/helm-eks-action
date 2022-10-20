FROM mozilla/sops:v3.6.0-alpine as sops
FROM amazon/aws-cli:2.8.4 as awscliv2
FROM alpine:3.13

ARG HELM_VERSION="3.10.1"
ARG KUBECTL_VERSION="1.25.91"

COPY --from=sops /usr/local/bin/sops /usr/bin/sops
COPY --from=awscliv2 /usr/local/bin/aws /usr/local/bin/aws

RUN apk add curl wget ca-certificates bash alpine-sdk

RUN curl -L -o /usr/bin/kubectl https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl
RUN chmod +x /usr/bin/kubectl

RUN curl -o /usr/bin/aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/aws-iam-authenticator
RUN chmod +x /usr/bin/aws-iam-authenticator

RUN wget https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm
RUN chmod +x /usr/local/bin/helm

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]:
