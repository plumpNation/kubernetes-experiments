# base on default node 20 image
FROM node:20-alpine

RUN corepack enable
RUN corepack install --global yarn@4.1.1

# bash shadow and sudo required for run-with-current-user-ids.sh
RUN apk --no-cache add bash shadow
RUN set -ex && apk --no-cache add sudo

# Create app directory
WORKDIR /usr/src/app

COPY run-with-current-user-ids.sh /usr/src/app
RUN chown node:node /usr/src/app/run-with-current-user-ids.sh
RUN chmod +x /usr/src/app/run-with-current-user-ids.sh

# Install app dependencies
COPY package*.json ./
COPY yarn.lock ./

RUN yarn

# Bundle app source
COPY src/ ./src/

# EXPOSE 3000

CMD [ "./run-with-current-user-ids.sh", "yarn", "start" ]