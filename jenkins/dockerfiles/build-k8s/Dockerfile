#
# Container to driver Kubernetes cluster from KernelCI
#
FROM kernelci/build-base
MAINTAINER "Kevin Hilman <khilmnan@baylibre.com>"

# Install gcloud-sdk
# From: https://cloud.google.com/sdk/docs/downloads-apt-get
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates gnupg curl
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
RUN apt-get update && apt-get install -y google-cloud-sdk kubectl

# gcloud service-account key should be mounted to ${SA_KEY_FILE} when
# container is started.
ENV SA_KEY_FILE=/tmp/sa.json

# to bind-mount a file, it has to be created first (otherwise will be
# created as a directory
RUN touch ${SA_KEY_FILE}

RUN useradd -m kernelci
USER kernelci
