FROM --platform=${BUILDPLATFORM} alpine:3.18.4 as prepared-binary

# set build arguments automatically using buildx
ARG BUILDPLATFORM
ARG BUILDARCH

ARG TARGETPLATFORM
ARG TARGETARCH

ARG HELM_VERSION="3.13.2"
ARG KUBECTL_VERSION="1.28.4"

RUN echo I am running on $BUILDPLATFORM $BUILDARCH, to target arch for $TARGETPLATFORM $TARGETARCH

# Download the binary
RUN wget https://github.com/getsops/sops/releases/download/v3.8.1/sops-v3.8.1.linux.${TARGETARCH}
# Move the binary in to your PATH
RUN mv sops-v3.8.1.linux.${TARGETARCH} /usr/local/bin/sops
# Make the binary executable
RUN chmod +x /usr/local/bin/sops

RUN apk update

RUN apk add py-pip curl wget git bash jq gcc alpine-sdk openssl
RUN apk add --no-cache aws-cli
RUN apk --no-cache add ca-certificates && update-ca-certificates

RUN curl -L -o /usr/bin/kubectl https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/${TARGETARCH}/kubectl --insecure
RUN chmod +x /usr/bin/kubectl

RUN wget --no-check-certificate https://get.helm.sh/helm-v${HELM_VERSION}-linux-${TARGETARCH}.tar.gz -O - | tar -xzO linux-${TARGETARCH}/helm > /usr/local/bin/helm
RUN chmod +x /usr/local/bin/helm

COPY --from=prepared-binary entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
