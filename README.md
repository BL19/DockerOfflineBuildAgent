# DockerOfflineBuildAgent
A azure build agent for docker that is offline

## Features
- The build agent does not connect to the internet directly
- Has a npm package cache common for all replicas of the agent
- Automatically registers in the agent pool configured in docker-compose.yml


## Setup
1. Run `setup.sh`
2. Change your devops host in `relay-nginx.conf`
3. (Optional) Configure npm registry for custom packages
4. Run `cp .env.example .env`
5. Change the `AZP_TOKEN` in `.env` to a PAT from your Azure Devops Server. This token should have permissions to manage agent pools in that collection.
6. (Optional) Change number of replicas for the build containers
7. Run `docker-compose up -d`

## Tools
- Node.js 19
- npm
- yarn
- pnpm