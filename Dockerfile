FROM alpine:3.13 AS builder


RUN apk add --no-cache \
    ca-certificates \
    gnupg \
    curl \
    gcompat \
    git \
    git-lfs \
    unzip \
    bash \
    openssh \
    libcap \
    openssl \
    python3 \
    py3-pycryptodome \
    py3-requests \
    py3-yaml \
    openssh

COPY install-terraform-version /install-terraform-version

ENV DEFAULT_TERRAFORM_VERSION=1.1.2

# Other versions
# 0.8.8 0.9.11 0.10.8 0.11.15 0.12.31 0.13.7 0.14.11 0.15.5 1.0.7

RUN /install-terraform-version latest

# Install awscli v2
ENV AWS_CLI_VER=2.0.30
RUN curl -s https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWS_CLI_VER}.zip -o awscliv2.zip && \
    unzip awscliv2.zip && ./aws/install

ADD https://github.com/gruntwork-io/terragrunt/releases/download/v0.36.10/terragrunt_linux_amd64 /usr/local/bin/terragrunt

RUN chmod +x /usr/local/bin/terragrunt

FROM builder AS build1

COPY entrypoint.sh /entrypoint.sh
COPY terrat_runner /terrat_runner

ENTRYPOINT ["/entrypoint.sh"]
