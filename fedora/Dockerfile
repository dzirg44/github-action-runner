FROM registry.fedoraproject.org/fedora-minimal:34
ARG RUNNER_VERSION=2.280.3

ENV GITHUB_PERSONAL_TOKEN ""
ENV GITHUB_OWNER ""
ENV GITHUB_REPOSITORY ""
ENV RUNNER_WORKDIR "/home/github"
RUN microdnf -y install podman buildah bash tar && microdnf clean all

RUN useradd -m github && \
    usermod -aG sudo github && \
    echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER github
WORKDIR ${RUNNER_WORKDIR}

RUN curl -O -L https://github.com/actions/runner/releases/download/v$RUNNER_VERSION/actions-runner-linux-x64-$RUNNER_VERSION.tar.gz
RUN tar xzf ./actions-runner-linux-x64-$RUNNER_VERSION.tar.gz
RUN sudo ./bin/installdependencies.sh
RUN chown -R github:github ${RUNNER_WORKDIR}

COPY --chown=github:github ./fedora/entrypoint.sh ./entrypoint.sh
RUN sudo chmod u+x ./entrypoint.sh

ENTRYPOINT ["/home/github/entrypoint.sh"]