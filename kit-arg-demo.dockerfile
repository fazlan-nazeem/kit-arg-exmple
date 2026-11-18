ARG BASE_IMAGE=debian:trixie-slim
FROM ${BASE_IMAGE}

# Platform floor required by sbx workloads: bash, curl, git, CA store,
# and a non-root "agent" user (uid 1000, home /home/agent).
RUN apt-get update \
 && apt-get install -y --no-install-recommends bash curl git ca-certificates \
 && rm -rf /var/lib/apt/lists/* \
 && useradd --create-home --uid 1000 --shell /bin/bash agent

# Proof of which base was used: written at build time.
RUN cat /etc/debian_version > /home/agent/kit-base-version \
 && chown agent:agent /home/agent/kit-base-version

USER agent
WORKDIR /home/agent
CMD ["bash"]
