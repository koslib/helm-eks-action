FROM mozilla/sops:v3.6.0-alpine as sops
FROM alpine:3.13

ARG AWSCLI_VERSION="1.25.96"
ARG HELM_VERSION="3.10.1"
ARG KUBECTL_VERSION="1.25.91"

COPY --from=sops /usr/local/bin/sops /usr/bin/sops

RUN apk add curl wget ca-certificates bash alpine-sdk py-pip gcc git

RUN pip install awscli==${AWSCLI_VERSION}

RUN curl -L -o /usr/bin/kubectl https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl
RUN chmod +x /usr/bin/kubectl

RUN wget https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm
RUN chmod +x /usr/local/bin/helm

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]:
