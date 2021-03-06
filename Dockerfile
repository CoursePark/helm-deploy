FROM alpine

ENV KUBE_VERSION="v1.7.2"
ENV HELM_VERSION="v2.7.2"

RUN  apk add --no-cache curl git \
 && curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl \
 && chmod +x ./kubectl \
 && mv ./kubectl /usr/local/bin/kubectl \
 && curl -LO https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz \
 && tar -zxvf helm-${HELM_VERSION}-linux-amd64.tar.gz \
 && mv linux-amd64/helm /usr/local/bin/helm \
 && rm -rf linux-amd64 helm-${HELM_VERSION}-linux-amd64.tgz

COPY deploy.sh /

RUN chmod +x deploy.sh

CMD ["/deploy.sh"]
