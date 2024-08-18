# base on default node 20 image
FROM node:20-alpine

# bash shadow and sudo required for run-with-current-user-ids.sh
RUN apk --no-cache add bash shadow
RUN set -ex && apk --no-cache add sudo

RUN corepack enable
RUN corepack install --global yarn@4.1.1

ARG workdir=/home/node/app

# Create app directory
WORKDIR ${workdir}

# Install app dependencies
COPY package*.json ./
COPY yarn.lock ./
COPY .yarnrc.yml ./
RUN yarn

COPY --chmod=744 run-with-current-user-ids.sh ./

# Bundle app source
COPY src/ ./src/

RUN chown -R node:node ${workdir}

ENTRYPOINT [ "./run-with-current-user-ids.sh" ]

CMD ["yarn", "start"]