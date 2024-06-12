# the base image
FROM node:20 AS base
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install

# the dev image, using above as base image
FROM base AS development
COPY . .
CMD ["npm", "run", "dev"]

# the production image
FROM base AS production
COPY . .
RUN npm prune --production
CMD ["npm", "run", "start"]


