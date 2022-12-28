# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.195.0/containers/cpp/.devcontainer/base.Dockerfile
# [Choice] Debian / Ubuntu version (use Debian 11/9, Ubuntu 18.04/21.04 on local arm64/Apple Silicon): debian-11, debian-10, debian-9, ubuntu-21.04, ubuntu-20.04, ubuntu-18.04
ARG VARIANT=debian-11
FROM mcr.microsoft.com/vscode/devcontainers/cpp:${VARIANT}

RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak \
    && sed -i 's|http://archive.ubuntu.com/ubuntu|http://mirrors.huaweicloud.com/repository/ubuntu|g' /etc/apt/sources.list \
    && apt-get update && apt-get install -y apt-transport-https ca-certificates

# [Optional] Uncomment this section to install additional packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>
