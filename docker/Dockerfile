ARG NODE_VERSION=16
ARG PHP_VERSION=8.1
ARG CONTAINER_REGISTRY=ghcr.io/maxvast

FROM ${CONTAINER_REGISTRY}/build-php${PHP_VERSION}:latest AS php_builder
WORKDIR /app

RUN mkdir -p ssl; \
    openssl req -x509 -nodes -sha256 -days 3650 -newkey rsa:2048 \
        -keyout ssl/server.key \
        -out ssl/server.crt \
        -subj "/C=EN/L=London/O=Suzuki Care/OU=Production/CN=*.*"

FROM node:${NODE_VERSION}-alpine as builder
WORKDIR /app
RUN apk update && apk add python3 make g++
# Write config in .env
RUN touch ./.env
ARG CHAIN_ID
ARG ADDRESS_CONTRACT

RUN echo "CHAIN_ID=${CHAIN_ID}" >> ./.env; \
    echo "ADDRESS_CONTRACT=${ADDRESS_CONTRACT}" >> ./.env; \
    cat ./.env

#RUN echo "CHAIN_ID=0x5" >> ./.env; \
#    echo "ADDRESS_CONTRACT=0xb00C92F8bB0E9921004d79b567D1976D2797375c" >> ./.env; \
#    cat ./.env

COPY --from=php_builder /app/ssl  /etc/ssl
COPY nuxt.config.js ./
COPY package.json ./
COPY yarn.lock ./
COPY components components/
COPY pages pages/
COPY static static/
COPY store store/
COPY artifacts artifacts/
COPY cache cache/
COPY contracts contracts/

RUN set -eux; \
  yarn install --prefer-offline --frozen-lockfile --non-interactive --production=false

RUN yarn build

ARG NODE_ENV
ENV NODE_ENV=${NODE_ENV}

RUN set -eux; \
	if [ "${NODE_ENV}" = 'production' ]; then \
    NODE_ENV=production yarn install --prefer-offline --pure-lockfile --non-interactive --production=true; \
	fi

FROM node:${NODE_VERSION}-alpine as nodejs
WORKDIR /app
COPY --from=builder /app  .
COPY --from=php_builder /app/ssl  /etc/ssl

ENV HOST 0.0.0.0
EXPOSE 3000

CMD ["yarn", "start"]
