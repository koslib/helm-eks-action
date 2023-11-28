FROM mozilla/sops:v3-alpine as sops

FROM alpine:3.13

ARG HELM_VERSION="3.13.2"
ARG KUBECTL_VERSION="1.28.4"
ARG PLATFORM="arm64"

COPY --from=sops /usr/local/bin/sops /usr/bin/sops

RUN apk update

RUN apk add py-pip curl wget git bash jq gcc alpine-sdk openssl
RUN apk add --no-cache aws-cli
RUN apk --no-cache add ca-certificates && update-ca-certificates

RUN curl -k -L -o /usr/bin/kubectl https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/${PLATFORM}/kubectl 
RUN chmod +x /usr/bin/kubectl

RUN wget --no-check-certificate https://get.helm.sh/helm-v${HELM_VERSION}-linux-${PLATFORM}.tar.gz -O - | tar -xzO linux-${PLATFORM}/helm > /usr/local/bin/helm
RUN chmod +x /usr/local/bin/helm

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
