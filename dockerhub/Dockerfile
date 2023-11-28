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



# install aws cli v2
# RUN \
#     zipfile=awscli-exe-linux-x86_64.zip \
#     if [[ "${PLATFORM}" = "arm64" ]]; then zipfile=awscli-exe-linux-aarch64.zip fi \
#     curl -L https://awscli.amazonaws.com/$zipfile.zip -o awscliv2.zip

# RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
# RUN unzip awscliv2.zip
# RUN sudo ./aws/install
RUN aws --version

RUN curl -k -L -o /usr/bin/kubectl https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/${PLATFORM}/kubectl 
RUN chmod +x /usr/bin/kubectl

RUN wget --no-check-certificate https://get.helm.sh/helm-v${HELM_VERSION}-linux-${PLATFORM}.tar.gz -O - | tar -xzO linux-${PLATFORM}/helm > /usr/local/bin/helm
RUN chmod +x /usr/local/bin/helm

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
