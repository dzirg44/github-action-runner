FROM debian:bullseye
ARG RUNNER_VERSION=2.280.3
ARG AWC_CLI_VERSION=linux-x86_64-2.2.32

ENV GITHUB_PERSONAL_TOKEN ""
ENV GITHUB_OWNER ""
ENV GITHUB_REPOSITORY ""
ENV RUNNER_WORKDIR "/home/github"

RUN apt-get update \
    && apt-get install -y \
    curl \
    sudo \
    git \
    jq \
    unzip \
    tar \
    gnupg2 \
    apt-transport-https \
    ca-certificates  \
    buildah \
    runc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl "https://awscli.amazonaws.com/awscli-exe-${AWC_CLI_VERSION}.zip" -o "awscliv2.zip" \ 
    && unzip awscliv2.zip \
    && ./aws/install 

RUN useradd -m github && \
    usermod -aG sudo github && \
    echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER github
WORKDIR ${RUNNER_WORKDIR}

RUN curl -O -L https://github.com/actions/runner/releases/download/v$RUNNER_VERSION/actions-runner-linux-x64-$RUNNER_VERSION.tar.gz
RUN tar xzf ./actions-runner-linux-x64-$RUNNER_VERSION.tar.gz
RUN sudo ./bin/installdependencies.sh
RUN chown -R github:github ${RUNNER_WORKDIR}

COPY --chown=github:github ./debian/entrypoint.sh ./entrypoint.sh
RUN sudo chmod u+x ./entrypoint.sh

ENTRYPOINT ["/home/github/entrypoint.sh"]