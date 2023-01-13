# Dev container

## Container features (Configured)

The current dev container has the following configured features:
- linux dev environment（based on https://github.com/devcontainers/images/tree/main/src/cpp）
- zsh (default: true)
- Python 3 (default: true)
- Docker in docker (default: true)
- Vcpkg (default: true)
- Kubectl, Helm and Minkikube (default: true)
- GitHub CLI (default: false)

## Dockerfiles
There are some dockerfiles for the devcontainer, the differences are as follows：
### Dockerfile.dev (default: no any features)
- When `features` is commented in `.devcontainer\devcontainer.json`, default to no any features.
- When `features` is uncommented in `.devcontainer\devcontainer.json, features are enabled in build stage and requires github access.
### Dockerfile.dev-features (default: features included)
- The script has built-in features and does not require github access to the build. At this point, no need to open the 'features' in 'devcontainer.json' repeats the build of features.
### Using built image
Do not build image, but use the built image, can be directly in the 'devcontainer.json' image configuration use.

> [!IMPORTANT]
> Using a built development image, comment 'build' in 'devcontainer.json' and add the image to be used to 'image'.

The built images are listed below:
- `msclock/commoncpp:2023.1.6`: ubuntu:22.04, with features.
- `msclock/commoncpp:2023.1.9`: debian:11, with features.


## Usage

### Devcontainer reference

- https://code.visualstudio.com/docs/devcontainers/containers
