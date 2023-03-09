FROM ubuntu:20.04
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -qq --no-install-recommends \
    apt-transport-https \
    apt-utils \
    ca-certificates \
    curl \
    git \
    iputils-ping \
    jq \
    lsb-release \
    software-properties-common

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Add self-signed certificate to trusted root certificates
COPY nginx-selfsigned.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates

# Install Node.js
RUN curl -sL https://deb.nodesource.com/setup_19.x | bash -
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -qq --no-install-recommends \
    nodejs

# Install pnpm
RUN npm install -g pnpm

# Install Yarn
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -qq --no-install-recommends \
    yarn


# Set NPM registry
RUN npm config set registry http://verdaccio:4873

# This needs to be fixed, nuget package restore needs to be done so that the packages can be fetched from the devops feed and nuget.org
# # Install .NET Core SDK
# RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg
# RUN mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/
# RUN curl -sL https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/microsoft-prod.list
# RUN DEBIAN_FRONTEND=noninteractive apt-get update
# RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -qq --no-install-recommends \
#     dotnet-sdk-7.0

# Can be 'linux-x64', 'linux-arm64', 'linux-arm', 'rhel.6-x64'.
ENV TARGETARCH=linux-x64

WORKDIR /azp

COPY vsts-agent-linux-x64-2.*.*.tar.gz .
RUN tar -xzf vsts-agent-linux-x64-2.*.*.tar.gz

COPY ./start.sh .
RUN chmod +x start.sh

ENTRYPOINT [ "./start.sh" ]