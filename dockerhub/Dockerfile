FROM alpine:3.18.4

ARG HELM_VERSION="3.13.2"
ARG KUBECTL_VERSION="1.28.4"

RUN echo "I am running on $BUILDPLATFORM ($BUILDARCH), building for $TARGETPLATFORM" 

# Download the binary
RUN curl -k -L -O  https://github.com/getsops/sops/releases/download/v3.8.1/sops-v3.8.1.linux.${BUILDARCH}
# Move the binary in to your PATH
RUN mv sops-v3.8.1.linux.${BUILDARCH} /usr/local/bin/sops
# Make the binary executable
RUN chmod +x /usr/local/bin/sops


RUN apk update

RUN apk add py-pip curl wget git bash jq gcc alpine-sdk openssl
RUN apk add --no-cache aws-cli
RUN apk --no-cache add ca-certificates && update-ca-certificates

RUN curl -k -L -o /usr/bin/kubectl https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/${BUILDARCH}/kubectl 
RUN chmod +x /usr/bin/kubectl

RUN wget --no-check-certificate https://get.helm.sh/helm-v${HELM_VERSION}-linux-${BUILDARCH}.tar.gz -O - | tar -xzO linux-${BUILDARCH}/helm > /usr/local/bin/helm
RUN chmod +x /usr/local/bin/helm

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
