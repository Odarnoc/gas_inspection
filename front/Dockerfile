# develop stage
FROM node:18-alpine as develop-stage
WORKDIR /app
COPY ./web/package*.json ./
RUN yarn global add @quasar/cli
COPY ./web/. .

# build stage
FROM develop-stage as build-stage
ARG BuildEnv

RUN yarn
RUN PROD=true quasar build
#RUN quasar build

# production stage
FROM nginx:1.17.5-alpine as production-stage
COPY ./conf.d /etc/nginx/conf.d
COPY --from=build-stage /app/dist/spa /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

