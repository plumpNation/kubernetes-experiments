# base on default node 20 image
FROM node:20-alpine

# bash shadow and sudo required for run-with-current-user-ids.sh
RUN apk --no-cache add bash shadow
RUN set -ex && apk --no-cache add sudo

RUN corepack enable

ARG workdir=/home/node/app

# Create app directory
WORKDIR ${workdir}
RUN chown node:node ${workdir}

USER node
# Install app dependencies
RUN corepack install --global yarn@4.1.1
COPY package*.json ./
COPY yarn.lock ./
COPY .yarnrc.yml ./
RUN yarn

COPY src/ ./src/

USER root
# Make all the contents except the entrypoint script owned by node user
RUN chown -R node:node ${workdir}

COPY --chmod=744 docker/entrypoint.sh ./

ENTRYPOINT [ "./entrypoint.sh" ]

CMD ["yarn", "start"]