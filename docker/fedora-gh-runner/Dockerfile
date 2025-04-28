FROM fedora:42

LABEL description="GitHub Actions Runner on Fedora"

# dependencies
RUN dnf -y update && \
    dnf -y install \
    lttng-ust \
    openssl-libs \
    krb5-libs \
    zlib \
    libicu \
    curl \
    tar \
    gzip \
    git \
    sudo && \
    dnf clean all

# setup runner user and passwordless sudo
RUN useradd -m runner && \
    echo "runner ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    usermod -aG wheel runner
USER runner

# setup runner
WORKDIR /home/runner/actions-runner

RUN curl -O -L https://github.com/actions/runner/releases/download/v2.323.0/actions-runner-linux-x64-2.323.0.tar.gz && \
    tar xzf ./actions-runner-linux-x64-2.323.0.tar.gz && \
    rm -f actions-runner-linux-x64.tar.gz

COPY --chown=docker:docker entrypoint.sh /home/runner/entrypoint.sh

ENTRYPOINT ["/home/runner/entrypoint.sh"]
