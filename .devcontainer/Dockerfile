ARG VARIANT="jammy"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

# Install OS packages
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    make

ARG TERRAFORM_DOCS_VERSION=${TERRAFORM_DOCS_VERSION}
ARG TFSEC_VERSION=${TFSEC_VERSION}
ARG TERRASCAN_VERSION=${TERRASCAN_VERSION}
ARG TFLINT_AWS_RULESET_VERSION=${TERRASCAN_VERSION}

RUN cd /tmp/ \
    && git clone https://github.com/awslabs/aws-code-habits.git \
    && cd aws-code-habits \
    && make devcontainer/terraform/init \
    && rm -rf /tmp/aws-code-habits

USER root

COPY post-start.sh /usr/local/bin/post-start
RUN chmod +x /usr/local/bin/post-start
