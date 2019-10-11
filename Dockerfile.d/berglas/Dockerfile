FROM debian:10

# Set in non-interactive mode.
ENV DEBIAN_FRONTEND=noninteractive
# ENV CLOUDSDK_CONFIG=/.config/gcloud

ENV DIRENV_VERSION=2.20.0

RUN apt-get update \
  && apt-get install --assume-yes --no-install-recommends locales procps dialog \
  && echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen \
  && locale-gen \
  && apt-get install --assume-yes --no-install-recommends git tmux zsh jq unzip curl ca-certificates gnupg \
  && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" > /etc/apt/sources.list.d/google-cloud-sdk.list \
  && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - \
  && apt-get update \
  && apt-get install --assume-yes --no-install-recommends google-cloud-sdk \
  && curl -L -o /usr/local/bin/berglas https://storage.googleapis.com/berglas/master/linux_amd64/berglas \
  && chmod a+rwx /usr/local/bin/berglas \
  && curl -L -o /usr/local/bin/direnv https://github.com/direnv/direnv/releases/download/v${DIRENV_VERSION}/direnv.linux-amd64 \
  && chmod a+rwx /usr/local/bin/direnv

# Reset DEBIAN_FRONTEND to default(`dialog`).
# If you no need `dialog`, you can set `DEBIAN_FRONTEND=readline`.
# see also: man 7 debconf
ENV DEBIAN_FRONTEND=
