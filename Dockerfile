FROM circleci/node

RUN sudo apt-get update && sudo apt-get install -y gettext-base

USER root

ENV CIRCLECI_HOME /home/circleci
ENV GCLOUD_INSTALL /tmp/gcloud-install
ENV GOOGLE_CLOUD_SDK $CIRCLECI_HOME/google-cloud-sdk
ENV PATH="${GOOGLE_CLOUD_SDK}/bin:${PATH}"

RUN curl -sSL https://sdk.cloud.google.com > $GCLOUD_INSTALL && bash $GCLOUD_INSTALL --install-dir=$CIRCLECI_HOME --disable-prompts \
  && rm -rf $GCLOUD_INSTALL \
  && chmod +x $GOOGLE_CLOUD_SDK/bin/* \
  \
  && chown -Rf circleci:circleci $CIRCLECI_HOME

USER circleci

RUN gcloud components install kubectl --quiet