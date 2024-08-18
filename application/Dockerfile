# base on default node 20 image
FROM node:20-alpine

# bash shadow and sudo required for run-with-current-user-ids.sh
RUN apk --no-cache add bash shadow
RUN set -ex && apk --no-cache add sudo

RUN corepack enable

ARG workdir=/home/node/app

# Create app directory
WORKDIR ${workdir}

# Will not be available to node user if not installed as node user
# meaning that when yarn is run as node user, it will not be able
# to find the yarn binary
USER node
RUN corepack install --global yarn@4.1.1
USER root

# Install app dependencies
COPY package*.json ./
COPY yarn.lock ./
RUN yarn

COPY --chmod=744 run-with-current-user-ids.sh ./

# Bundle app source
COPY src/ ./src/

RUN chown -R node:node ${workdir}

CMD [ "bash", "run-with-current-user-ids.sh", "yarn", "start" ]