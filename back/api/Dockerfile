###################
# BUILD FOR LOCAL DEVELOPMENT
###################

FROM node:18-alpine As development

WORKDIR /usr/src/app

#COPY --chown=node:node package*.json ./
COPY --chown=node:node . .

RUN npm ci


USER node

###################
# BUILD FOR PRODUCTION
###################

FROM node:18-alpine As build

WORKDIR /usr/src/app

#COPY --chown=node:node package*.json ./
COPY --chown=node:node . .

COPY --chown=node:node --from=development /usr/src/app/node_modules ./node_modules


RUN npm run build

ENV NODE_ENV production

RUN npm ci --only=production && npm cache clean --force

USER node

###################
# PRODUCTION
###################

FROM node:18-alpine As production

RUN apk update && apk add tzdata
ENV TZ="America/Mexico_City"

COPY --chown=node:node --from=build /usr/src/app/node_modules ./node_modules
COPY --chown=node:node --from=build /usr/src/app/dist ./dist

EXPOSE 3000


CMD ["node", "dist/main.js" ]